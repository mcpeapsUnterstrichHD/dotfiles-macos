-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "css-lsp",

        "html-lsp",
        "json-lsp",
        "typescript-language-server",

        -- install formatters
        "stylua",
        "prettier",
        "shfmt",
        "black",
        "isort",
        "clang-format",
        "sql-formatter",
        "rustfmt",

        -- install debuggers
        "debugpy",
        "codelldb",
        "java-debug-adapter",

        -- install linters
        "shellcheck",
        "eslint_d",
        "flake8",
        "mypy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
