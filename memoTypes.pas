unit memoTypes;

Interface
Const MAX = 36;
Type Carte = record
	lettre : Char;
	retourne : Boolean;
end;

Type Joueur = record
	nom : String;
	score : Integer;
end;

Type Grille = array[1..MAX,1..MAX] of Carte;

Type HighScores = array[1..10] of Joueur;




implementation


end.







