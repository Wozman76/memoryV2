program memo;
uses memoTypes, memoIHM, memoJeu;



var taille, score : Integer;
	player : Joueur;
	tab : Highscores;
	i : Integer;


	
BEGIN

afficherDemarrage(player, tab, i);
InitKeyBoard();
difficulte(taille);
jeu(taille, score);
afficherScore(score);
DoneKeyboard();
stockageScore(player, score, tab, i);

END.
