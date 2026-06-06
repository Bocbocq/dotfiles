return {
  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },
      },
      formatters = {
        ruff_fix = { command = vim.fn.exepath("ruff") },
        ruff_format = { command = vim.fn.exepath("ruff") },
      },
    },
  },
  -- Linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "flake8" },
      },
      linters = {
        flake8 = {
          cmd = vim.fn.exepath("flake8"),
        },
      },
    },
  },
}
