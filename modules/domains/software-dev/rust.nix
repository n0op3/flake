{
  inputs,
  pkgs,
  system,
  ...
}:
let
  fx = inputs.fenix.packages.${system};
  rust = fx.combine [
    fx.stable.rustc
    fx.stable.cargo
    fx.stable.clippy
    fx.stable.rustfmt
    fx.stable.rust-src
    fx.stable.rust-analyzer
    fx.targets.x86_64-pc-windows-msvc.stable.rust-std
  ];
in
{
  environment.systemPackages = with pkgs; [
    rust

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
