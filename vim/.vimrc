set cpo-=<
set number
set nowrap
set noeb

syntax on

set nobackup
set noswapfile
set noundofile

inoremap jk <ESC>
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

inoremap <C-V> <ESC>"+pa
inoremap <BS> <ESC>:call RemoveNxDoubCh()<CR>a
nmap <F9> :w<CR>:!clear<CR>:!g++ % -o %<<CR>
nmap <C-F9> :w<CR>:!clear<CR>:!g++ % -o %< -g -Wall<CR>
nmap <F12> :!clear<CR>:!./%<<CR>
nmap <tab> 4l
vmap <tab> 4l
nmap <S-tab> 4h
vmap <S-tab> 4h
nmap <C-A> ggvG$
vmap <C-C> "+y
nmap <space> $
set tabstop=4
set shiftwidth=4
set softtabstop=4
set mouse=a
set cindent
set lines=40
set columns=120
function! Testfunc()
	let lefth=line("'<")
	let leftc=col("'<")
	echo lefth
	echo leftc
endfunction
function! WriteFor(str)
	let a=""
	let b=""
	let c=""
	if strlen(a:str)==3
		let a=a:str[0]
		let b=a:str[1]
		let c=a:str[2]
	else
		" a=b; a<=c; a++
		let w=1
		let s1=0
		let s2=0
		for i in range(0,strlen(a:str)-1)
			if a:str[i]==',' && s1==0 && s2==0
				let w=w+1
			else
				if w==1
					let a = a . a:str[i]
					" echo a:str[i] . ' ' . a
				elseif w==2
					let b = b . a:str[i]
				else
					let c = c . a:str[i]
				endif
				if a:str[i]=='('
					let s1=s1+1
				elseif a:str[i]==')'
					let s1=s1-1
				elseif a:str[i]=='['
					let s2=s2+1
				elseif a:str[i]==']'
					let s2=s2-1
				endif
			endif
		endfor
	endif
	let outputstr = "for(int " . a . "=" . b . "; " . a  . "<=" . c . "; " . a . "++)"
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
	let ans = s1 . "\"," . s2 . ");"
	execute "normal! cc" . ans
endfunction
inoremap <C-F> <esc>:call WriteFor("")<left><left>
inoremap <C-U> <esc>:call WriteEdge("")<left><left>
inoremap <C-C> <esc>:call WriteScanf("")<left><left>
inoremap UU <ESC>ccusing namespace std;
inoremap TY <ESC>cctypedef long long ll;
set noexpandtab
%retab!
set ic
