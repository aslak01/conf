local null_ls_status_ok, null_ls = pcall(require, 'null_ls')
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting

require("null-ls").setup({
  debug = false,
  sources = {
    formatting.prettier.with({ extra_args = { "--no-semi", "--single" } })
    -- require("null-ls").builtins.formatting.stylua,
    -- require("null-ls").builtins.diagnostics.eslint,
    -- require("null-ls").builtins.completion.spell,
  },
})
