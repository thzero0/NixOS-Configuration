{
  
  programs.neovim.enable = true;

  xdg = {
    configFile.nvim.source = ../nvim
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

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
}
