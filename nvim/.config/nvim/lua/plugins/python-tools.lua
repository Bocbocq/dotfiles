return {
  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
      },
      formatters = {
        black = {
          command = vim.fn.exepath("black"),
        },
        isort = {
          command = vim.fn.exepath("isort"),
        },
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
