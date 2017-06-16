function! SeleteDataBase()
        read !  ls ./.db_conf/*.vim >  .db_conf/.list
        tabnew ./.db_conf/.list
        exec "%s/\\v^/source  /"
        exec "%s/\\v$/ |  call LoadKeyWords() | exit | tabnew a.sql   |   /"
        normal gg
endfunction

function! EditDataBase()
        tabnew ./.db_conf/
endfunction

function! CreateDatabase( name )
       exec "tabnew ./.db_conf/" . a:name .".conf.vim"
       exec "read ./.db_conf/.default" 
       normal ggdd
endfunction

function! RunSqlFile( filename )
        let cmd =  "read ! cat  "  . a:filename . " >  run.sql"
        exec cmd
        let cmd =  "read ! mysql --defaults-file=".g:conf_file ." -h " . g:ip . "  -D " . g:db_name   . "   <  run.sql >  all.sql_result"
        echo cmd
        exec cmd
endfunction

function! ChangeStatusLine( words )
        let cmd =   "set statusline=%F\\ -\\ FileType:%y\\ \\ \\ \\ \\ \\ \\ \\ " . a:words ."\\ \\ [Warnning\\ \\!\\]\\ IS\\ IT\\ THE\\ PROBLEM\\ OF\\ ABILITY\\ OR\\ ATTUTUDE\\?\\ \\ \\ \\ \\ \\ %l\\%L:%c "
        exec cmd
endfunction

function! RunSqlFromYank()
        read ! >.tmp.sql
        split .tmp.sql
        normal p
        write
        call RunSqlFile( expand( "%:p" ) )
endfunction

command! Sdb call SeleteDataBase()
command! Edb call EditDataBase()
command! Run call RunSqlFile( expand( "%:p" ) )
command!  -nargs=1 Ndb  call CreateDatabase( <q-args> )

nnoremap \rr ^y$:call RunSqlFromYank()<cr>
vnoremap \rr y:call RunSqlFromYank()<cr>

autocmd BufNew *.sql_result  :setlocal  nowrap
autocmd BufNew  *.sql_result  :setlocal  autoread

color blue
"call SeleteDataBase()
set splitbelow

"Edit tmp
nnoremap \et  :tabnew _tmp/_tmp.cpp<cr>

iabbrev del delete from where $<esc>Fma
iabbrev sel select from where $<esc>0fta
iabbrev asel select * from where 1=1 <esc>Fma

iabbrev upd update set $ where  $<esc>0fea

function! LoadKeyWords()
       exec "read ! python ./.get_keys.py " . g:ip . " "  . g:db_name  . "  " .  g:conf_file
       badd .key_words
endfunction
