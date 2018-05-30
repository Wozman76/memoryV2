unit memoIHM;

Interface
uses memoJeu, memoTypes, crt, sysutils, keyboard;


procedure difficulte(var taille : Integer);

procedure jeu(taille : Integer; var score : Integer);
//procedure afficherGrille(taille : Integer; g : Grille);
//procedure tour(taille : Integer; g : Grille; var x1, y1, x2, y2 : Integer);
//procedure deplacerCurseur(taille : Integer; var posX, posY : Integer);
//procedure retournerCase(x, y : Integer; g : Grille);

procedure afficherDemarrage(var player : Joueur; var tab : Highscores; var i : Integer);

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

	deplacerCurseur(taille, x1, y1);
	retournerCase(x1, y1, g);
	deplacerCurseur(taille, x2, y2);
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

	//GotoXY(2*x-1,y);
	write(g[x][y].lettre);

end;

////////////////////////////////////////////////////
procedure afficherScore(score : Integer);
begin
ClrScr;
writeln('Score realise : ', score);


end;

////////////////////////////////////////////////////
procedure afficherDemarrage(var player : Joueur; var tab : Highscores; var i : Integer);
var fichier : File of Joueur;
	j : Integer;
	playerFichier : Joueur;
	
begin



	i := 0;
	assign(fichier, 'scores.dat');
	if not(FileExists('scores.dat')) then
	 
		rewrite(fichier)
		
	else reset(fichier);
	
	while not(eof(fichier)) do
		begin
			i := i + 1;
			read(fichier, playerFichier);
			tab[i] := playerFichier;
			
		end;
	close(fichier);

	writeln('Liste des meilleurs scores :');
	writeln;

	for j := 1 to i do

			writeln('- ', tab[j].nom, ' : ', tab[j].score);
		
	writeln;
	write('Quel est votre nom? ');
	readln(player.nom);


end;


END.
