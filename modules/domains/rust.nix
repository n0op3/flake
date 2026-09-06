{ pkgs, ... }: {
  home.packages = with pkgs; [
    bacon
    cargo-xwin
    cargo-audit
    cargo-nextest
    cargo-binstall
    cargo-tarpaulin
    (pkgs.fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
      "rust-analyzer"
    ])
  ];
}
