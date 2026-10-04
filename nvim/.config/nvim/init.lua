-- https://github.com/nvim-lua/kickstart.nvim

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        is_bootstrap = true
        vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
        vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'


        use {
                'nvim-telescope/telescope.nvim',
                branch = 'master',
                requires = { {'nvim-lua/plenary.nvim'} }
        }

        -- colorscheme
        use "rafamadriz/gruvbox"
        use "rose-pine/neovim"

        use('nvim-treesitter/nvim-treesitter', {
                run = ':TSUpdate',
        })

        use('theprimeagen/harpoon')
        use('ThePrimeagen/vim-be-good')
        use('mbbill/undotree')

        use {
            -- LSP Support
            'neovim/nvim-lspconfig',
        }

        use {
            'mason-org/mason.nvim',
        }

        use {
            'mason-org/mason-lspconfig.nvim',
        }

        use {
            -- Autocompletion
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-nvim-lua',
            }
        }

        use {
            -- Snippets
            'L3MON4D3/LuaSnip',
            requires = {
                'rafamadriz/friendly-snippets',
            }
        }

        if is_bootstrap then
                require('packer').sync()
        end
end)

if is_bootstrap then
        print '=================================='
        print '    Plugins are being installed'
        print '    Wait until Packer completes,'
        print '       then restart nvim'
        print '=================================='
        return
end


require('nvim-treesitter').setup()

require('nvim-treesitter').install({
    'python',
    'lua',
    'c',
    'cpp',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'python',
        'lua',
        'c',
        'cpp',
    },
    callback = function()
        vim.treesitter.start()
    end,
})

function ColorMyPencils(color)
        color = color or 'gruvbox'
        vim.cmd.colorscheme(color)
end
ColorMyPencils('gruvbox')

vim.opt.timeoutlen = 500 -- decrease update time
vim.opt.updatetime = 200 -- decrease update time

vim.opt.scrolloff = 8 -- number of screen lines to keep above and below the cursor

-- better editor ui
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.relativenumber = true
--ncolumn = 'yes:2'
vim.opt.cursorline = true
vim.opt.colorcolumn = "80" -- marks column 80

vim.opt.expandtab = true
--- vim.opt.smarttab = true
vim.opt.cindent = true
--- vim.opt.autoindent = true
vim.opt.wrap = true
vim.opt.textwidth = 300
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1   -- if negative, shiftwidth value is used
vim.opt.list = true
vim.opt.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
vim.opt.laststatus = 3     -- thin line between splits instead a statusbar

vim.opt.clipboard = 'unnamedplus' -- neovim and os clipboard play nicely

vim.opt.ignorecase = true  -- case insensitive searching unless /c or capital in search
vim.opt.smartcase = true

vim.opt.backup = false     -- undo and backup options 
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.swapfile = false
--- vim.opt.backupdir = '/tmp/'
--- vim.opt.directory = '/tmp/'
vim.opt.undodir = os.getenv("HOME") .."/.vim/undodir"
vim.opt.undofile = true

vim.opt.history = 50       -- remember 50 items in commandline history

-- better buffer splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.jumpoptions = 'view' -- preserve view while jumping

-- vim.opt.guicursor = ""
-- vim.opt.hlsearch = false
-- vim.opt.incsearch = true

-- Map <leader> to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- switch into normal mod 
-- vim.keymap.set('i', '<c-Space>', '<ESC>')
-- vim.keymap.set('v', '<c-Space>', '<ESC>')

-- Ctrl s save file
vim.keymap.set('n', '<c-s>', ':w<CR>')
vim.keymap.set('i', '<c-s>', '<ESC>:w<CR>')
vim.keymap.set('v', '<c-s>', '<ESC>:w<CR>')

-- source init.lua
vim.keymap.set('n', '<leader>vv', '<cmd>edit $MYVIMRC<CR>')

vim.keymap.set('n', '<leader>e', ':Ex<CR>') -- file explorer

-- copy and past clipboard
-- vim.keymap.set('v', '<c-c>', '"+y')    -- copy selected into desktop clipboard
-- vim.keymap.set('n', '<c-c>', '"+y')    -- copy selected into desktop clipboard
-- vim.keymap.set('n', '<c-p>', '"+p')    -- paste desktop clipboard into vim
vim.keymap.set('x', "p","\"_dp",       { desc = 'replaced text without losing the paste'})
vim.keymap.set('x', "<leader>p", 'p',  { desc = 'replaced text with exchange the paste'})

-- Fix and keeping cursor in postion
vim.keymap.set('n', 'N',     'Nzzzv',   { desc = 'jump to next search dn' })
vim.keymap.set('n', 'n',     'nzzzv',   { desc = 'jump to next search dn' })
vim.keymap.set('n', '<c-d>', '<c-d>zz', { desc = 'half page dn' })
vim.keymap.set('n', '<c-y>', '<c-e>j',  { desc = 'scroll one line page up cursor dn' })
vim.keymap.set('n', '<c-e>', '<c-y>k',  { desc = 'scroll one line page dn cursor up' })
vim.keymap.set('n', 'J',     'mzJ`z',   { desc = 'join current and line below' })

