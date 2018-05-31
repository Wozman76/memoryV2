program memo;
uses memoTypes, memoIHM, memoJeu, keyboard;



var tailleGrille, score : Integer;
	player : Joueur;
	tabScoreF, tabScoreD : Highscores;
	tailleTabScoreF, tailleTabScoreD : Integer;


	
BEGIN

	afficherDemarrage(player, tabScoreF, tabScoreD, tailleTabScoreF, tailleTabScoreD);
	InitKeyBoard();
	difficulte(tailleGrille);
	jeu(tailleGrille, score);
	afficherScore(score);
	DoneKeyboard();
	
	
	if tailleGrille = 4 then
		stockageScore(player, score, tabScoreF, tailleTabScoreF, 4)
	else stockageScore(player, score, tabScoreD, tailleTabScoreD, 6); 

END.
