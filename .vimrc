""""""""""""""""""""""""""""""
" *** Load pathogen paths ***
""""""""""""""""""""""""""""""
source ~/vim/bundles/vim-pathogen/autoload/pathogen.vim
let s:vim_runtime = expand('<sfile>:p:h')."/vim/.."
call pathogen#infect('~/vim/bundles/{}')
call pathogen#helptags()
packloadall

""""""""""""""""""
" General Configs
""""""""""""""""""

autocmd!
set wildmenu
set ruler
set history=500
set cmdheight=1
set smartcase
set hlsearch
set lazyredraw
set magic
set ai
set si
set wrap


""""""""""""""""""
" File Handling
""""""""""""""""""

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

set nobackup
set nowb
set noswapfile

"""""""""""""""""""""
"  Colors and fonts
"""""""""""""""""""""

syntax enable
" set background=dark
set termguicolors
" colorscheme palenight
colorscheme quietlight

set cursorline
set number
set relativenumber
set conceallevel=1
set encoding=utf8
set ffs=unix,dos,mac

" Resolve issues with tmux coloring
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum""]"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum""]"

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Italics for my favorite color scheme
let g:palenight_terminal_italics=1

" Line cursor
:hi CursorLine   cterm=NONE ctermbg=black ctermfg=white guibg=#e0e0e0

" Status line
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
    set statusline+=%{fugitive#statusline()}
endif

""""""""""""
" Mappings
""""""""""""

" Sets leader to , as it is an easy right-hand key
let mapleader = ","

"" Saving and close

" ,e to reload vim configs
map <leader>e :e! ~/.vimrc<cr>
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

" Fast saving and leaving
nmap <leader>w :w!<cr>
nmap <leader>qq :q<cr>  
nmap <leader>qa :qa<cr>  

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

"" Search

" Navigate between search results with * and #
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

"" Pane navigation

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"" Buffer navigation

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>
" Navigate to buffers using ,l and ,h
map <silent>mm :bnext<cr>
map <silent>nn :bprevious<cr>

"" Tab navigation

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

"" Spell check

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""
" Buffers 
"""""""""

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

""""""""""""""""""""""""""""""
" *** P Editing: snipMate 
""""""""""""""""""""""""""""""

" Beside <TAB> support <CTRL-j>
ino <C-j> <C-r>=snipMate#TriggerSnippet()<cr>
snor <C-j> <esc>i<right><C-r>=snipMate#TriggerSnippet()<cr>
let g:snipMate = { 'snippet_version' : 1 }


""""""""""""""""""""""""""""""
" *** P Navigation: NERDTree 
""""""""""""""""""""""""""""""

let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=40


let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'🌝',
                \ 'Staged'    :'🌠',
                \ 'Untracked' :'🌚',
                \ 'Renamed'   :'🌞',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'❌',
                \ 'Dirty'     :'💩',
                \ 'Ignored'   :'',
                \ 'Clean'     :'',
                \ 'Unknown'   :'❓',
                \ }

" Mappings
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nn :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>


""""""""""""""""""""""""""""""
" *** P Git: GitGutter 
""""""""""""""""""""""""""""""

let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
nnoremap <silent> <leader>g :GitGutterToggle<cr>

let g:gitgutter_diff_base = 'master'

""""""""""""""""""""""""""""""
" *** P Editor: Airline 
""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='base16_material_lighter'
" let g:airline_theme = "palenight"


""""""""""""""""""""""""""""""
" *** P Language: Prettier 
""""""""""""""""""""""""""""""

" JS
let g:javascript_plugin_jsdoc = 1

" Formatting 

let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat = 1


""""""""""""""""""""""""""""""
" *** P Language: CoC 
""""""""""""""""""""""""""""""

" typescript
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]


" Automatic documentation or diagnostic (if exists) on hover
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(1000, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" Use TAB to trigger completion 
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Auto-complete
" Use tab and shift tab to navigate suggestions 
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Give more space for displaying messages.
set cmdheight=1

" Improve UX
set hidden
set updatetime=300
set signcolumn=yes

" Navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
map <silent> gd <Plug>(coc-definition)
map <silent> gy <Plug>(coc-type-definition)
map <silent> gi <Plug>(coc-implementation)
map <silent> gr <Plug>(coc-references)
map <silent> <leader>g <Plug>(coc-diagnostics)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

map <silent> <leader>r <Plug>(coc-rename)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

let airline#extensions#coc#error_symbol = '💥 '
let airline#extensions#coc#warning_symbol = '⚠️ '

""""""""""""""""""""""""""""""
" *** P Search: FZF 
" Search terms within files
""""""""""""""""""""""""""""""
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }

nmap <C-p> :GFiles<CR>
nmap <C-b> :Buffers<CR>
nmap <C-f> :Rg<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""
" Fixes
""""""""""""

" Configure backspace to work as expected
" set backspace=eol,start,indent
" set whichwrap+=<,>,h,l
"
""""""""""""""""""
" Helpers
""""""""""""""""""

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
