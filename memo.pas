program memo;
uses memoTypes, memoIHM, memoJeu, keyboard;



var tailleGrille, score : Integer;
	player : Joueur;
	tabScore : Highscores;
	tailleTabScore : Integer;


	
BEGIN

	afficherDemarrage(player, tabScore, tailleTabScore);
	InitKeyBoard();
	difficulte(tailleGrille);
	jeu(tailleGrille, score);
	afficherScore(score);
	DoneKeyboard();
	
	stockageScore(player, score, tabScore, tailleTabScore);

END.
