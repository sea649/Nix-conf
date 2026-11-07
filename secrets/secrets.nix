let
  publicKeys = {
    steamdeck = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIKFx2kSFtKKl9aYFFf9wZ12epihqO6ljCTH1eUAI49f root@steamdeck";
    laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5DrxJo7BDoIEDrTTZAiibGlWkJSE82yIp2cLieBA/X root@laptop";
    recovery = "age1jps384fff37gxpmhmaw2jejmv05z4s0g0jaqehaxhnqj3e4ya9tqg97s57";
  };

  all = builtins.attrValues publicKeys;
in {
  "vfs-yazi.age".publicKeys = all;
  "newsFlash.age".publicKeys = all;
}
