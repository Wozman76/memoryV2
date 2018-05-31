unit memoJeu;


Interface
uses memoTypes, crt;

procedure initGrille(taille : Integer; var g : Grille);
procedure modifGrille(x1, y1, x2, y2 : Integer; var g : Grille);
procedure ajoutScoreTableau(player : Joueur; taille : Integer; var tab : HighScores);
procedure stockageScore(player : Joueur; score : Integer; tab : Highscores; i : Integer);



Implementation

//////////////////////////////
procedure initGrille(taille : Integer; var g : Grille);
var i : Integer;
	x, y : Word;
	str : String;

begin
	randomize;
	str := 'aabbccddeeffgghhiijjkkllmmnnooppqqrr';

	if taille = 4 then
		Delete(str,17,20);
	
	for x := 1 to taille do
		for y := 1 to taille do
			begin
				i := random(length(str)) + 1;
				g[x][y].lettre := str[i];
				g[x][y].retourne := False;
				Delete(str, i, 1);
	
			end;

end;


////////////////////////
procedure modifGrille(x1, y1, x2, y2 : Integer; var g : Grille);
begin

	if (g[x1][y1].lettre = g[x2][y2].lettre) and ((x1 <> x2) or (y1 <> y2)) then
	begin

		g[x1][y1].retourne := True;
		g[x2][y2].retourne := True;
		
		
		
	end;
		
end;

procedure stockageScore(player : Joueur; score : Integer; tab : Highscores; i : Integer);
var fichier : File of Joueur;
	j : Integer;
	
begin
	player.score := score;
	
		
		
	ajoutScoreTableau(player, i, tab);

	assign(fichier, 'scores.dat');
	
	rewrite(fichier);
	
	if i >= 5 then
		i := 4;
		
	for j := 1 to i+1 do
		write(fichier, tab[j]);
		
	close(fichier);


	
	
end;

    
procedure ajoutScoreTableau(player : Joueur; taille : Integer; var tab : HighScores);
var pos : Integer;
begin
	if taille < 10 then
		begin
			pos := taille + 1;
			while (pos > 1) and (tab[pos - 1].score > player.score) do
				begin
					tab[pos] := tab[pos - 1];
					pos := pos - 1;
				end;
			tab[pos].nom := player.nom;
			tab[pos].score := player.score;
			taille := taille + 1;
			
		end;


end;
	




end.
