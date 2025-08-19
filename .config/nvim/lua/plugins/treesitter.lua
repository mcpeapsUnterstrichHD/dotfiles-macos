--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "bash",
      "c",
      "cpp",
      "css",
      "dockerfile",
      "html",
      "javascript",
      "json",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "rust",
      "sql",
      "typescript",
      "tsx",
      "yaml",
      "java",

      -- add more arguments for adding more treesitter parsers
    },
  },
}
