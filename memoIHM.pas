unit memoIHM;

Interface
uses memoJeu, memoTypes, crt, sysutils, keyboard;


procedure difficulte(var taille : Integer);

procedure jeu(taille : Integer; var score : Integer);
procedure afficherGrille(taille : Integer; g : Grille);
procedure tour(taille : Integer; g : Grille; var x1, y1, x2, y2 : Integer);
procedure deplacerCurseur(taille : Integer; var posX, posY : Integer);
procedure retournerCase(x, y : Integer; g : Grille);

procedure afficherDemarrage(var player : Joueur; var tabF, tabD : Highscores; var nbScoresF, nbScoresD : Integer);

procedure afficherScore(score : Integer);




Implementation


procedure difficulte(var taille : Integer);
var c : Char;
begin
	writeln('Quelle difficulte voulez-vous? (f)acile ou (d)ifficile?');
	repeat
		readln(c);
		case c of 
			'f' : taille := 4;
			'd' : taille := 6;
		else writeln('Difficulte non valide!')
		end
	until (c = 'f') or (c = 'd');
	ClrScr;
	end;

////////////////////////////////////////////////////
procedure jeu(taille : Integer; var score : Integer);
var x, y, x1, y1, x2, y2, nbRetourne : Integer;
	g : Grille;
begin
	score := 0;

	initGrille(taille, g);

{GotoXY(1,15);
for y := 1 to taille do
	begin
	for x := 1 to taille do
		write(g[x][y].lettre);
	writeln;
	end;}	



	repeat
		nbRetourne := 0;
		afficherGrille(taille,g);
		tour(taille, g, x1, y1, x2, y2);
		modifGrille(x1, y1, x2, y2, g);
		for y := 1 to taille do
			for x := 1 to taille do
				if g[x][y].retourne then
					nbRetourne := nbRetourne + 1;
		score := score + 1;
		GotoXY(1, taille + 3);
		write(score);

	until nbRetourne = taille*taille;
end;

procedure afficherGrille(taille : Integer; g : Grille);

var x, y : Integer;
begin
	GotoXY(1,1);
	for y := 1 to taille do
		begin
			for x := 1 to taille do
				if g[x][y].retourne = True then
					write(g[x][y].lettre + ' ')
				else write('# ');
			writeln;
		end;


end;

procedure tour(taille : Integer; g : Grille; var x1, y1, x2, y2 : Integer);
begin




		
		
	repeat
		deplacerCurseur(taille, x1, y1);
		if g[x1][y1].retourne then 
			begin
				GotoXY(1, taille + 5);
				write('Selectionnez une autre case.');
			end
		else 
			begin
				GotoXY(1, taille + 5);
				DelLine();
			end;

			
			
	until not(g[x1][y1].retourne);
		

		
	retournerCase(x1, y1, g);
	
	repeat
		
		deplacerCurseur(taille, x2, y2);
		
		GotoXY(1, taille + 5);
		DelLine();
		
		if (x1 = x2) and (y1 = y2) then
			begin
				GotoXY(1, taille + 5);
				write('Selectionnez une autre case.')
			end;
		
		if g[x2][y2].retourne then 
			begin
				GotoXY(1, taille + 5);
				write('Selectionnez une autre case.');
			end
		else 
			begin
				GotoXY(1, taille + 5);
				DelLine();
			end;
		
	until ((x1 <> x2) or (y1 <> y2)) and not(g[x2][y2].retourne);
		
	retournerCase(x2, y2, g);
	

		

	
	Sleep(500);


	


end;




procedure deplacerCurseur(taille : Integer; var posX, posY : Integer);
var k : TKeyEvent;
begin
	posX := 1;
	posY := 1;


	GotoXY(posX, posY);


	repeat 
		k := GetKeyEvent;
		case GetKeyEventCode(k) of
			18432 : if (posY > 1) then posY := posY - 1;
			20480 : if (posY < taille) then posY := posY + 1;
			19200 : if (posX > 1) then posX := posX - 1;
			19712 : if (posX < taille) then posX := posX + 1;
		end;
		GotoXY(2*posX-1,posY);
	until GetKeyEventCode(k) = 7181; 


end;


procedure retournerCase(x, y : Integer; g : Grille);
begin
	GotoXY(2*x-1,y);
	write(g[x][y].lettre);

end;

////////////////////////////////////////////////////
procedure afficherScore(score : Integer);
begin
	ClrScr;
	writeln('Score realise : ', score);


end;

////////////////////////////////////////////////////
procedure afficherDemarrage(var player : Joueur; var tabF, tabD : Highscores; var nbScoresF, nbScoresD : Integer);
var fichier : File of Joueur;
	j : Integer;
	playerFichier : Joueur;
	
begin

	nbScoresF := 0;
	assign(fichier, 'scoresF.dat');
	if not(FileExists('scoresF.dat')) then
	 
		rewrite(fichier)
		
	else reset(fichier);
	
	while not(eof(fichier)) do
		begin
			nbScoresF := nbScoresF + 1;
			read(fichier, playerFichier);
			tabF[nbScoresF] := playerFichier;
			
		end;
	close(fichier);
	
	///
	
	nbScoresD := 0;
	assign(fichier, 'scoresD.dat');
	if not(FileExists('scoresD.dat')) then
	 
		rewrite(fichier)
		
	else reset(fichier);
	
	while not(eof(fichier)) do
		begin
			nbScoresD := nbScoresD + 1;
			read(fichier, playerFichier);
			tabD[nbScoresD] := playerFichier;
			
		end;
	close(fichier);
	
	
	
	
	
	

	writeln('Liste des meilleurs scores :');
	writeln;

	writeln('Scores faciles :');
	writeln;

	for j := 1 to nbScoresF do
		writeln('- ', tabF[j].nom, ' : ', tabF[j].score);
	writeln;
		
	GotoXY(40, 3);
	writeln('Scores difficiles :');
	for j := 1 to nbScoresD do
		begin
			GotoXY(40, 4 + j);
			writeln('- ', tabD[j].nom, ' : ', tabD[j].score);
		end;
		
	writeln;
	writeln;
	write('Quel est votre nom? ');
	readln(player.nom);


end;


END.
