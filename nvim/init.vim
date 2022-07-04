" Options
set showmatch
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

" Tabs size
set tabstop=2
set softtabstop=2
set autoindent
set expandtab
set shiftwidth=2
set tabstop=2

filetype plugin indent on
syntax on

" True color if available
let term_program=$TERM_PROGRAM

" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
    set termguicolors
else
    if $TERM !=? 'xterm-256color'
        set termguicolors
    endif
endif

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" File browser
let g:netrw_banner=0
let g:netrw_liststyle=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_keepdir=0
let g:netrw_localcopydircmd='cp -r'

"open nerdtree with ctrl n
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Create file without opening buffer
function! CreateInPreview()
  let l:filename = input('please enter filename: ')
  execute 'silent !touch ' . b:netrw_curdir.'/'.l:filename
  redraw!
endfunction

" Netrw: create file using touch instead of opening a buffer
function! Netrw_mappings()
  noremap <buffer>% :call CreateInPreview()<cr>
endfunction

augroup auto_commands
    autocmd filetype netrw call Netrw_mappings()
augroup END

"Alt arrow to move code around:
nnoremap √ :m .+1<CR>==
nnoremap ª :m .-2<CR>==

inoremap √ <Esc>:m .+1<CR>==gi
inoremap ª <Esc>:m .-2<CR>==gi

vnoremap √ :m '>+1<CR>gv=gv
vnoremap ª :m '<-2<CR>gv=gv

"reload vim config and install
":source $MYVIMRC | PlugInstall
call plug#begin()
    " Appearance
    Plug 'rebelot/kanagawa.nvim'
    "Plug 'dracula/vim',{'as': 'dracula'}
    "Plug 'EdenEast/nightfox.nvim'
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'
    Plug 'yggdroot/indentline'

    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'codechips/coc-svelte', {'do': 'npm install'}

    " Completion / linters / formatters
    Plug 'neoclide/coc.nvim',  {'branch': 'release'}
    Plug 'plasticboy/vim-markdown'
    Plug 'sbdchd/neoformat'
    Plug 'dense-analysis/ale'
    Plug 'prettier/vim-prettier', { 'do': 'npm install --frozen-lockfile --production' }
    Plug 'Shougo/context_filetype.vim'
    " Git
    Plug 'airblade/vim-gitgutter'
call plug#end()

colorscheme kanagawa

" Prettier Settings
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat_require_pragma = 0
au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync

" COC
let g:coc_node_path = '$HOME/.nvm/versions/node/v12.16.3/bin/node'

nmap ff  (coc-format-selected)
nmap rn (coc-rename)
nmap  gd (coc-definition)
nmap  gy (coc-type-definition)
nmap  gi (coc-implementation)
nmap  gr (coc-references)

set updatetime=300
set shortmess+=c " don't give |ins-completion-menu| messages.

" Use K to show documentation in preview window
nnoremap  K :call show_documentation()

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('')
  else
    call CocAction('doHover')
  endif
endfunction

if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif

let g:context_filetype#filetypes.svelte =
\ [
\   {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
\   {
\     'filetype': 'typescript',
\     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
\     'end': '',
\   },
\   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
\ ]

let g:ft = ''

" NERDCommenter settings

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = { 'html': { 'left': '' } }

" Align comment delimiters to the left instead of following code indentation
let g:NERDDefaultAlign = 'left'

fu! NERDCommenter_before()
  if (&ft == 'html') || (&ft == 'svelte')
    let g:ft = &ft
    let cfts = context_filetype#get_filetypes()
    if len(cfts) > 0
      if cfts[0] == 'svelte'
        let cft = 'html'
      elseif cfts[0] == 'scss'
        let cft = 'css'
      else
        let cft = cfts[0]
      endif
      exe 'setf ' . cft
    endif
  endif
endfu

fu! NERDCommenter_after()
  if (g:ft == 'html') || (g:ft == 'svelte')
    exec 'setf ' . g:ft
    let g:ft = ''
  endif
endfu
