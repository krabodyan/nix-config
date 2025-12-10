{
  lib,
  pkgs,
  username,
  hostname,
}: {
  language = [
    {
      name = "nix";
      language-servers = ["nix"];
      formatter.command = lib.getExe pkgs.alejandra;
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
        command = "prettier";
        args = ["--parser" "svelte"];
      };
    }
    {
      name = "python";
      language-servers = ["pyright"];
      formatter = {
        command = "ruff";
        args = ["format" "-"];
      };
    }
    {
      name = "yaml";
      file-types = ["yaml" "yml"];
      language-servers = ["yaml-language-server"];
      formatter = {
        command = "prettier";
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
        command = "prettier";
        args = ["--parser" "html"];
      };
    }
    {
      name = "tsx";
      language-servers = ["typescript-language-server"];
      formatter = {
        command = "prettier";
        args = ["--parser" "html"];
      };
    }
    {
      name = "typescript";
      language-servers = ["typescript-language-server"];
      roots = ["package-lock.json" "tsconfig.json" ".prettierrc.json"];
      formatter = {
        command = "prettier";
        args = ["--parser" "typescript"];
      };
    }
    {
      name = "cpp";
      indent = {
        tab-width = 4;
        unit = "\t";
      };
      language-servers = ["clang"];
      formatter.command = "clang-format";
    }
    {
      name = "cmake";
      indent = {
        tab-width = 4;
        unit = "\t";
      };
      language-servers = ["neocmakelsp"];
      formatter = {
        command = "cmake-format";
        args = ["-" "-o" "-"];
      };
    }
    {
      name = "toml";
      roots = ["."];
      formatter = {
        command = "taplo";
        args = ["fmt" "-"];
      };
    }
    {
      name = "bash";
      formatter = {
        command = "shfmt";
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
        command = "nginxfmt";
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
    {
      name = "just";
      formatter = {
        command = "just-formatter";
      };
    }
    {
      name = "sql";
      language-servers = ["sql"];
      formatter = let
        config =
          pkgs.writeText "sqlfluff"
          # ini
          ''
            [sqlfluff]
            dialect = postgres

            [sqlfluff:indentation]
            indented_joins = True
            indented_using_on = True
            allow_implicit_indents = True
          '';
      in {
        command = "sqlfluff";
        args = ["format" "-" "--dialect" "postgres" "--disable-progress-bar" "--config" config];
      };
    }
  ];

  language-server = {
    rust-analyzer.config = {
      assist.emitMustUse = true;
      assist.expressionFillDefault = "default";
      assist.termSearch.enable = false;
      # assist.termSearch.borrowcheck = false;
      # assist.termSearch.fuel = 100;

      cachePriming.enable = true;
      cachePriming.numThreads = 0;

      cargo.targetDir = true;
      cargo.buildScripts.enable = false;
      cargo.buildScripts.rebuildOnSave = false;
      cargo.noDefaultFeatures = true;
      cargo.autoreload = true;
      cargo.noDeps = false;

      diagnostics.disabled = ["proc-macro-disabled"];
      diagnostics.styleLints.enable = true;

      files.excludeDirs = [".git" ".github" "target" "assets" "static" "dist"];
      files.watcher = "server";

      imports.granularity.group = "module";
      imports.preferPrelude = true;

      lru.capacity = 512;
      numThreads = 0;

      references.excludeImports = true;
      references.excludeTests = true;

      hover = {
        links.enable = false;
        actions.enable = false;
        lens.enable = false;
        memoryLayout.enable = false;
        show.enumVariants = 10;
        show.fields = 10;
        show.traitAssocItems = 10;
      };

      check = {
        allFeatures = false;
        allTargets = false;
        command = "clippy";
        extraArgs = ["--tests" "--no-deps" "--" "-W" "clippy::pedantic"];
        invocationStrategy = "per_workspace";
        ignore = [
          "clippy::missing_errors_doc"
          "clippy::missing_safety_doc"
          "clippy::missing_panics_doc"
          "clippy::cast_possible_truncation"
          "clippy::cast_precision_loss"
          "clippy::cast_possible_wrap"
          "clippy::cast_sign_loss"
        ];
        noDefaultFeatures = true;
      };

      procMacro = {
        ignored.async_trait = ["async_trait"];
        ignored.embassy_executor_macros = ["main"];
        ignored.pyo3_macros = ["pymodule" "pyfunction"];
        ignored.tauri_macros = ["command" "generate_handler"];
        ignored.tokio_macros = ["main"];
      };

      completion = {
        addSemicolonToUnit = false;
        autoAwait.enable = false;
        autoIter.enable = true;
        autoimport.enable = true;
        autoself.enable = false;
        callable.snippets = "add_parentheses";
        hideDeprecated = true;
        postfix.enable = false;
      };

      inlayHints = {
        maxLength = 12;

        renderColons = false;
        parameterHints.enable = false;
        bindingModeHints.enable = true;
        rangeExclusiveHints.enable = true;

        closingBraceHints.minLines = 8;
        closureCaptureHints.enable = false;
        closureReturnTypeHints.enable = "with_block";

        discriminantHints.enable = "fieldless";

        expressionAdjustmentHints.enable = "never"; # always | never | reborrow
        expressionAdjustmentHints.hideOutsideUnsafe = false;
        expressionAdjustmentHints.disableReborrows = true;
        expressionAdjustmentHints.mode = "prefer_prefix"; # prefix | postfix | prefer

        genericParameterHints.lifetime.enable = true;
        genericParameterHints.const.enable = true;
        genericParameterHints.type.enable = false;

        implicitDrops.enable = false;
        implicitSizedBoundHints.enable = false;

        lifetimeElisionHints.enable = "skip_trivial";
        lifetimeElisionHints.useParameterNames = false;

        typeHints.enable = true;
        typeHints.hideClosureInitialization = true;
        typeHints.hideNamedConstructor = true;
      };
    };

    nix = {
      command = "${pkgs.nixd}/bin/nixd";
      args = ["--log=error"];
      config.nixd = {
        nixpkgs = {
          expr = "import <nixpkgs> { }";
        };
        options = {
          nixos = {
            expr = ''(builtins.getFlake "/home/${username}/flake").nixosConfigurations.${hostname}.options'';
          };
          home-manager = {
            expr = ''(builtins.getFlake "/home/${username}/flake").homeConfigurations.${hostname}.options'';
          };
          # flake-parts = {
          #   expr = ''(builtins.getFlake "/home/${username}/flake").debug.options'';
          # };
          # flake-parts2 = {
          #   expr = ''(builtins.getFlake "/home/${username}/flake").currentSystem.options'';
          # };
        };
      };
    };

    svelteserver = {
      config.configuration.typescript = {
        inlayHints.parameterTypes.enabled = false;
        inlayHints.variableTypes.enabled = false;
        inlayHints.propertyDeclarationTypes.enabled = false;
        inlayHints.functionLikeReturnTypes.enabled = false;
        inlayHints.enumMemberValues.enabled = false;
        inlayHints.parameterNames.enabled = false;
      };
    };

    yaml-language-server = {
      config.yaml = {
        format.enable = true;
        hover = true;
        completion = true;
        suggest.parentSkeletonSelectedFirst = true;
      };
    };

    json = {
      command = "vscode-json-language-server";
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

    ruff = {
      command = "ruff";
      args = ["server" "--silent"];
    };

    ty = {
      command = "ty";
      args = ["server"];
    };

    pyright = {
      command = "pyright-langserver";
      args = ["--stdio"];
    };

    biome = {
      command = "biome";
      args = ["lsp-proxy"];
    };

    clang = {
      command = "clangd";
      args = [
        "--background-index"
        "--header-insertion=never"
        "--header-insertion-decorators"
        "--completion-style=detailed"
        "--all-scopes-completion"
        "--fallback-style=LLVM"
        "--function-arg-placeholders=false"
        "--clang-tidy"
        "--log=error"
      ];
    };

    nginx = {
      command = "nginx-language-server";
      args = ["--log-file" "/dev/null"];
    };

    terraform-ls = {
      command = "terraform-ls";
      args = ["serve" "-log-file" "/dev/null"];
    };

    sql = {
      command = "sqls";
    };

    neocmakelsp = {
      init_options = {
        lint = {
          enable = true;
        };
        scan_cmake_in_package = true;
        semantic_token = false;
      };
    };
  };
}
