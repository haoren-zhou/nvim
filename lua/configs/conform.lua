local options = {
  formatters_by_ft = {
    css = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier", "injected" },
    quarto = { "injected" },

    cpp = { "clang_format" },
    c = { "clang_format" },
    cmake = { "cmake_format" },

    lua = { "stylua" },
    nix = { "alejandra" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    tex = { "tex-fmt" },
    ocaml = { "ocamlformat" },
    java = { "google-java-format" },
  },

  formatters = {
    injected = {
      options = {
        -- Set to true to ignore errors
        ignore_errors = false,
        -- Map of treesitter language to filetype
        lang_to_ft = {
          bash = "sh",
        },
        -- Map of treesitter language to file extension
        -- A temporary file name with this extension will be generated during formatting
        -- because some formatters care about the filename.
        lang_to_ext = {
          bash = "sh",
          c_sharp = "cs",
          elixir = "exs",
          javascript = "js",
          julia = "jl",
          latex = "tex",
          markdown = "md",
          ocaml = "ml",
          python = "py",
          ruby = "rb",
          rust = "rs",
          teal = "tl",
          typescript = "ts",
        },
      },
    },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
