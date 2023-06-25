
-----------------------------------------------------------

-- Null LS is a hackish implementation of some LSP features that are not
-- properly implemented in some  language servers. It fills some holes.

-- yay -S python-black

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,  -- python formater
    },
})

-----------------------------------------------------------

-- LSP Config is a plugin to easily configure the built-in LSP client in neovim. 
-- Here are some configs and mappings.

local lspconfig = require('lspconfig')
vim.lsp.set_log_level("debug")

-- BASH, SH
-- yay -S bash-language-sserver shellcheck
lspconfig.bashls.setup{}

-- C++, C
-- pacman -S clang
lspconfig.clangd.setup{}

-- CMAKE
-- yay -S cmake-language-server
lspconfig.cmake.setup{}

-- HTML
-- yay -S vscode-langservers-extracted
lspconfig.html.setup{}

-- JAVASCRIPT, ECMASCRIPT, etc.
   -- yay -S vscode-langservers-extracted
   -- eslint only works within a "project" (package.json, node_modules, all that).
   -- To initialize a simple project, you can use `eslint --init` 
lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
      vim.keymap.set('n', '<leader>f', ':EslintFixAll<cr>', { silent = true, buffer = true })
  end,
})

-- JSON. 
-- yay -S vscode-langservers-extracted
lspconfig.jsonls.setup{}

-- MARKDOWN
-- yay -S marksman-bin
lspconfig.marksman.setup{}

-- PHP
-- needs to be within a .git directory, or within a composer.json directory
lspconfig.intelephense.setup{}

-- PYTHON
-- pacman -S jedi-language-server
lspconfig.jedi_language_server.setup{}

-- XML
-- pacman -S lemminx
lspconfig.lemminx.setup{}



---------

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.setloclist)
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>J', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>j', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  end,
})

-- Hide all semantic highlights. 
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
