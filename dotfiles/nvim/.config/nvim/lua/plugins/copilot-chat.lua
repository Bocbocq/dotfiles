return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = function(_, opts)
    local user = vim.env.USER or "User"
    user = user:sub(1, 1):upper() .. user:sub(2)
    opts.model = "claude-sonnet-4.5"
    opts.resources = { "buffer", "selection" }
    opts.window = {
      width = 0.35,
    }
    opts.headers = {
      user = " " .. user .. " ",
      assistant = " Copilot ",
    }
    opts.show_help = false
  end,
}
