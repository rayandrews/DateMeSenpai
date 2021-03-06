npc(senpai, kelas).
npc(batuCinta, halamanBelakang).
npc(satpam, ruangSatpam).

/* game control */
start:-
  g_assign(gameStatus, not_running),
  g_assign(gameover,0),
  g_assign(gamePause, no),
  intro_screen,
  nl,
  loop,!,
  fail.

loop :-
  repeat,
  write('> '),
  read(State),
  do(State),
  g_read(gameover,X),
  (X == 1).

%Edit di sini untuk menambahkan status akhir game
summary_stat :-
  write('Permainan berakhir'),nl,
  stat,nl,nl,
  write('Kukuh    : Mati lu cok!'), nl,
  write('Winarto  : Bayar lu cok!'), nl,
  write('Ray      : Donate us cok!'), nl,
  write('Adrian   : Jomblo ya cok? Nyari cewenya kok disini?'), nl,
  write('Kukuh, Winarto, Ray : Diam lu pe, beban!'), nl,
  write('Adrian   : Kamu ga punya hak ngejudge AKU!'), nl,
  write('Ko Alson : KALIAN DAPAT 100! MATAPANCING!'),nl,nl,nl,
  write(' _______________________________'),nl,
  write('|  Kukuh        (Roleplay)      |'),nl,
  write('|  Winarto      (Stuntman)      |'),nl,
  write('|  Ray Andrew   (Voice Actor)   |'),nl,
  write('|  Adrian HP    (Cameo)         |'),nl,
  write(' \\_____________________________/'),nl,
  g_assign(gameover,1),true.

available(instruksi).
available(new).
available(stat).
available(exit).
available(clear).
available(load).
available(pause).
available(resume).
available(save).
available(look).
available(take(_)).
available(drop(_)).
available(talk).
available(n).
available(s).
available(e).
available(w).
available(jawab(_)).
available(friendzone_senpai).
available(confess).
available(examine(_)).
available(give(_)).
available(beli(_)).

system_func(new).
system_func(load).
system_func(exit).
system_func(instruksi).
system_func(clear).
system_func(resume).

system_func_running(load).
system_func_running(new).
system_func_running(resume).

system_func_not_running(new).
system_func_not_running(load).
system_func_not_running(exit).
system_func_not_running(instruksi).


do(X) :- ( available(X) ->
            g_read(gameStatus,Y),
            (Y == running ->
                g_read(gamePause,Z),
                (Z == ya ->
                    (system_func(X) ->
                        X
                    ;
                        write('Carry Me Senpai : Woop''s you are in Pause state, you only can do new, load, exit, instruksi, clear, resume'),
                        nl
                    )
                ;
                    (\+system_func_running(X) ->
                        X
                    ;
                        write('Carry Me Senpai : Forbidden action!'),nl
                    )
                )
            ;
                (system_func_not_running(X) ->
                    X
                ;
                    write('Carry Me Senpai : Forbidden action!'),
                    nl
                )
            )
        ;
            write('Carry Me Senpai : Woop''s invalid functions ' : X),nl
         ).

exit :-
  g_assign(gameover,1),
  g_assign(gameStatus,not_running),
  write('Thank you kouhai!'),
  nl.

clear :-
    system(clear).

new:-
    g_assign(gameStatus,running),
    g_assign(gamePause, no),
    write('Liburan telah usai, hari ini merupakan hari pertama sekolah di SMA ITB Bandung'),
    nl,
    write('Dengan penuh antusias kamu pergi ke sekolah berharap mendapatkan cinta baru'),
    nl,
    write('Setibanya di dalam kelas, tiba-tiba ada senpai yang mendekati kamu'),
    nl,
    write('Senpai: Kouhai! Nama kamu siapa?'),
    nl,
    write('(Masukan nama kamu)'),
    nl,
    write(' = '),
    read(X),
    loadfile('res/init.cmr'),
    g_assign(player,X),
    write('Senpai: Hmph! Ini bukan berati saya ingin tau namamu, t-tapi.. hmph! lupakan!!'),
    nl,
    write('Senpai: By the way, salam kenal ya '),
    write(X),
    write('!'),
    nl,
    fail.

