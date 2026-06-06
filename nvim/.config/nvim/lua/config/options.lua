-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Native inline completions don't support being shown as regular completions
vim.g.ai_cmp = true

vim.g.lazyvim_python_lsp = "basedpyright"

-- Set to `true` in your `options.lua` to enable experimental support for Next Edit Suggestions
vim.g.copilot_nes = true
-- vim.opt.iskeyword:remove("_")

-- Coalesce multi-phase bracketed paste in terminal buffers so Claude Code
-- sees a single paste event instead of fragmented phases (coder/claudecode.nvim#161)
do
  local chunks = {}
  local orig_paste = vim.paste
  vim.paste = function(lines, phase)
    if vim.bo.buftype ~= "terminal" or phase == -1 then
      return orig_paste(lines, phase)
    end
    if phase == 1 then chunks = {} end
    for _, line in ipairs(lines) do chunks[#chunks + 1] = line end
    if phase == 3 then
      local buffered = chunks
      chunks = {}
      return orig_paste(buffered, -1)
    end
    return true
  end
end
