{ pkgs, lib, config, inputs, ... }:

{
  devcontainer.enable = true;

  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
    gh
    claude-code
  ];

  # https://devenv.sh/languages/
  languages.ruby = {
    enable = true;
    bundler.enable = true;
  };

  # Claude Code MCP configuration
  claude.code = {
    enable = true;

    mcpServers = {
      devenv = {
        type = "stdio";
        command = "devenv";
        args = [ "mcp" ];
        env = {
          DEVENV_ROOT = config.devenv.root;
        };
      };
    };
  };

  # https://devenv.sh/processes/
  processes.jekyll.exec = "bundle exec jekyll serve --livereload";

  # https://devenv.sh/scripts/
  scripts.build.exec = "bundle exec jekyll build";

  enterShell = ''
    echo "Jekyll dev environment ready!"
    echo "Run 'devenv up' to start the Jekyll server with live reload"
    echo "Run 'build' to build the site"
  '';
}
