-- [[ Setting options ]]
-- See `:help vim.o`
vim.o.scrolloff = 8
vim.o.title = true
vim.o.relativenumber = true
vim.o.showcmd = true
vim.o.cursorline = true
vim.o.splitright = true
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.backup = false                          -- creates a backup file
vim.opt.smartindent = true                      -- make indenting smarter again

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Decrease update time
vim.o.updatetime = 250

vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.opt.shortmess:append "c"

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
