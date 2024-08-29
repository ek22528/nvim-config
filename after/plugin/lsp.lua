local lsp = require('lsp-zero').preset({"recommended"})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>ca", function () vim.lsp.buf.code_action() end, opts)
end)

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
  ['<Enter>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  sources = {
    {name = 'nvim_lsp'}
  },
  snippet = {
    expand = function (args)
      vim.snippet.expand(args.body)
    end
  },
  mapping = cmp_mappings,
})

lsp.setup_servers({'tsserver', 'eslint', 'pyright', 'gopls', 'clangd', 'hls'})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded",
    close_events = {"CursorMoved", "BufHidden", "InsertCharPre"},
  }
)

vim.api.nvim_create_autocmd("CursorHoldI", {
  pattern = "*",
  callback = function()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, "textDocument/signatureHelp", params, function(err, result, ctx, config)
      vim.lsp.handlers.signature_help(err, result, ctx, config)
    end)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})

lsp.setup()
