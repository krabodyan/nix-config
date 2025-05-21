{
  pkgs,
  lib,
}: {
  language = [
    {
      name = "nix";
      language-servers = ["nix"];
      formatter = {
        command = lib.getExe pkgs.alejandra;
      };
    }
    {
      name = "rust";
      auto-pairs = {
        "\"" = "\"";
        "(" = ")";
        "<" = ">";
        "[" = "]";
        "`" = "`";
        "{" = "}";
        "|" = "|";
      };
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
      language-servers = ["svelteserver" "tailwindcss-ls"];
      formatter = {
        command = lib.getExe pkgs.nodePackages.prettier;
        args = ["--parser" "svelte"];
      };
    }
    {
      name = "python";
      language-servers = ["jedi" "ruff"];
      formatter = {
        command = lib.getExe pkgs.black;
        args = ["--line-length" "88" "--quiet" "-"];
      };
    }
    {
      name = "yaml";
      file-types = ["yaml" "yml"];
      language-servers = ["yaml-language-server"];
      formatter = {
        command = lib.getExe pkgs.nodePackages.prettier;
        args = ["--parser" "yaml"];
      };
    }
    {
      name = "json";
      language-servers = ["json" "biome"];
    }
    {
      name = "html";
      formatter = {
        command = lib.getExe pkgs.nodePackages.prettier;
        args = ["--parser" "html"];
      };
    }
    {
      name = "tsx";
      language-servers = ["typescript-language-server"];
      formatter = {
        command = lib.getExe pkgs.nodePackages.prettier;
        args = ["--parser" "html"];
      };
    }
    {
      name = "typescript";
      language-servers = ["typescript-language-server"];
      roots = ["package-lock.json" "tsconfig.json" ".prettierrc.json"];
      formatter = {
        command = lib.getExe pkgs.nodePackages.prettier;
        args = ["--parser" "typescript"];
      };
    }
    {
      name = "cpp";
      indent = {
        tab-width = 4;
        unit = "\t";
      };
      formatter.command = "clang-format";
    }
    {
      name = "toml";
      roots = ["."];
      formatter = {
        command = "taplo";
        args = ["fmt"];
      };
    }
    {
      name = "bash";
      formatter = {
        command = lib.getExe pkgs.shfmt;
        args = [
          "--case-indent"
          "--space-redirects"
          "-"
        ];
      };
    }
    {
      name = "nginx";
      language-servers = ["nginx"];
      formatter = {
        command = lib.getExe pkgs.nginx-config-formatter;
        args = ["--pipe"];
      };
    }
    {
      name = "gas";
      indent = {
        tab-width = 4;
        unit = "\t";
      };
    }
  ];

  language-server = {
    rust-analyzer.config = {
      cache.warmup = true;
      cachePriming.numThreads = 12;
      numThreads = 12;
      lru.capacity = 512;
      cargo.buildScripts.enable = false;
      cargo.noDeps = true;
      imports.granularity.group = "module";
      imports.preferPrelude = true;
      references.excludeTests = true;
      references.excludeImports = true;
      diagnostics.disabled = ["proc-macro-disabled" "missing_safety_doc"];
      diagnostics.styleLints.enable = true;
      assist.expressionFillDefault = "todo";
      assist.termSearch.borrowcheck = false;
      assist.termSearch.fuel = 100;
      assist.emitMustUse = true;
      files.excludeDirs = [".git" ".github" "target" "assets" "static" "dist"];
      files.watcher = "server";

      hover = {
        show.fields = 10;
        show.enumVariants = 10;
        show.traitAssocItems = 10;
        actions.enable = false;
        memoryLayout.enable = false;
        lens.enable = false;
      };

      check = {
        command = "clippy";
        extraArgs = ["--tests" "--no-deps"];
        invocationStrategy = "once";
        noDefaultFeatures = true;
        allTargets = false;
        allFeatures = false;
      };

      procMacro = {
        ignored.tauri_macros = ["command" "generate_handler"];
        ignored.pyo3_macros = ["pymodule" "pyfunction"];
        ignored.async_trait = ["async_trait"];
        ignored.tokio_macros = ["main"];
        ignored.embassy_executor_macros = ["main"];
      };

      completion = {
        autoAwait.enable = false;
        autoIter.enable = true;
        autoimport.enable = true;
        hideDeprecated = true;
        postfix.enable = false;
        autoself.enable = false;
        callable.snippets = "add_parentheses";
        addSemicolonToUnit = false;
      };

      inlayHints = {
        maxLength = 15;
        renderColons = false;
        implicitDrops.enable = false;
        implicitSizedBoundHints.enable = false;
        lifetimeElisionHints.enable = "skip_trivial";
        lifetimeElisionHints.useParameterNames = false;
        closureReturnTypeHints.enable = "with_block";
        closureCaptureHints.enable = true;
        genericParameterHints.lifetime.enable = true;
        genericParameterHints.type.enable = false;
        expressionAdjustmentHints.mode = "prefer_prefix"; # prefix | postfix | prefer
        expressionAdjustmentHints.enable = "never"; # always | never | reborrow
        expressionAdjustmentHints.hideOutsideUnsafe = false;
        closingBraceHints.minLines = 15;
        parameterHints.enable = false;
        typeHints.enable = true;
        typeHints.hideClosureInitialization = true;
        typeHints.hideNamedConstructor = true;
        rangeExclusiveHints.enable = true;
        discriminantHints.enable = "fieldless";
        bindingModeHints.enable = false;
      };
    };

    nix = {
      command = "${pkgs.nixd}/bin/nixd";
    };

    jedi = {
      command = lib.getExe pkgs.python313Packages.jedi-language-server;
      config = {
        completion = {
          ignorePatterns = ["^__.*?__$"];
        };
        workspace = {
          extraPaths = ["typings/"];
        };
      };
    };

    svelteserver.config.configuration.typescript = {
      inlayHints.parameterTypes.enabled = false;
      inlayHints.variableTypes.enabled = false;
      inlayHints.propertyDeclarationTypes.enabled = false;
      inlayHints.functionLikeReturnTypes.enabled = false;
      inlayHints.enumMemberValues.enabled = false;
      inlayHints.parameterNames.enabled = false;
    };

    yaml-language-server.config.yaml = {
      format.enable = true;
      hover = true;
      completion = true;
      suggest.parentSkeletonSelectedFirst = true;
    };

    json = {
      command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
      except-features = ["format"];
      args = ["--stdio"];
      config.json = {
        validate.enable = true;
        format.enable = true;
        schemas = [
          {
            fileMatch = [
              "tsconfig.json"
              "tsconfig.*.json"
            ];
            url = "https://json.schemastore.org/tsconfig.json";
          }
          {
            fileMatch = [
              "package.json"
            ];
            url = "https://json.schemastore.org/package.json";
          }
        ];
      };
    };

    biome = {
      command = lib.getExe pkgs.biome;
      args = ["lsp-proxy"];
    };

    clangd = {
      command = "${pkgs.clang-tools}/bin/clangd";
      args = ["--header-insertion=never"];
    };

    nginx = {
      command = lib.getExe pkgs.nginx-language-server;
      args = ["--log-file" "/dev/null"];
    };

    terraform-ls = {
      command = lib.getExe pkgs.terraform-ls;
      args = ["serve" "-log-file" "/dev/null"];
    };
  };
}