-- Bubbling
vim.keymap.set('n', '<C-j>', '<cmd>m .+1<CR>==',        { desc = 'Bubbling text down' })
vim.keymap.set('n', '<C-k>', '<cmd>m .-2<CR>==',        { desc = 'Bubbling text up' })
vim.keymap.set('i', '<C-j>', '<esc><cmd>m .+1<CR>==gi', { desc = 'Bubbling text down' })
vim.keymap.set('i', '<C-k>', '<esc><cmd>m .-2<CR>==gi', { desc = 'Bubbling text up' })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv",        { desc = 'Bubbling text down' })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv",        { desc = 'Bubbling text up' })
-- Intending
vim.keymap.set("v", "<C-l>", ">gv",         { desc = 'intending text right =>' })
vim.keymap.set("v", "<C-h>", "<gv",         { desc = 'unintending text left <=' })
vim.keymap.set("n", "<C-l>", "i<C-t><esc>", { desc = 'intending text right =>' })
vim.keymap.set("n", "<C-h>", "i<C-d><esc>", { desc = 'unintending text left <=' })
vim.keymap.set("i", "<C-l>", "<C-t>",       { desc = 'intending text right =>' })
vim.keymap.set("i", "<C-h>", "<C-d>",       { desc = 'unintending text left <=' })

-- Create breaks points for undo U
vim.keymap.set('i', ',', ',<C-g>u', { desc = 'undo break point' })
vim.keymap.set('i', '.', '.<C-g>u', { desc = 'undo break point' })
vim.keymap.set('i', '!', '!<C-g>u', { desc = 'undo break point' })
vim.keymap.set('i', '?', '?<C-g>u', { desc = 'undo break point' })

-- Jump between split screen
vim.keymap.set('i', '<A-h>', '<esc><C-w>h', { desc = 'split jump right' })
vim.keymap.set('i', '<A-j>', '<esc><C-w>j', { desc = 'split jump down' })
vim.keymap.set('i', '<A-k>', '<esc><C-w>k', { desc = 'split jump up' })
vim.keymap.set('i', '<A-l>', '<esc><C-w>l', { desc = 'split jump left' })
vim.keymap.set('n', '<A-h>', '<C-w>h',      { desc = 'split jump right' })
vim.keymap.set('n', '<A-j>', '<C-w>j',      { desc = 'split jump down' })
vim.keymap.set('n', '<A-k>', '<C-w>k',      { desc = 'split jump up' })
vim.keymap.set('n', '<A-l>', '<C-w>l',      { desc = 'split jump left' })
vim.keymap.set('v', '<A-h>', '<C-w>h',      { desc = 'split jump right' })
vim.keymap.set('v', '<A-j>', '<C-w>j',      { desc = 'split jump down' })
vim.keymap.set('v', '<A-k>', '<C-w>k',      { desc = 'split jump up' })
vim.keymap.set('v', '<A-l>', '<C-w>l',      { desc = 'split jump left' })

-- Mark and Swap split windows
vim.keymap.set('n', '<leader>mw', function()
        -- Mark split window
        vim.g.markedwinnum = vim.fn.winnr()
        print(string.format("Marked split: %d", vim.g.markedwinnum))
end, { desc = '[M]ark split [w]indow for swaping' })
vim.keymap.set('n', '<leader>pw', function()
        -- Swap split window with Marked
        print(string.format("Swaped Marked %d with Current %d", vim.g.markedwinnum, vim.fn.winnr()))
        -- Mark destination
        local curNum = vim.fn.winnr()
        local curBuf = vim.fn.bufnr("%")
        vim.cmd(string.format("%d wincmd w", vim.g.markedwinnum))
        -- Switch to source and shuffle dest->source
        local markedBuf = vim.fn.bufnr("%")
        -- Hide and open so that we aren't prompted and keep history
        vim.cmd(string.format('hide buf %s', curBuf))
        -- Switch to dest and shuffle source->dest
        vim.cmd(string.format("%s . wincmd w", curNum))
        -- Hide and open so that we aren't prompted and keep history
        vim.cmd(string.format('hide buf %s', markedBuf))
end, { desc = 'Swap marked split with the current split' })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', builtin.git_files,  { desc = '[F]ind [G]it files' })
vim.keymap.set(
        'n',
        '<leader>fs',
        function() builtin.grep_string({ search = vim.fn.input("grep > ") }) end,
        { desc = '[F]ind [S]tring by grep' }
)

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<leader>ee', ui.toggle_quick_menu)
vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end, { desc = 'harpoon file 1' })
vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end, { desc = 'harpoon file 2' })
vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end, { desc = 'harpoon file 3' })
vim.keymap.set('n', '<leader>4', function() ui.nav_file(4) end, { desc = 'harpoon file 4' })
vim.keymap.set('n', '<leader>5', function() ui.nav_file(5) end, { desc = 'harpoon file 5' })
vim.keymap.set('n', '<leader>6', function() ui.nav_file(6) end, { desc = 'harpoon file 6' })
vim.keymap.set('n', '<leader>7', function() ui.nav_file(7) end, { desc = 'harpoon file 7' })
vim.keymap.set('n', '<leader>8', function() ui.nav_file(8) end, { desc = 'harpoon file 8' })
vim.keymap.set('n', '<leader>9', function() ui.nav_file(9) end, { desc = 'harpoon file 9' })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Mason
require('mason').setup()

require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'pyright',
        'clangd',
    },
})

-- LSP configuration
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'diagnostic info under cursor' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'next diagnostic' })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
        vim.keymap.set({ 'n', 'x' }, '<F4>', vim.lsp.buf.code_action, opts)
    end,
})

-- nvim-cmp capabilities
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Completion
local cmp = require('cmp')
local luasnip = require('luasnip')

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),

        ['<CR>'] = cmp.mapping.confirm({
            select = true,
        }),

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    }),
})