instruksi:-
g_read(gameStatus, X),
g_read(gamePause, Y),
    (X == not_running ->
        write('new.       -- Untuk memulai game baru'),
        nl,
        write('load.      -- Load saved game'),
        nl,
        write('exit.      -- Keluar dari permainan'),
        nl,
        write('instruksi. -- Menampilkan command program'),
        nl
    ;
        (Y == ya ->
            write('resume.    -- Melanjutkan game'),
            nl,
            write('new.       -- Untuk memulai game baru'),
            nl,
            write('load.      -- Load saved game'),
            nl,
            write('exit.      -- Keluar dari permainan'),
            nl,
            write('instruksi. -- Menampilkan command program'),
            nl
        ;
            write('pause.            -- Membuka menu game'),
            nl,
            write('n.                -- Berpindah ke ruangan utara(atas) dari lokasi sekarang'),
            nl,
            write('s.                -- Berpindah ke ruangan selatan(bawah) dari lokasi sekarang'),
            nl,
            write('e                 -- Berpindah ke ruangan timur(kanan) dari lokasi sekarang'),
            nl,
            write('w                 -- Berpindah ke ruangan barat(kiri) dari lokasi sekarang'),
            nl,
            write('stat.             -- Menampilkan atribut dan item yang dimiliki'),
            nl,
            write('look.             -- Menampilkan peta, lokasi sekarang, item yang dimiliki, dan npc di ruangan'),
            nl,
            write('save.             -- Save game state'),
            nl,
            write('take(Barang).     -- Mengambil barang dari lokasi sekarang'),
            nl,
            write('drop(Barang).     -- Meletakkan barang dari inventory ke lokasi sekarang'),
            nl,
            write('give(Barang).     -- Memberikan barang kepada senpai'),
            nl,
            write('talk.             -- Berbicara kepada npc yang ada di lokasi sekarang'),
            nl,
            write('instruksi.        -- Menampilkan command program'),
            nl,
            write('clear.            -- Membersihkan layar'),
            nl,
            write('friendzone_senpai.-- Nyerah dari permainan dan menampilkan summary status'),
            nl,
            write('confess.          -- Menyatakan perasaan kepada senpai'),
            nl,
            write('jawab(X)          -- Menjawab pertanyaan dengan pilihan X'),
            nl,
            write('beli(X)           -- Membeli barang X dengan uang'),
            nl,
            write('examine(X)        -- Menampilkan informasi barang X yang terdapat di inventory'),
            nl,
            write('exit.             -- Keluar dari permainan'),
            nl
        )
    ).

info :-
  g_read(affinity,A),
  write('Affinity'),
  write(' : '),
  write(A), nl.

pause :-
  g_assign(gamePause, ya),
  intro_screen.

resume :-
  g_assign(gameStatus, running),
  g_assign(gamePause,no).

intro_screen :-
    g_read(gameStatus, Status),
    write_res_main_menu('res/mainmenu.cml', Status).

save :-
    write('Enter file name : '),
    read(File),
    nl,write('Save successful!'),
    atom_concat('savegame/', File, Files),
    atom_concat(Files, '.cms',FilePath),
    save_state(FilePath),
    nl,
    fail.

load :-
    g_assign(gameStatus,running),
    g_assign(gamePause, no),
    write('Available Save File :'),nl,
    directory_files('savegame',ListDir),
    print_dir(ListDir),
    write('Load file : '),
    read(File),
    atom_concat('savegame/', File, Files),
    atom_concat(Files, '.cms',FilePath),
    loadfile(FilePath),!,
    fail.

loadfile(File) :-
    open_file(File,read,Save),
    read_save(Save,Cond),
    assign_list(Cond),
    close(Save).

