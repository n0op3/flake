{
  inputs,
  pkgs,
  system,
  ...
}:
let
  fx = inputs.fenix.packages.${system};
  rust-stable = fx.combine [
    fx.stable.rustc
    fx.stable.cargo
    fx.stable.clippy
    fx.stable.rustfmt
    fx.stable.rust-src
    fx.stable.rust-analyzer
    fx.targets.x86_64-pc-windows-msvc.stable.rust-std
  ];
  rust-nightly = fx.combine [
    fx.latest.rustc
    fx.latest.cargo
    fx.latest.clippy
    fx.latest.rustfmt
    fx.latest.rust-src
    fx.latest.rust-analyzer
  ];
in
{
  environment.systemPackages = with pkgs; [
    rust-stable
    (pkgs.runCommand "rust-nightly-bin" { } ''
      mkdir -p $out/bin
      ln -s ${rust-nightly}/bin/cargo $out/bin/cargo-nightly
      ln -s ${rust-nightly}/bin/rustc $out/bin/rustc-nightly
      ln -s ${rust-nightly}/bin/clippy-driver $out/bin/clippy-driver-nightly
      ln -s ${rust-nightly}/bin/cargo-clippy $out/bin/cargo-clippy-nightly
    '')

    bacon
    cargo-xwin
    cargo-audit
    cargo-nextest
    cargo-binstall
    cargo-tarpaulin

    # NOTE: needed for windows cross-compilation, since the default compiler is NixOS-only
    llvmPackages.clang-unwrapped
    llvmPackages.bintools-unwrapped
  ];

  # NOTE: Windows C and C++ compiler variables
  environment.variables = {
    XWIN_CROSS_COMPILER = "clang";
    CC_x86_64_pc_windows_msvc = "${pkgs.llvmPackages.clang-unwrapped}/bin/clang-cl";
    CXX_x86_64_pc_windows_msvc = "${pkgs.llvmPackages.clang-unwrapped}/bin/clang-cl";
    AR_x86_64_pc_windows_msvc = "${pkgs.llvmPackages.bintools-unwrapped}/bin/llvm-lib";
  };
}
