" basic settings
execute pathogen#infect()
colorscheme jellybeans
syntax on
filetype plugin indent on
set number
set ts=2
set shiftwidth=0
set background=dark
set backup
set showmatch
set expandtab
set autoindent
set hls
set backspace=indent,eol,start
set relativenumber
set backupdir=~/vimBackup
set dir=~/vimBackup
set t_Co=256

" some short cut
nnoremap ,q :q<CR>
nnoremap ,w :w<CR>
map gn :tabnew<CR>
vmap ,e :%!bash<CR>

" prevent Uppercase mistakenly
vmap u y

" search and stop
nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>


"----------------------------------------------------------------------
" A mapping to make a backup of the current file
"----------------------------------------------------------------------
function! WriteBackup( attachedStr)
  silent execute 'write'
  if a:attachedStr == '0'
    let l:fname = &backupdir . '/' . expand('%:t') . '_' . strftime('%Y%m%d_%H.%M.%S')
  else
    let l:fname = &backupdir . '/' . expand('%:t') . '_' . strftime('%Y%m%d_%H.%M.%S') . '-' . a:attachedStr
  endif
  silent execute 'write' l:fname
  echomsg 'Wrote' l:fname
endfunction
" Backup with current time and user string. ex) :BA successAjax!!
command! -nargs=1 BA :call WriteBackup(<f-args>)
nnoremap ,b :w<ESC>:call WriteBackup(0)<CR>


"----------------------------------------------------------------------
" 80 column warning
"----------------------------------------------------------------------
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
map ,80 :match OverLength /\%81v.\+/<cr>


"----------------------------------------------------------------------
" easy-motion shortcut
"----------------------------------------------------------------------
map <C-i> <Plug>(easymotion-s)
map <C-h><C-i> <Plug>(easymotion-s2)


"----------------------------------------------------------------------
" show path/filename status bar
"----------------------------------------------------------------------
function! ShowFileNameBar()
  if(&laststatus == 0 || &laststatus == 1)
    "set statusline=%F
    set laststatus=2
  else
    set laststatus=0
  endif
endfunc
map <C-n><C-n> :call ShowFileNameBar()<cr>


"----------------------------------------------------------------------
" copy to system buffer
"----------------------------------------------------------------------
"BEGIN ANSIBLE MANAGED BLOCK FOR COPY_TO_SYSTEM_BUFFER
"END ANSIBLE MANAGED BLOCK FOR COPY_TO_SYSTEM_BUFFER


"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
" Avoding NERDTree broken char
let g:NERDTreeDirArrows=0
nnoremap ,c :NERDTreeFind<CR>
nnoremap ,e :NERDTreeCWD<CR>
"https://vi.stackexchange.com/questions/14379/separate-c-m-and-enter
"nnoremap <C-m><C-m> :NERDTreeToggle<CR>
nnoremap <C-m><C-o> :NERDTreeToggle<CR>


"----------------------------------------------------------------------
" ale
"----------------------------------------------------------------------
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
let g:ale_lint_delay = 1000
let g:jsx_ext_required = 0


"----------------------------------------------------------------------
" automated toggle paste - nopaste
"----------------------------------------------------------------------
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction


"----------------------------------------------------------------------
" fzf & ag
"----------------------------------------------------------------------
" BEGIN ANSIBLE_MANAGED_BLOCK_FOR_SET_RTP_FZF
" END ANSIBLE_MANAGED_BLOCK_FOR_SET_RTP_FZF
map <c-p> :FZF<cr>
map <C-k><C-k> :AgFile <cword><cr>
set runtimepath^=~/.vim/bundle/ag
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
"let $FZF_DEFAULT_COMMAND = 'ag --hidden --skip-vcs-ignores --ignore .git -g ""'

" you can run follow by :F
" http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)


"----------------------------------------------------------------------
" vim-json restore quote consealed by ~/.vim/bundle/indentLine
"----------------------------------------------------------------------
let g:vim_json_syntax_conceal = 0


"----------------------------------------------------------------------
" 80 column formattring - use `gq`
"----------------------------------------------------------------------
set textwidth=0
autocmd FileType * set formatoptions-=t  " but not automatically


"----------------------------------------------------------------------
" java
"----------------------------------------------------------------------
autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_JavaCompiler="/usr/bin/javac"
let g:JavaComplete_GradleExecutable = 'gradlew'
let g:JavaComplete_ClasspathGenerationOrder = ['Eclipse', 'Gradle']
let g:JavaComplete_ImportOrder = ['com.hello.']
let g:ale_java_javac_classpath='./lib/*:.:./build/classes/java/main/com/hello/*:./src/main/java/*'


"----------------------------------------------------------------------
" Align GitHub-flavored Markdown tables
"----------------------------------------------------------------------
" https://github.com/junegunn/vim-easy-align
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
let g:vim_markdown_folding_disabled = 1


"----------------------------------------------------------------------
" vim-tab
"----------------------------------------------------------------------
"set follow option  in your vimrc,Press 't' in NERDTree directory node will open the directory in a new tab,
"and will also sets VIM working directory to that directory node
let g:NERDTreeChDirMode=2

"below is reload GTAGS, ctags demo code.
function! TabReloadCGtag()
	"reload GTAGS in current directory
	cs kill 0
	"gnu global produce GTAGS, more useful than cscope
	cs add GTAGS
	"reload tags in current directory
	set tags=tags
endfunction

"some action when enter a tab
function! TabEnterTag(nr)
	"echo "tab ". a:nr . " enter"
	call TabReloadCGtag()
endfunction

"some action when leave a tab
function! TabLeaveTag(nr)
	"echo "tab ". a:nr . " leaves"
	"nothing
endfunction

"don't care about pattern field for now
let g:TabTagTrigger = {'name':'TabTagTriger','pattern':"", 'enter_callback':"TabEnterTag", 'leave_callback':"TabLeaveTag" }

"call tab#TabShowTrigger()
call tab#TabAddTrigger(g:TabTagTrigger)

"when first open a tab, the tab enter trigger will not be called,the following code load tags automatically when open a file
autocmd BufEnter *.[ch] call TabReloadCGtag()
autocmd BufEnter *.cpp call TabReloadCGtag()
autocmd BufEnter *.java call TabReloadCGtag()
