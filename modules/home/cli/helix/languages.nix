{
  lib,
  pkgs,
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
      language-servers = ["pyright" "ty"];
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
            dialect = mysql

            [sqlfluff:indentation]
            indented_joins = True
            indented_using_on = True
            allow_implicit_indents = True
          '';
      in {
        command = "sqlfluff";
        args = ["format" "-" "--dialect" "mysql" "--disable-progress-bar" "--config" config];
      };
    }
  ];

  language-server = {
    rust-analyzer.config = {
      assist.emitMustUse = true;
      assist.expressionFillDefault = "todo";
      assist.termSearch.borrowcheck = false;
      assist.termSearch.fuel = 100;
      cache.warmup = true;
      cachePriming.numThreads = 12;
      cargo.buildScripts.enable = false;
      cargo.noDeps = true;
      diagnostics.disabled = ["proc-macro-disabled" "missing_safety_doc"];
      diagnostics.styleLints.enable = true;
      files.excludeDirs = [".git" ".github" "target" "assets" "static" "dist"];
      files.watcher = "server";
      imports.granularity.group = "module";
      imports.preferPrelude = true;
      lru.capacity = 512;
      numThreads = 12;
      references.excludeImports = true;
      references.excludeTests = true;

      hover = {
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
        invocationStrategy = "once";
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
        bindingModeHints.enable = false;
        closingBraceHints.minLines = 15;
        closureCaptureHints.enable = true;
        closureReturnTypeHints.enable = "with_block";
        discriminantHints.enable = "fieldless";
        expressionAdjustmentHints.enable = "never"; # always | never | reborrow
        expressionAdjustmentHints.hideOutsideUnsafe = false;
        expressionAdjustmentHints.mode = "prefer_prefix"; # prefix | postfix | prefer
        genericParameterHints.lifetime.enable = true;
        genericParameterHints.type.enable = false;
        implicitDrops.enable = true;
        implicitSizedBoundHints.enable = false;
        lifetimeElisionHints.enable = "skip_trivial";
        lifetimeElisionHints.useParameterNames = false;
        maxLength = 24;
        parameterHints.enable = false;
        rangeExclusiveHints.enable = true;
        renderColons = false;
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
            expr = ''(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.${hostname}.options'';
          };
          home_manager = {
            expr = ''(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.${hostname}.options'';
          };
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
      args = ["--header-insertion=never"];
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
      command = lib.getExe (pkgs.sqls.overrideAttrs {
        src = pkgs.fetchFromGitHub {
          owner = "camfowler";
          repo = "sqls";
          rev = "bugfix/omit-document-when-empty";
          hash = "sha256-Lf7bP3Fl+cTFFRgnOkggUyp/e4CL25XYRhUsB6Hg2mI=";
        };
        vendorHash = "sha256-8jzecLaVUMlIJC2neb5XfvpBYIkkXnzvzq175ZBAnLo=";
      });
    };
  };
}
