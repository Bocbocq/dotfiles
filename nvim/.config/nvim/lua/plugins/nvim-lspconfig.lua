return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {},
        nil_ls = { enabled = false },
        ruff = {},
        basedpyright = {
          enabled = true,
          settings = {
            basedpyright = {
              analysis = {
                reportMissingTypeStubs = "none",
                reportLineTooLong = "none",
              },
            },
          },
        },
        marksman = {},
      },
    },
  },
}
