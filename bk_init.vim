" -*-:- mode: vimrc; -*-;
"If viewing this file and it appears like with several '+-- X lines: ...'
" you can expand them easily by hovering over them and typing either:
" 1) ', ' which is <leader><space>
" 2) 'za'
"You can also, hit escape, and type ":ChaseVim.txt" (with the leading colon) and it will help alot!

" Settings {{{
" Looks {{{
set t_Co=256        "Terminal Colors set to 256
syntax on           "Creates better highlighting
lua require('monokai').setup {}
highlight Normal ctermfg=grey ctermbg=black
set background=dark
set clipboard=unnamed,unnamedplus " Allows Vim to use System Clipboard
" }}}
"Layout {{{
set relativenumber  " Show Relative Number on non-selected lines
set number          " Show Highlighted Line number in relation to file
set ruler           " Shows current position
set noshowmode      " Prevents the 'mode' from showing (this is because lightline does this for us)
set laststatus=2    " Makes Statusline appear
set lazyredraw      " Redraw the screen less, leading to faster response
set showmatch       " Shows matching bracket when highlighting with cursor
set spelllang=en_us " If Spell Check is enabled (<leader>ss) then use US English
set nolinebreak     " I do NOT want my text breaking at 80 columns by default
set textwidth=0     " Playing with settings to make my 80 column highlight stop...
set cursorline      " Show a highlighted line where cursor is at
" }}}
"Folding {{{
set foldenable        " Enables Folding
set foldlevelstart=10 " Opens the first 10 folds by default " TODO: Validate
set foldnestmax=10    " 10 nested fold max
set foldmethod=marker " Tells Vim to fold based on indent level
set modeline          " Turn ModeLine On
set modelines=1       " Checks last line for file specific commands via ModeLine
" }}}
"Spacing, Tab Key, and Indention {{{
set smartindent     " Smarter indenting
set backspace=2     " Backspace in insert mode works like normal editor
set expandtab       " 1 tab = 4 spaces
set shiftwidth=4    " 1 tab = 4 spaces
set tabstop=4       " Backspace over a full tab if tab is expanded to tabstop or expandtab
set softtabstop=4   " Backspace over a full tab if tab is expanded to tabstop or expandtab
set showtabline=2   " Always display the tabline, even if there is only 1 tab
" }}}
"Filetype Specific indents {{{
filetype indent on  " Activates indenting for files
filetype plugin on  " Activates plugins for file types
autocmd Filetype puppet setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd Filetype ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" Useful for longlined text files, wont hurt anything else
autocmd BufReadPost,BufNewFile *.txt setlocal filetype=text | set linebreak | set noexpandtab 
" Everything for a MLA Paper turned on by default!
autocmd BufReadPost,BufNewFile *.mla call MLAPaper()

" }}}
"Menu and Search {{{
set wildmode=list:longest " Make 'wildmenu' behave a little nicer
set ignorecase      " Ignores case when searching
set smartcase       " Even with ignore case, still try to be smart about it
" }}}
" Help Stuff {{{
" gO = List Table of Contents
" ^] (CTRL-]) = Jump to highlight in help (Can also click on word)
" ^T/^O (CTRL-T/CTRL-O) = Jump back to previous spot 
set helpheight=35
" }}}
" Cygwin Settings {{{
" Stolen from vim.fandom.com/wiki/Use_cygwin_shell.html
" Makes bash open in the working directory
" let $CHERE_INVOKING=1

" Path for Cygwin 64-bit
" set shell=C:\Users\cama20\Documents\Test\Cygwin64\bin\bash.exe

" Without --login, Cygwin won't mount some directories such as /usr/bin/
" set shellcmdflag=--login\ -c

" Default value is (, but bash needs "
" set shellxquote=\"

