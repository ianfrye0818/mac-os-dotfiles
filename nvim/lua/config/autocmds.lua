-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*.cs",
  callback = function()
    local filename = vim.fn.expand("%:t:r") -- file name without extension
    local namespace = vim.fn.expand("%:p:h:t") -- folder name as a namespace (optional)
    local lines = {
      string.format("namespace %s;", namespace),
      "",
      string.format("public class %s", filename),
      "{",
      "     ",
      "}",
    }

    -- Only insert if the file is empty
    if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      vim.cmd("normal! G") -- jump to end
      vim.cmd("normal! O") -- open a new line inside the class
    end
  end,
})
