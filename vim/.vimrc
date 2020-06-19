set number
set nowrap
set noeb

syntax on

set nobackup
set noswapfile
set noundofile

inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT><CR><UP><END>
function! RepairNxDoubCh(ch)
	let line = getline(".")
	let next_ch = line[col(".")] "
	if a:ch == next_ch
		execute "normal! l"
	else
		execute "normal! a" . a:ch . ""
	end
endfunction

inoremap jk <ESC>
inoremap J <ESC>Ji
inoremap <TAB> <C-P>
inoremap <S-TAB> <TAB>
inoremap ) <ESC>:call RepairNxDoubCh(')')<CR>a
inoremap ] <ESC>:call RepairNxDoubCh(']')<CR>a
inoremap } <ESC>:call RepairNxDoubCh('}')<CR>a

function! RemoveNxDoubCh()
	let line=getline(".")
	if strlen(line) == 0
		execute 'normal! ddk$'
		return
	elseif col(".") == 1
		execute 'normal! x'
		return
	endif
	let ch=line[col(".")-1]
	let nxch=line[col(".")]
	let mrk=1
	if col(".") == strlen(line)
		let mrk=0
	endif
	if ch == '[' && nxch == ']'
		execute 'normal! x'
	elseif ch == '{' && nxch == '}'
		execute 'normal! x'
	elseif ch == '(' && nxch == ')'
		execute 'normal! x'
	elseif ch == "'" && nxch == "'"
		execute 'normal! x'
	elseif ch == '"' && nxch == '"'
		execute 'normal! x'
	endif
	if col(".") == strlen(getline("."))
		let mrk=0
	endif
	execute "normal! x"
	if mrk
		execute 'normal! h'
	endif
endfunction

inoremap <C-D> <ESC>dd
inoremap <C-V> <ESC>"+pa
inoremap <BS> <ESC>:call RemoveNxDoubCh()<CR>a
nmap <C-F9> :w<CR>:!clear<CR>:!g++ % -o %<<CR>
nmap <C-F10> :!clear<CR>:!./%<<CR>
nmap <tab> 4l
inoremap <C-H> <left>
inoremap <C-L> <right>
inoremap <C-J> <down>
inoremap <C-K> <up>
vmap <tab> 4l
nmap <S-tab> 4h
vmap <S-tab> 4h
nmap <C-A> ggvG$
vmap <C-C> "+y
inoremap <C-O> <ESC>o
nmap <space> $
set tabstop=4
set shiftwidth=4
set softtabstop=4
set mouse=a
set cindent
set lines=40
set columns=110
function! Testfunc()
	let lefth=line("'<")
	let leftc=col("'<")
	echo lefth
	echo leftc
endfunction

function! WriteFor(str)
	let outputstr = "for(int " . a:str[0] . "=" . a:str[1] . "; " . a:str[0] . "<=" . a:str[2] . "; " . a:str[0] . "++)"
	execute "normal! cc" . outputstr
endfunction

function! WriteEdge(str)
	"iu
	let outputstr = "for(int " . a:str[0] . "=h[" . a:str[1] . "]; " . a:str[0] . "; " . a:str[0] . "=nx[" . a:str[0] . "])"
	execute "normal! cc" . outputstr
endfunction

function! WriteScanf(str)
	"n,m
	let s1 = "scanf(\"%d"
	let s2 = "&"
	for i in range(0,strlen(a:str)-1)
		let s2 = s2 . a:str[i]
		if a:str[i]==','
			let s1 = s1 . "%d"
			let s2 = s2 . "&"
		endif
	endfor
	let ans=s1 . "\"," . s2 . ");"
	execute "normal! cc" . ans
endfunction
inoremap <C-F> <esc>:call WriteFor("")<left><left>
inoremap <C-U> <esc>:call WriteEdge("")<left><left>
inoremap <C-C> <esc>:call WriteScanf("")<left><left>
inoremap UU <ESC>ccusing namespace std;
inoremap TY <ESC>cctypedef long long ll;
set noexpandtab
%retab!