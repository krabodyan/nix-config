{pkgs}: {
  language = [
    {
      name = "nix";
      language-servers = ["nix"];
      formatter = "alejandra";
    }
    {
      name = "svelte";
      comment-token = "//";
      indent = {
        tab-width = 4;
        unit = "\t";
      };
      block-comment-tokens = {
        start = "<!--";
        end = "-->";
      };
      language-servers = ["svelteserver" "tailwindcss"];
      formatter = {
        command = "prettier";
        args = ["--parser" "svelte"];
      };
    }
  ];

  language-server = {
    "svelteserver.config.configuration.typescript" = {
      inlayHints.parameterTypes.enabled = false;
      inlayHints.variableTypes.enabled = false;
      inlayHints.propertyDeclarationTypes.enabled = false;
      inlayHints.functionLikeReturnTypes.enabled = false;
      inlayHints.enumMemberValues.enabled = false;
      inlayHints.parameterNames.enabled = false;
    };
    "nix" = {
      command = "${pkgs.nixd}/bin/nixd";
    };
  };
}