assign_list(X) :-
          X = [[A,B,C,D,E]],
          g_assign(player, A),
          g_assign(curLoc, B),
          g_assign(inventory,C),
          D = [Z],
          g_assign(affinity,Z),
          g_assign(location,E).

open_file(F,_,S) :-
     catch( open(F, read, S),_,( write('can''t open file': F), nl, fail) ).
     %http://www.amzi.com/manuals/amzi/pro/ref_io.htm#OpenAndClosingFiles

read_save(Stream, L):-
  read_term(Stream, H, []),
  (   H == end_of_file
  ->  L = []
  ;   L = [H|T],
      read_save(Stream,T)
  ). %http://stackoverflow.com/questions/26826470/reading-lines-into-lists-with-prolog
/* read resources */

%mainmenu res (mainmenu.cml)
write_res_main_menu(File,Status) :-
    open_file(File,read,Save),
    read(Save,Res),
    Res = [A,B],
    A = [H1|[T1]],
    B = [_|[T2]],
    (H1 == Status ->
        print_list(T1)
    ;
        print_list(T2)
    ),
    close(Save),
    nl.

write_res_main_menu(_,_) :- true.

save_state(File) :-
    g_read(player,A),
    g_read(curLoc,B),
    g_read(inventory,C),
    g_read(affinity,D),
    g_read(location,E),
    open(File,write,Save),
    write(Save,'['''),
    write(Save,A),
    write(Save,''','''),
    write(Save,B),
    write(Save,''',['),
    ( save_inventory(Save,C) ->
        write(Save,'],['''),
        write(Save,D),
        write(Save,'''],['),
        ( save_location(Save,E) ->
            write(Save,']].')
            ;
            fail
        )
        ;
        fail
    ),
    close(Save).

save_inventory(_,[]).
save_inventory(Save,[H]) :-
    write(Save,''''),
    write(Save,H),
    write(Save,'''').
save_inventory(Save,[H|T]) :-
    write(Save,''''),
    write(Save,H),
    write(Save,''','),
    save_inventory(Save,T).

save_location(_,[]).
save_location(Save,[H]) :-
    H = [A,B],
    write(Save,'['''),
    write(Save,A),
    write(Save,''','''),
    write(Save,B),
    write(Save,''']').
save_location(Save,[H|T]) :-
    H = [A,B],
    write(Save,'['''),
    write(Save,A),
    write(Save,''','''),
    write(Save,B),
    write(Save,'''],'),
    save_location(Save,T).

stat :-
    g_read(player,X),
    write('Nama : '),
    write(X),nl,
    info,
    print_inv.

look :-
    g_read(location,X),
    print_curloc,
    print_inv,
    nl,
    print_obj(X),
    print_npc,
    fail.

print_curloc :-
  write('            _____________________'), nl,
  write('           |          |          |'),nl,
  write('           | Kamar    | Kamar    |'),nl,
  write('           | Ortu     |          |'),nl,
  write('           |          |          |'),nl,
  write('           |__________|__________|__________'), nl,
  write('                      |          |          |'),nl,
  write('                      |  Rumah   | Toko     |'),nl,
  write('                      |          |          |'),nl,
  write('                      |          |          |'),nl,
  write('                      |__________|__________|__________'), nl,
  write('                      |          |          |          |'),nl,
  write('                      | Jalanan  |          | Locker   |'),nl,
  write('                      |          |          | Perempuan|'),nl,
  write('                      |          |          |          |'),nl,
  write(' _____________________|__________|__________|__________|'),nl,
  write('|          |          |          |          |          |'),nl,
  write('| Halaman  | Ruang    | Sekolah  | Lorong   | Locker   |'),nl,
  write('| Belakang | satpam   |          | Sekolah  |          |'),nl,
  write('|          |          |          | Timur    |          |'),nl,
  write('|__________|__________|__________|__________|__________|'),nl,
  write('           |          |          |          |'),nl,
  write('           | Ruang    |  Lorong  | Kelas    |'),nl,
  write('           | Guru     |  Sekolah |          |'),nl,
  write('           |          |  Selatan |          |'),nl,
  write('           |__________|__________|__________|'),nl,
  write('                      |          |          |'),nl,
  write('                      |  Perpus  | Depan    |'),nl,
  write('                      |  takaan  | Kelas    |'),nl,
  write('                      |          |          |'),nl,
  write('                      |__________|__________|'),nl,
  g_read(curLoc, X),
  write('Kamu sedang berada di: '),
  write(X),nl.

print_inv :-
	g_read(inventory,X),
	(\+X = [] ->
		write('Item yang ada di inventory kamu: '),nl,
		\+print_list(X)
		;
		write('Inventory kamu kosong'),nl
	).

print_obj([]) :- fail.
print_obj([[X|Y]|[]]) :-
	!,g_read(curLoc,Z),
	Y = [V],
	(Z = V ->
		(npc(X,Z) ->
			true
			;
			write('Terdapat '),
      write(X),
      write(' di '),
            write(Z),
      nl
		)
		;
		true
	).
print_obj([[X|Y]|T]) :-
	g_read(curLoc,Z),
	Y = [V],
	(Z = V ->
		(npc(X,Z) ->
			true
			;
			write('Terdapat '),
			write(X),
			write(' di '),
            write(Z),
			nl
		)
		;
		true
	),
	print_obj(T).


print_npc :-
	g_read(curLoc,X),
	(npc(Y,X) ->
		write('Di ruangan ini terdapat npc : '),
		write(Y)
		;
		write('Tidak ada npc di ruangan ini')
	),nl.

n :-
  moveup.

s :-
  movedown.

e :-
  moveright.

w :-
  moveleft.

talk :-
    load_dialog('res/dialog.cmr'),
    get_npc_based_location(NPC),
    g_assign(npc_active,NPC),
    g_read(gameDialog,B),
    write_dialog(B),
    fail.

write_dialog([]).
write_dialog([[A,B]|T]) :-
	g_read(npc_active,Z),
	(==(B,'1') ->
		write(Z),
		write(' : '),
		write(A),
		nl
	;
		write(A),
		nl
	),
	write_dialog(T).

load_dialog(File) :-
    open_file(File,read,Save),
    read_save(Save,Cond),
    parsing_file_for_dialog(Cond),
    close(Save).

get_npc_based_location(NPC) :-
    g_read(curLoc,Loc),
    npc(NPC,Loc).

parsing_file_for_dialog(L) :-
    parse_char_dialog(L,X),
    parse_dialog(X).

parse_char_dialog([[[_,B],[_,D],[_,F]]],X) :-
    get_npc_based_location(W),
    (==(W,senpai) ->
        X = B
    ;
        (==(W,satpam) ->
            X = D
        ;
            X = F
        )
    ).

parse_dialog([]).
parse_dialog([H|T]) :-
    H= [A,B],
    g_read(affinity,Z),
    (compare(=,A,Z) ->
        g_assign(gameDialog, B),
        !
    ;
        parse_dialog(T)
    ).

baca_deskripsi :-
    open_file('res/deskripsi.cmr',read,Save),
    read_save(Save,Cond),
	g_assign(deskripsi,Cond),
	close(Save).

print_deskripsi(Barang,[[]]) :- write(Barang), write(' merupakan barang yang kamu beli di toko'),nl.
print_deskripsi(Barang,[[[A,B]|T]]) :-
	(Barang == A ->
		write(B),nl
	;
		print_deskripsi(Barang,[T])
	).

loadscenetext(Place) :-
	open_file('res/scenetext.cmr',read,Text),
	read(Text,Res),
	scenetext(Place,Res),
	close(Text).

scenetext(Place,Res) :-
	Res = [A|B],
	A = [H,T],
	(H == Place ->
		write(T),nl,!
	;
		scenetext(Place,B)
	).
