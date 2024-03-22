
{pkgs, ...}:
{
  xdg = {
    configFile.nvim.source = ../nvim;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      git
      nil
      lua-language-server
      gcc
      gnumake
      unzip
      wget
      curl
      tree-sitter
      ripgrep
      fd
      fzf
    ];
  };
}
