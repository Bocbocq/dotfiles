return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "cds-lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cds_lsp = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    ---@param opts TSConfig
    opts = function(_, opts)
      -- Add filetype to buffers
      vim.filetype.add({
        extension = {
          cds = "cds",
          cdl = "cds",
          hdbcds = "cds",
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cds",
        callback = function()
          vim.bo.commentstring = "// %s"
        end,
      })

      -- Configure treesitter for CDS
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").cds = {
            install_info = {
              url = "https://github.com/cap-js-community/tree-sitter-cds.git",
              branch = "main",
              queries = "queries/",
            },
          }
        end,
      })

      vim.list_extend(opts.ensure_installed, { "cds" })
    end,
  },
}