" Paths will use / instead of \
" set shellslash
" }}}
" AutoStart on NVim Load {{{
autocmd VimEnter * NERDTree CAMA | wincmd p
let g:python3_host_prog='C:/Users/cama20/Documents/Programs/Python39/App/Python/python.exe'
augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
" }}}
" }}}
" Key Remaps {{{
" Most of them are in here, some of them are with their appropriate functions
" Remaps with LEADER {{{
" TODO: Make option to hide other splits (full screen current split)
" --- Needs to be reversable though
" Leader is comma
let mapleader=","
" ,vim -> Loads your init.vim again
nnoremap <Leader>vim :source ~\AppData\Local\nvim\init.vim<CR>
" Intelligently Add/Remove line numbers
nnoremap <silent> <leader>n :set invnumber <bar> :set invrelativenumber<CR>
" Run the entire file through the indent filter with <Leader>=
noremap <silent> <Leader>= :call Preserve("normal gg=G")<CR>
" Leader-space open/closes folds
nnoremap <leader><space> za
" Quick saving of files
nnoremap <leader>w :w!<CR>
" Remove the extra ^M that windows creates at the end of lines
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" ,y yanks to end of line
nnoremap <leader>y y$
" Toggle paste mode with <Leader>p (need to turn it back off again though!)
nnoremap <leader>p :set invpaste paste?<CR>
" Delete (not cut) selection
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" Change to UPPERCASE entire word under cursor
inoremap <silent> <Leader>U <Esc>viwUea
nnoremap <silent> <Leader>U viwUea
" Change to Uppercase First letter of word under cursor
" TODO: This doesn't work if the first lettter is highlighted...
nnoremap <silent> <Leader>u b~
" Counts lines that start with comments
" TODO: Make this work with multiple filetypes... (ONLY JS ATM)
nnoremap <Leader>c :%s,\(^\s*\)//,,gn<CR>
" Counts all matches of word under cursor
nnoremap <Leader>C *<C-O>:%s///gn<CR>
" }}}
" Remaps with g/G {{{
" Highlights last inserted text from insert mode in visual mode
nnoremap gV `[v`]
" Create Space above or below current line! (Shift above Ctrl)
nmap gO O<ESC>j
nmap g<C-O> o<ESC>k
" Make g{ and g} move paragraphs with text instead of to blank lines
nnoremap <expr> g{ len(getline(line('.')-1)) > 0 ? '{+' : '{-'
nnoremap <expr> g} len(getline(line('.')+1)) > 0 ? '}-' : '}+'
" }}}
" Extended Functionality {{{
" :W (Capitol W) saves the file with sudo, needed when editing some files
command! W w !sudo tee % > /dev/null
" Map <F1> to <Esc> everywhere
map <F1> <Esc>
imap <F1> <Esc>
vmap <F1> <Esc>
nmap <F1> <Esc>
" Space to turn off highlighting
nnoremap <silent><Space> :nohlsearch<Bar>:echo<CR>
" }}}
" Key maps for Vims built in 'Spell Check' {{{
" Enables spell check, but only after pressing ,ss like 'set spell'
nnoremap <leader>ss :setlocal invspell<CR>
" ADD the word under the cursor to the spell file
nnoremap <leader>sa zg
" DELETE a word that you had previously said was good from the spell file
nnoremap <leader>sd zW
" CHANGE the word under the cursor (pulls up a list of words to change it to
nnoremap <leader>sc z=
" CHANGE the word under the cursor to the first suggestion that would pop up
nnoremap <leader>sC 1z=
" IGNORE the word under the cursor - temporary only
nnoremap <Leader>sG zG
" Repeat the replacement of z= for all matches in the current window
nnoremap <leader>sz :spellrepall<CR>
" Search Forwards for a misspelled word
nnoremap <leader>sf ]s
" Search Backwards for a misspelled word
nnoremap <leader>sF [s
" }}}
" Delete/Change surrounding characters {{{
" ds<char> only deletes
" cs<char> deletes and puts you into insert mode
noremap ds{ F{xf}x
noremap cs{ F{xf}xi
noremap ds" F"x,x
noremap cs" F"x,xi
noremap ds' F'x,x
noremap cs' F'x,xi
noremap ds( F(xf)x
noremap cs( F(xf)xi
noremap ds) F(xf)x
noremap cs) F(xf)xi
" }}}
" Make J and K work with Relative Number {{{
function! Down(vcount)
if a:vcount == 0
    exe "normal! gj"
else
    exe "normal!".a:vcount."j"
endif
endfunction

function! Up(vcount)
if a:vcount == 0
    exe "normal! gk"
else
    exe "normal!".a:vcount."k"
endif
endfunction

nnoremap <silent> j :<C-U>call Down(v:count)<CR>
vnoremap <silent> j gj
nnoremap <silent> k :<C-U>call Up(v:count)<CR>
vnoremap <silent> k gk
" }}}
" {{{ Key maps to make libreoffice like shortcuts work in vim
" Control + S to Save current buffer (May break some terminals!!!) 
" If your terminal breaks (or stops) research 'stty - ixon'
nnoremap <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <esc>:update<CR>a
nnoremap <silent> U <C-r>
nmap <C-z> u
nmap <C-Z> <C-r>
" }}}
" To act more like Notepad++ {{{
" I freaking love the ^q so I want to have it back as <leader>q
noremap <Leader>q :NERDCommenterInvert
" Make Tab and Shift-Tab work correctly
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Double Click to Move to Next Instance of word clicked on
nnoremap <Leader><2-LeftMouse> za
nnoremap <Leader><LeftMouse> * <C-o>
" }}}
" }}}
" Functions/AuGroups {{{
" OS Detection {{{
if has('win32') " For Windows
    set backupdir=~\AppData\Local\nvim\backup/ " Windows Backup files
    set directory=~\AppData\Local\nvim\swap/   " Windows Swap Files
    set undodir=~\AppData\Local\nvim\undo/     " Windows Undo files
elseif has('unix') " For Unix or Linux
    set backupdir=~/.config/nvim/backup// " Backup files
    set directory=~/.config/nvim/swap//   " Swap Files
    set undodir=~/.config/nvim/undo//     " Undo files
    let s:uname = system('uname -s')
    if s:uname =~? 'Darwin' " For Mac
        let s:has_mac = 1
    else
        " This auto installs VimPlug
        let s:plugins=$XDG_CONFIG_HOME . '/plugged'
        let s:plugin_manager=$XDG_CONFIG_HOME . '/autoload/plug.vim'
        let s:plugin_url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        let s:issue = system('cat /etc/issue')
    endif
endif
" Stealling this from Marco Hinz dotfile... (( EXPERIMENTAL))
" (github.com/mhinz/dotfiles/blob/master/.vim/vimrc)
"let s:is_win = has('win32')
"let $v = $HOME.(s:is_win ? '~\AppData\Local\nvim/' : '~/.config/nvim/')
"if s:is_win
"    set shell=cygwin.exe
"    set shellcmdflag=/c
"    set encoding=utf-8
"endif
" }}}
"Delete trailing white space on save, useful for Python {{{
func! DeleteTrailingWS()
exe "normal mz"
%s/\s\+$//ge
exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
" }}}
" MLA Essay Checker {{{
" Enabled and disabled with <Leader> b / <Leader> B (Code in the leader keymaps section)
function MLAPaper()
setlocal filetype=text
setlocal spell
setlocal linebreak
setlocal noexpandtab
setlocal syntax=mla

" List of words that should not be used for MLA Essays
highlight BadWords ctermbg=green guibg=green
highlight BadWords2 ctermbg=blue guibg=blue
highlight BadWords3 ctermbg=red guibg=red

match BadWords /\<was\>\|\<were\>\c/ " Passive, case insensitive
2match BadWords2 /\<you\>\|\<we\>\|\<my\>\|\<me\>\|\<us\>\|\<our\>\c/ " First Person, case insensitive
3match BadWords3 /\<I\>\|\<bible\>/ " Needs to check for exact case
endfunction
"}}}
" Writing and backing up files {{{
" If a directory doesn't exist, create it
function! s:mkNonExDir(file, buf)
if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
endif
endfunction
" Part of above function, creates actual dir from within nvim
augroup BWCCreateDir
autocmd!
autocmd BufWritePre * :call s:mkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" }}}
"TMux, allow cursor change based on presence of TMux {{{
" Sets cursor to Vertical Bar when using TMux
" Sets cursor to Block when not using TMux
if exists('$TMUX')
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}
" Window movement {{{
function! MarkWindowSwap()
let g:markedWinNum = winnr()
endfunction

" Easier Window movement when utalizing NVim like TMux
function! DoWindowSwap()
"Mark destination
let curNum = winnr()
let curBuf = bufnr( "%" )
exe g:markedWinNum . "wincmd w"
"Switch to source and shuffle dest->source
let markedBuf = bufnr( "%" )
"Hide and open so that we aren't prompted and keep history
exe 'hide buf' curBuf
"Switch to dest and shuffle source->dest
exe curNum . "wincmd w"
"Hide and open so that we aren't prompted and keep history
exe 'hide buf' markedBuf 
endfunction
" 
nnoremap <silent> <leader>mw :call MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call DoWindowSwap()<CR>
" }}}
" }}}
" Spelling/Error Correction (Autocorrect) && Thesaurus {{{
set thesaurus+=~\AppData\Local\nvim\spell\thesaurus.txt
" Each line is 1 common correction that will be automatic
" " If it might start a sentence then make a capitalized version too
" " Only works for 1 word at a time, not multiple words
" The Format is: ia <wrong_word> <correct_word>
" " Changed to not use contractions
ia Didnt Did not
ia Doesnt Does not
ia Dont Do not
ia Dosnt Does not
ia Grammer Grammar
ia Havnet Have not
ia Havnt Have not
ia Im I'm
ia Makeing Making
ia Quoteing Quoting
ia Refering Referring
ia sargent sergeant
ia Sargent Sergeant
ia Sence Since
ia Shouldnt Should not
ia Thats That is
ia Useing Using
ia its\ self itself
ia cant can not
ia definatly definitely
ia didnt did not
ia doesnt does not
ia dont do not
ia dosnt does not
ia grammer grammar
ia havnet have not
ia havnt have not
ia im I'm
ia makeing making
ia origional original
ia quoteing quoting
ia refering referring
ia sence since
ia shouldnt should not
ia thats that is
ia useing using
ia reserection resurrection*
" }}}
" Plugin Stuff {{{
" Key maps for Plugins {{{
" " TODO: Need to fix these some...
" The below sets NERDTree to Ctrl+N
map <C-n> :NERDTreeToggle<CR>
" nmap <Leader>r :RuboCop<CR>
" }}}
" PLUGIN Markdown Preview {{{
if has('nvim') && executable('cargo')
function! g:BuildComposer(info)
    if a:info.status !=# 'unchanged' || a:info.force
        !cargo build --release
        UpdateRemovePlugins
    endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
let g:markdown_composer_syntax_theme='hybrid'
elseif executable('npm')
Plug 'euclio/vim-instant-markdown', {
            \ 'for': 'markdown',
            \ 'do': 'npm install euclio/vim-instant-markdown-d'
            \}
endif

" }}}
" Lightline Specific settings {{{
let g:lightline = {
\ 'colorscheme': 'molokai',
\ 'active': {
\   'left': [
\      [ 'mode',
\        'paste' ],
\      [ 'filename',
\        'fugitive' ]
\   ],
\   'right': [
\      [ 'lineinfo' ],
\      [ 'percent' ],
\      [ 'syntastic',
\        'nerdtree' ]
\    ],
\ },
\ 'component_function': {
\   'modified': 'LightlineModified',
\   'readonly': 'LightlineReadonly',
\   'fugitive': 'LightlineFugitive',
\   'filename': 'LightlineFilename',
\   'fileformat': 'LightlineFileformat',
\   'filetype': 'LightlineFiletype',
\   'fileencoding': 'LightlineFileencoding',
\   'mode': 'LightlineMode',
\ },
\ 'separator': {
\   'left': '?',
\   'right': '?',
\ },
\ 'subseparator': {
\   'left': '?',
\   'right': '?',
\ },
\ 'mode_map': {
\   'No': 'NORMAL',
\   'In': 'INSERT',
\   'Re': 'REPLACE',
\   'Vs': 'VISUAL',
\   'VL': 'V-LINE',
\   'VB': 'V-BLOCK',
\   'Co': 'COMMAND',
\   'Se': 'SELECT',
\   'SL': 'S-LINE',
\   "SB": 'S-BLOCK',
\   'Te': 'TERMINAL',
\ },
\ }

function! LightlineModified()
return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
return &ft !~? 'help' && &readonly ? '? ?' : ''
endfunction

function! LightlineFilename()
return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
   \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
   \  &ft == 'unite' ? unite#get_status_string() :
   \  &ft == 'vimshell' ? vimshell#get_status_string() :
   \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
   \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
let branch = fugitive#head()
return branch !=# '' ? '? '.branch : ''
endif
return ''
endfunction

function! LightlineFileformat()
return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" }}}
" Neomake Specific Settings  {{{
let g:neomake_verbose = 0
let g:neomake_error_sign = {
        \ 'text': '>>',
        \ 'texthl': 'ErrorMsg',
        \ }
let g:neomake_warning_sign = {
        \ 'text': '>>',
        \ 'texthl': 'ErrorMsg',
        \ }
" }}}
" Molokai Specific Settings {{{
let g:rehash256 = 1 " More like the GUI 256 scheme'
" }}}
" RuboCop Settings {{{
let g:vimrubocop_keymap = 0
" }}}
" Startify Stuff{{{
"" This goes to ~/AppData/Local/nvim-data/session
let g:startify_lists = [
        \ { 'type': 'files',		'header': [' Files']            }, 
        \ { 'type': 'dir',			'header': [' Dirs '.getcwd()]   }, 
        \ { 'type': 'sessions',	    'header': [' Sessions']		    }, 
        \ { 'type': 'bookmarks',	'header': [' Bookmarks']	    }, 
        \ { 'type': 'commands',	    'header': [' Commands']		    },
        \ ]
let g:startify_session_dir = '~\AppData\Local\nvim\session'
"" Playing wit:h this section, could be useful
""" Bookmarks not working suddenly...
let g:startify_bookmarks = [ 
        \ { ',zz': '~\AppData\Local\nvim\init.vim' },
        \ { ',zL': '~\AppData\Local\nvim\init.lua'},
		\ { ',zC': '~\AppData\Local\nvim\doc\chasevim.txt' },
        \]
let g:startify_commands = [
		\ { ',hC':	[ 'Help Chase Vim', 'h chasevim' ] },
        \ { ',hL':   [ 'Help VimL', 'h learnviml' ] },
        \ { ',hS':   [ 'Help Startify', 'h Startify' ] },
        \ { ',hN':   [ 'Help NERDTree', 'h NERDTree' ] },
        \]
let g:startify_skiplist = [
        \ '\**.vim',
        \ "$HOME . '/.NERDTreeBookmarks'",
        \ "$HOME . '/\\AppData\\Local\\nvim\\**'",
        \]
let g:startify_files_number			= 10
let g:startify_session_number		= 10
let g:startify_session_sort			= 1
let g:startify_session_autoload		= 1
let g:startify_session_persistence	= 1
let g:startify_fortune_use_unicode	= 1
let g:startify_relative_path		= 1
let g:startify_change_to_dir		= 1
let g:startify_update_old_files		= 1

" }}}
" Lynx Stuff {{{
function! s:init_lynx()
nnoremap <nowait><buffer> <C-F> i<PageDown><C-\><C-N>
tnoremap <nowait><buffer> <C-F> <PageDown>

nnoremap <nowait><buffer> <C-B> i<PageUp><C-\><C-N>
tnoremap <nowait><buffer> <C-B> <PageUp>

nnoremap <nowait><buffer> <C-D> i:DOWN_HALF<CR><C-\><C-N>
tnoremap <nowait><buffer> <C-D> :DOWN_HALF<CR>

nnoremap <nowait><buffer> <C-U> i:UP_HALF<CR><C-\><C-N>
tnoremap <nowait><buffer> <C-U> :UP_HALF<CR>

nnoremap <nowait><buffer> <C-N> i<Delete><C-\><C-N>
tnoremap <nowait><buffer> <C-N> <Delete>

nnoremap <nowait><buffer> <C-P> i<Insert><C-\><C-N>
tnoremap <nowait><buffer> <C-P> <Insert>

nnoremap <nowait><buffer> u     i<Left><C-\><C-N>
nnoremap <nowait><buffer> U     i<C-U><C-\><C-N>
nnoremap <nowait><buffer> <CR>  i<CR><C-\><C-N>
nnoremap <nowait><buffer> gg    i:HOME<CR><C-\><C-N>
nnoremap <nowait><buffer> G     i:END<CR><C-\><C-N>
nnoremap <nowait><buffer> zl    i:SHIFT_LEFT<CR><C-\><C-N>
nnoremap <nowait><buffer> zL    i:SHIFT_LEFT<CR><C-\><C-N>
nnoremap <nowait><buffer> zr    i:SHIFT_RIGHT<CR><C-\><C-N>
nnoremap <nowait><buffer> zR    i:SHIFT_RIGHT<CR><C-\><C-N>
nnoremap <nowait><buffer> gh    i:HELP<CR><C-\><C-N>
nnoremap <nowait><buffer> cow   i:LINEWRAP_TOGGLE<CR><C-\><C-N>

tnoremap <buffer> <C-C> <C-G><C-\><C-N>
nnoremap <buffer> <C-C> i<C-G><C-\><C-N>
endfunction
command! -nargs=1 Web       vnew|call termopen('lynx -scrollbar '.shellescape(substitute(<q-args>,'#','%23','g')))|call <SID>init_lynx()
command! -nargs=1 Websearch vnew|call termopen('lynx -scrollbar https://duckduckgo.com/?q='.shellescape(substitute(<q-args>,'#','%23','g')))|call <SID>init_lynx()
" }}}
" NERDTree Stuff {{{
" Open the existing NERDTree on each new tab.
" TODO: Fix this!
autocmd BufWinEnter * if getcmdwintype() == '' | silent! NERDTreeMirror | endif
nnoremap <Leader>NC :NERDTree CAMA<CR>
nnoremap <Leader>NT :NERDTree TEST<CR>
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeMinimalUI = 1
if exists("g:loadednerdtree_custom_maps")
finish
endif
let g:loaded_nerdtree_custom_maps = 1
" }}}
" Python Mode Stuff {{{
" See (:h PyMode) for doc on each of the options not explicitly commented
let g:pymode = 1                        " Turn on the whole plugin
" Run Mode
let g:pymode_run = 1                    " Turn on the run code script
" Lint Mode
let g:pymode_lint = 1                   " Turn on code checking
let g:pymode_lint_on_write = 1          " Lint on save
let g:pymode_lint_on_fly = 0            " Enable(?) OTF linting
" Random Settings
let g:pymode_trim_whitespaces = 1       " Trim unused whitespaces on save
let g:pymode_options = 1                " Sets default python options 
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 6
let g:pymode_preview_height = &previewheight
let g:pymode_preview_position = 'botright'
let g:pymode_indent = 1
" }}}
" }}}
" Plugins to Install {{{
" TODO: Fix this!
silent! call plug#begin('~/.config/nvim/plugged')   " Starts using Vim-plug https://github.com/junegunn/Vim-plug
Plug 'itchyny/lightline.vim'         " Replacement for Airline
Plug 'tomasr/molokai'                " Color scheme 'Molokai' for Vim
Plug 'Lokaltog/vim-easymotion'       " \ss causes triggers easy motion
Plug 'godlygeek/tabular'             " Awesome plugin for aligning text
Plug 'tpope/vim-surround'            " Helps surrounding code and text with other code and text
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }      " Tree file navigator
Plug 'benekastah/neomake'            " Syntax Checker to replace Syntastic for NeoVim
Plug 'mhinz/vim-startify'            " Launch nvim standalone to access this
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' } " Python editor on crack
"Plug 'metakirby5/codi.vim'           " Real time REPL Scratchpad (Python)
"Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install -all' }
"Plug 'junegunn/fzf.vim'              " w/Above, Install Fuzzy Finder
"Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }                  " RuboCop build-in
"Plug 'elzr/vim-json', { 'for': 'json' }                     " JSON Highlight and indent plugin
"Plug 'dougireton/vim-chef'           " Vim doesn't know what Chef is till now
"Plug 'tmux-plugins/vim-tmux'         " A syntax highlighter for tmux! :D
"Plug 'puppetlabs/puppet-syntax-vim', { 'for': 'puppet' }    " Puppet Syntax Highlighting
"Plug 'rodjek/vim-puppet', { 'for': 'puppet' }               " Helps Vim Play Nice with Puppet
"Plug 'rodjek/puppet-lint', { 'for': 'puppet' }              " Suggested by PuppetLabs as a linter
Plug 'guns/xterm-color-table.vim'    " Shows XTERM Colors in terminal as they are typed
"Plug 'tpope/vim-fugitive'            " TPope's Git integration into Vim
Plug 'godlygeek/csapprox'            " Makes GVim Color Schemes work in Terminal Vim
call plug#end()                      " Stops using Vim-plug
"""""""
" Must move plugins out out 'call plug#end()' if no longer using them but want
" to keep documentation around...
"""""""
" }}}
" TODO: ADD ALL OF THE FOLLOWING TO THIS ASAP
" <Leader>rw replace word undercursor with current paste buffer
" Do not Edit below line unless you know what your doing
" Vim: set foldmethod=marker foldlevel=0 :
