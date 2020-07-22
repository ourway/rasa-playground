set nocompatible
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set ai
set ruler
highlight Comment ctermfg=green
syntax on
set textwidth=99
set wrap
set shortmess+=F "don't prompt for ENTER
set backspace=2
set showmatch
set autoread
set modeline
set exrc

" guard for distributions lacking the 'persistent_undo' feature.
if has('persistent_undo')
    " define a path to store persistent undo files.
    let target_path = expand('~/.config/vim-persisted-undo/')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif
    " point Vim to the defined undo directory.
    let &undodir = target_path
    " finally, enable undo persistence.
    set undofile
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"Some plugins -- minimal
set runtimepath^=~/.vim/bundle/ctrlp.vim

" awesome color -- works with default item colors
colorscheme blue

autocmd FileType python map <buffer> <leader>r :w<CR>:exec '!clear && echo `env python3 --version` && env python3 -B -d' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <leader>r <esc>:w<CR>:exec '!clear && echo `env python3 --version` && env python3 -B -d' shellescape(@%, 1)<CR>
autocmd FileType python vmap <buffer> <leader>r :'<,'>w !clear && python3 % -d <CR>
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%99v.*/
augroup END

map <Leader>d :call InsertLine()<CR>

function! InsertLine()
  let trace = expand("import pdb; pdb.set_trace()")
  execute "normal o".trace
endfunction

autocmd BufWritePost *.py :silent exec '!env black -q -l 99 %'
