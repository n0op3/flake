{ ... }: {
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "kernel.panic" = 10;
    "kernel.panic_on_oops" = 1;
  };
}
