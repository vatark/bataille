{
ALGOUITHME batailleNavale


type
	cellule = ENREGISTREMENT
		ligne, colonne : ENTIER
FIN

type
	bateau = ENREGISTREMENT
		cellules : TABLEAU[1..5] DE cellule
		taille : ENTIER
		vie : ENTIER
FIN

type
	flotte = ENREGISTREMENT
		bateaux : TABLEAU[1..5] DE bateau
		taille : ENTIER
FIN



FONCTION creationCellule (ligne, colonne : ENTIER) : cellule

VAR
	coOUdonnees : cellule

DEBUT
	coOUdonnees.ligne <- ligne
	coOUdonnees.colonne <- colonne
	creationCellule <- coOUdonnees
FIN

//On compare deux cellules
FONCTION comparaisonCellules (cellule1, cellule2 : cellule) : BOOLEEN

DEBUT
	SI ((cellule1.ligne = cellule2.ligne) ET (cellule1.colonne = cellule2.colonne)) ALORS
		comparaisonCellules <- true
	SINON
		comparaisonCellules <- false
FIN


//On crée un bateau
FONCTION creationBateau (origine : cellule taille : ENTIER direction : CHAINE) : bateau

VAR
	i : ENTIER

DEBUT
	creationBateau.taille<-taille
	creationBateau.vie<-taille
	POUR i DE 1 A 5  FAIRE
	DEBUT
		SI i <= taille ALORS
		DEBUT
			SI direction = 'bas' ALORS
			DEBUT
				creationBateau.cellules[i].ligne <- origine.ligne
				creationBateau.cellules[i].colonne <- origine.colonne + i - 1
			FIN
			SINON SI direction = 'droite' ALORS
			DEBUT
				creationBateau.cellules[i].ligne <- origine.ligne + i - 1
				creationBateau.cellules[i].colonne <- origine.colonne
			FIN
			SINON SI direction = 'gauche' ALORS
			DEBUT
				creationBateau.cellules[i].ligne <- origine.ligne - i + 1
				creationBateau.cellules[i].colonne <- origine.colonne
			FIN
			SINON SI direction = 'haut' ALORS
			DEBUT
				creationBateau.cellules[i].ligne <- origine.ligne
				creationBateau.cellules[i].colonne <- origine.colonne - i + 1
			FIN
			SINON
			DEBUT
				ECRIRE('Erreur dans la direction')
				creationBateau.cellules[i].ligne <- -1
				creationBateau.cellules[i].colonne <- -1
			FIN
		FIN
		SINON
		DEBUT
			creationBateau.cellules[i].ligne <- -1
			creationBateau.cellules[i].colonne <- -1
		FIN
	FIN
FIN

FONCTION testBateau(cellule : cellule bateau : bateau) : BOOLEEN
	
VAR
	i : ENTIER
	
DEBUT
	testBateau<-false
	POUR i<-1Alength(bateau.cellules) FAIRE
	DEBUT
		SI comparaisonCellules(cellule, bateau.cellules[i]) ALORS
			testBateau<-true
	FIN
FIN
	
FONCTION testFlotte (cellule : cellule flotte : flotte) : BOOLEEN

VAR
	i : ENTIER

DEBUT
	testFlotte<-false
	POUR i<-1Alength(flotte.bateaux) FAIRE
	DEBUT
		SI testBateau(cellule, flotte.bateaux[i]) ALORS
			testFlotte<-true
	FIN
FIN

//On affiche le plateau de jeu
PROCEDURE affichageTerrain ()

VAR
	i, j : ENTIER
	
DEBUT
	//Le terrain du joueur
	POUR i<-0A10 FAIRE
	DEBUT
		POUR j<-0A10 FAIRE
		DEBUT
			SI (i=0) ALORS
			DEBUT
				SI(j=0) ALORS
				DEBUT
					ECRIRE('   ')
				FIN
				SINON
				DEBUT
					ECRIRE ('|', chr(65+j-1))
				FIN
			FIN
			SINON
			DEBUT
				SI(j=0) ALORS
				DEBUT
					SI (i < 10) ALORS
					DEBUT
						ECRIRE('|0', i)
					FIN
					SINON
					DEBUT
						ECRIRE('|', i)
					FIN
				FIN
				SINON
				DEBUT
					ECRIRE('|~')
				FIN
			FIN
			SI (j=10) ALORS
			DEBUT
				ECRIRE('|')
			FIN
		FIN
		ECRIRE()
	FIN
	
	//Le terrain de l'adversaire
	gotoxy(1, 12)
	POUR i DE 0 A 10 FAIRE
	DEBUT
		POUR j DE 0 A 10 FAIRE
		DEBUT
			SI (i=0) ALORS
			DEBUT
				SI(j=0) ALORS
				DEBUT
					ECRIRE('   ')
				FIN
				SINON
				DEBUT
					ECRIRE ('|', chr(65+j-1))
				FIN
			FIN
			SINON
			DEBUT
				SI(j=0) ALORS
				DEBUT
					SI (i < 10) ALORS
					DEBUT
						ECRIRE('|0', i)
					FIN
					SINON
					DEBUT
						ECRIRE('|', i)
					FIN
				FIN
				SINON
				DEBUT
					ECRIRE('|~')
				FIN
			FIN
			SI (j=10) ALORS
			DEBUT
				ECRIRE('|')
			FIN
		FIN
		ECRIRE()
	FIN
FIN

//Déplacement vers une cas
PROCEDURE allerVerscas(x, y : ENTIER terrain : BOOLEEN)

DEBUT
	SI terrain ALORS
		gotoxy(x*2+3, y+12)
	SINON
		gotoxy(x*2+3, y+1)
FIN

PROCEDURE afficherTexte (texte : CHAINE ligne : ENTIER)

DEBUT
	gotoxy(26, ligne)
	ECRIRE(texte)
FIN

PROCEDURE nettoyageEcran()

VAR
	nettoyageX, nettoyageY : ENTIER

DEBUT
	POUR nettoyageY<-1A5 FAIRE
	DEBUT
		POUR nettoyageX<-26A70 FAIRE
		DEBUT
			gotoxy(nettoyageX, nettoyageY)
			ECRIRE(' ')
		FIN
	FIN
FIN

FONCTION navigation(terrainAdversaire : BOOLEEN) : cellule

VAR
	key : char
	x, y : ENTIER

DEBUT
x <- 5
y <- 5

SI terrainAdversaire ALORS
	allerVerscas(x, y, true)
SINON
	allerVerscas(x, y, false)
REPETER
    key<-LIREKey
    CAS key PARMI
		#75 :
		DEBUT
			SI (x-1 > 0) ALORS
			DEBUT
				x<-x-1
				SI terrainAdversaire ALORS
					allerVerscas(x, y, true)
				SINON 
					allerVerscas(x, y, false)
			FIN
		FIN
        #77 :
		DEBUT
			SI (x+1 <= 10) ALORS
			DEBUT
				x<-x+1
				SI terrainAdversaire ALORS
					allerVerscas(x, y, true)
				SINON 
					allerVerscas(x, y, false)
			FIN
		FIN
		#72:
		DEBUT
			SI (y-1 > 0) ALORS
			DEBUT
				y<-y-1
				SI terrainAdversaire ALORS
					allerVerscas(x, y, true)
				SINON 
					allerVerscas(x, y, false)
			FIN
		FIN
		#80:
		DEBUT
			SI (y+1 <= 10) ALORS
			DEBUT
				y<-y+1
				SI terrainAdversaire ALORS
					allerVerscas(x, y, true)
				SINON 
					allerVerscas(x, y, false)
			FIN
		FIN
    FIN
JUSQU'A key=#13

navigation<-creationCellule(x, y)
FIN

FONCTION choixDirection() : CHAINE

VAR
	key : char

DEBUT
REPETER
    key<-LIREKey
    cas key DE
		#75 :
		DEBUT
			nettoyageEcran()
			afficherTexte('Gauche', 1)
			choixDirection<-'gauche'
		FIN
        #77 :
		DEBUT
			nettoyageEcran()
			afficherTexte('Droite', 1)
			choixDirection<-'droite'
		FIN
		#72:
		DEBUT
			nettoyageEcran()
			afficherTexte('Haut', 1)
			choixDirection<-'haut'
		FIN
		#80:
		DEBUT
			nettoyageEcran()
			afficherTexte('Bas', 1)
			choixDirection<-'bas'
		FIN
    FIN
JUSQU'A key=#13

FIN

FONCTION tourJoueur(var flotte : flotte cassTouchees : TABLEAU DE cellule) : cellule

VAR
	casSelectionnee : cellule
	attaque : BOOLEEN
	i, j : ENTIER

DEBUT
	REPETER
		attaque<-false
		afficherTexte('Choisissez la cas a attaquer : ', 3)
		
		casSelectionnee<-navigation(true)
		
		POUR i<-1Alength(cassTouchees) FAIRE
		DEBUT
			SI (comparaisonCellules(casSelectionnee, cassTouchees[i-1])) ALORS
			DEBUT
				afficherTexte('Vous avez deja attaque cette cas.', 4)
				attaque<-false
				break
			FIN
			SINON
			DEBUT
				attaque<-true
			FIN
		FIN
	JUSQU'A attaque=true
	
	
	SI testFlotte(casSelectionnee, flotte) ALORS
	DEBUT
		POUR i<-1Alength(flotte.bateaux) FAIRE
		DEBUT
			SI (testBateau(casSelectionnee, flotte.bateaux[i])) ALORS
			DEBUT
				flotte.bateaux[i].vie<-flotte.bateaux[i].vie-1
				SI flotte.bateaux[i].vie > 0 ALORS
				DEBUT
					afficherTexte('Touche !', 2)
					allerVerscas(casSelectionnee.ligne, casSelectionnee.colonne, true)
					ECRIRE('T')
				FIN
				SINON
				DEBUT
					afficherTexte('Coule !', 2)
					flotte.taille<-flotte.taille-1
					POUR j<-1Alength(flotte.bateaux) FAIRE
					DEBUT
						allerVerscas(flotte.bateaux[i].cellules[j].ligne, flotte.bateaux[i].cellules[j].colonne, true)
						ECRIRE('C')
					FIN
					
				FIN
			FIN
		FIN
	FIN
	SINON
	DEBUT
		afficherTexte('A l''eau', 2)
		
		allerVerscas(casSelectionnee.ligne, casSelectionnee.colonne, true)
		ECRIRE('*')
	FIN
	afficherTexte('Appuyez sur entree pour continuer...', 3)
	LIRE()
	tourJoueur<-casSelectionnee
FIN

FONCTION tourAdversaire(var flotte : flotte cassTouchees : TABLEAU DE cellule) : cellule

VAR
	casSelectionnee : cellule
	attaque : BOOLEEN
	i, j : ENTIER
	
DEBUT
	REPETER
		attaque<-false
		
		casSelectionnee<-creationCellule(rETom(10)+1, rETom(10)+1)
		
		POUR i<-1Alength(cassTouchees) FAIRE
		DEBUT
			SI (comparaisonCellules(casSelectionnee, cassTouchees[i-1])) ALORS
			DEBUT
				attaque<-false
				break
			FIN
			SINON
			DEBUT
				attaque<-true
			FIN
		FIN
	JUSQU'A attaque=true
	
	
	SI testFlotte(casSelectionnee, flotte) ALORS
	DEBUT
		POUR i<-1Alength(flotte.bateaux) FAIRE
		DEBUT
			SI (testBateau(casSelectionnee, flotte.bateaux[i])) ALORS
			DEBUT
				flotte.bateaux[i].vie<-flotte.bateaux[i].vie-1
				SI flotte.bateaux[i].vie > 0 ALORS
				DEBUT
					afficherTexte('Touche !', 2)
					allerVerscas(casSelectionnee.ligne, casSelectionnee.colonne, false)
					ECRIRE('T')
				FIN
				SINON
				DEBUT
					afficherTexte('Coule !', 2)
					flotte.taille<-flotte.taille-1
					
					POUR j<-1Aflotte.bateaux[i].taille FAIRE
					DEBUT
						allerVerscas(flotte.bateaux[i].cellules[j].ligne, flotte.bateaux[i].cellules[j].colonne, false)
						ECRIRE('C')
					FIN
				FIN
			FIN
		FIN
	FIN
	SINON
	DEBUT
		afficherTexte('A l''eau', 2)
		allerVerscas(casSelectionnee.ligne, casSelectionnee.colonne, false)
		ECRIRE('*')
	FIN
	afficherTexte('Appuyez sur entree pour continuer...', 3)
	LIRE()
	tourAdversaire<-casSelectionnee
FIN

VAR
	ligne, colonne, tailleBateau, rETomDirection,rETomPositionX, rETomPositionY, tour, i, j : ENTIER
	directionBateau : CHAINE
	bateauTest : bateau
	casSelectionnee : cellule
	flotteJoueur, flotteAdversaire : flotte
	placementCOUrect : BOOLEEN
	joueurcassTouchees, adversairecassTouchees : TABLEAU[1..100] DE cellule
	
DEBUT
	rETomize
	clrscr
	
	affichageTerrain()
	
	//On initialise les flottes
	flotteJoueur.taille<-5
	flotteAdversaire.taille<-5
	
	//Le joueur place ses bateaux
	POUR i<-1Alength(flotteJoueur.bateaux) FAIRE
	DEBUT
	REPETER
		cas i DE
			1: tailleBateau<-5
			2: tailleBateau<-4
			3: tailleBateau<-3
			4: tailleBateau<-3
			5: tailleBateau<-2
		FIN
	
		nettoyageEcran()
		afficherTexte('Choisissez ou vous voulez placer votre', 1)
		
		cas i DE
			1: afficherTexte('pOUte-avions (5 cass)', 2)
			2: afficherTexte('croiseur (4 cass)', 2)
			3: afficherTexte('contre-tOUpilleur (3 cass)', 2)
			4: afficherTexte('sous-marin (3 cass)', 2)
			5: afficherTexte('tOUpilleur (2 cass)', 2)
		FIN
	
		afficherTexte('Appuyez sur entree pour valider', 4)
	
		casSelectionnee<-navigation(false)
	
		nettoyageEcran()
		afficherTexte('Choisissez la direction de votre', 1)
		cas i DE
			1: afficherTexte('pOUte-avions', 2)
			2: afficherTexte('croiseur', 2)
			3: afficherTexte('contre-tOUpilleur', 2)
			4: afficherTexte('sous-marin', 2)
			5: afficherTexte('tOUpilleur', 2)
		FIN
		
		directionBateau<-choixDirection()
	
		bateauTest<-creationBateau(casSelectionnee, tailleBateau, directionBateau)
		placementCOUrect<-false
		POUR j<-1AtailleBateau FAIRE
		DEBUT
			SI (placementCOUrect=false) ALORS
			DEBUT
				placementCOUrect<-testFlotte(bateauTest.cellules[j], flotteJoueur)
			FIN
			SI (bateauTest.cellules[j].ligne <= 0) OU (bateauTest.cellules[j].ligne > 10) OU (bateauTest.cellules[j].colonne <= 0) OU (bateauTest.cellules[j].colonne > 10) ALORS
			DEBUT
				placementCOUrect<-true
			FIN
		FIN
	
		SI placementCOUrect=false ALORS
		DEBUT
			flotteJoueur.bateaux[i]<-bateauTest
			
			POUR j<-1AtailleBateau FAIRE
			DEBUT
				allerVerscas(flotteJoueur.bateaux[i].cellules[j].ligne, flotteJoueur.bateaux[i].cellules[j].colonne, false)
				ECRIRE('B')
			FIN
		FIN
		SINON
		DEBUT
			afficherTexte('Placement incOUrect', 3)
			LIRE()
		FIN
	JUSQU'A placementCOUrect=false
	FIN
	
	//On place aléatoirement les bateaux de l'adversaire
	afficherTexte('Votre adversaire place ses bateaux.', 1)
	afficherTexte('Appuyez sur entree pour continuer...', 2)
	LIRE()
		
	POUR i<-1Alength(flotteAdversaire.bateaux) FAIRE
	DEBUT
	REPETER
		
		cas i DE
			1: tailleBateau<-5
			2: tailleBateau<-4
			3: tailleBateau<-3
			4: tailleBateau<-3
			5: tailleBateau<-2
		FIN
		
		rETomDirection<-rETom(4)+1
		
		cas rETomDirection DE
			1: directionBateau<-'haut'
			2: directionBateau<-'bas'
			3: directionBateau<-'gauche'
			4: directionBateau<-'droite'
		FIN
		
		
		rETomPositionX<-rETom(10)+1
		rETomPositionY<-rETom(10)+1
		
		bateauTest<-creationBateau(creationCellule(rETomPositionX, rETomPositionY), tailleBateau, directionBateau)
		placementCOUrect<-false
		
		POUR j<-1AtailleBateau FAIRE
		DEBUT
			SI (placementCOUrect=false) ALORS
			DEBUT
				placementCOUrect<-testFlotte(bateauTest.cellules[j], flotteAdversaire)
			FIN
			SI (bateauTest.cellules[j].ligne <= 0) OU (bateauTest.cellules[j].ligne > 10) OU (bateauTest.cellules[j].colonne <= 0) OU (bateauTest.cellules[j].colonne > 10) ALORS
			DEBUT
				placementCOUrect<-true
			FIN
		FIN		
	
		SI placementCOUrect=false ALORS
		DEBUT
			flotteAdversaire.bateaux[i]<-bateauTest
		FIN
	JUSQU'A placementCOUrect=false
	FIN
	
	//On initialise les cass du joueur touchées
	POUR i<-1A100 FAIRE
	DEBUT
		joueurcassTouchees[i].ligne<-0
		joueurcassTouchees[i].colonne<-0
	FIN
	
	//Jeu
	tour<-0
	REPETER
		tour<-tour+1
		//Tour du joueur
		nettoyageEcran()
		afficherTexte('Votre tour...', 1)
		joueurcassTouchees[tour]<-tourJoueur(flotteAdversaire, joueurcassTouchees)

		//Tour de l'adversaire
		nettoyageEcran()
		afficherTexte('Tour de l''adversaire...', 1)
		adversairecassTouchees[tour]<-tourAdversaire(flotteJoueur, adversairecassTouchees)
	JUSQU'A (flotteJoueur.taille <= 0) OU (flotteAdversaire.taille <= 0)
	
	SI (flotteAdversaire.taille <= 0) ALORS
	DEBUT
		nettoyageEcran()
		afficherTexte('Gagne !!', 1)
	FIN
	SINON
	DEBUT
		nettoyageEcran()
		afficherTexte('Perdu...', 1)
	FIN
	LIRE()
FIN.
}

program batailleNavale;

uses crt;

type
	cellule = record
		ligne, colonne : integer;
end;

type
	bateau = record
		cellules : array[1..5] of cellule;
		taille : integer;
		vie : integer;
end;

type
	flotte = record
		bateaux : array[1..5] of bateau;
		taille : integer;
end;



function creationCellule (ligne, colonne : integer) : cellule;

VAR
	coordonnees : cellule;

BEGIN
	coordonnees.ligne := ligne;
	coordonnees.colonne := colonne;
	creationCellule := coordonnees;
END;

//On compare deux cellules
function comparaisonCellules (cellule1, cellule2 : cellule) : boolean;

BEGIN
	if ((cellule1.ligne = cellule2.ligne) and (cellule1.colonne = cellule2.colonne)) then
		comparaisonCellules := true
	else
		comparaisonCellules := false
END;


//On crée un bateau
function creationBateau (origine : cellule; taille : integer; direction : string) : bateau;

VAR
	i : integer;

BEGIN
	creationBateau.taille:=taille;
	creationBateau.vie:=taille;
	for i:=1 to 5 do
	BEGIN
		if i <= taille then
		BEGIN
			if direction = 'bas' then
			BEGIN
				creationBateau.cellules[i].ligne := origine.ligne;
				creationBateau.cellules[i].colonne := origine.colonne + i - 1;
			END
			else if direction = 'droite' then
			BEGIN
				creationBateau.cellules[i].ligne := origine.ligne + i - 1;
				creationBateau.cellules[i].colonne := origine.colonne;
			END
			else if direction = 'gauche' then
			BEGIN
				creationBateau.cellules[i].ligne := origine.ligne - i + 1;
				creationBateau.cellules[i].colonne := origine.colonne;
			END
			else if direction = 'haut' then
			BEGIN
				creationBateau.cellules[i].ligne := origine.ligne;
				creationBateau.cellules[i].colonne := origine.colonne - i + 1;
			END
			else
			BEGIN
				writeln('Erreur dans la direction');
				creationBateau.cellules[i].ligne := -1;
				creationBateau.cellules[i].colonne := -1;
			END;
		END
		else
		BEGIN
			creationBateau.cellules[i].ligne := -1;
			creationBateau.cellules[i].colonne := -1;
		END;
	END;
END;

function testBateau(cellule : cellule; bateau : bateau) : boolean;
	
VAR
	i : integer;
	
BEGIN
	testBateau:=false;
	for i:=1 to length(bateau.cellules) do
	BEGIN
		if comparaisonCellules(cellule, bateau.cellules[i]) then
			testBateau:=true
	END;
END;
	
function testFlotte (cellule : cellule; flotte : flotte) : boolean;

VAR
	i : integer;

BEGIN
	testFlotte:=false;
	for i:=1 to length(flotte.bateaux) do
	BEGIN
		if testBateau(cellule, flotte.bateaux[i]) then
			testFlotte:=true
	END;
END;

//On affiche le plateau de jeu
procedure affichageTerrain ();

VAR
	i, j : integer;
	
BEGIN
	//Le terrain du joueur
	for i:=0 to 10 do
	BEGIN
		for j:=0 to 10 do
		BEGIN
			if (i=0) then
			BEGIN
				if(j=0) then
				BEGIN
					write('   ');
				END
				else
				BEGIN
					write ('|', chr(65+j-1));
				END;
			END
			else
			BEGIN
				if(j=0) then
				BEGIN
					if (i < 10) then
					BEGIN
						write('|0', i);
					END
					else
					BEGIN
						write('|', i);
					END;
				END
				else
				BEGIN
					write('|~');
				END;
			END;
			if (j=10) then
			BEGIN
				write('|');
			END;
		END;
		writeln();
	END;
	
	//Le terrain de l'adversaire
	gotoxy(1, 12);
	for i:=0 to 10 do
	BEGIN
		for j:=0 to 10 do
		BEGIN
			if (i=0) then
			BEGIN
				if(j=0) then
				BEGIN
					write('   ');
				END
				else
				BEGIN
					write ('|', chr(65+j-1));
				END;
			END
			else
			BEGIN
				if(j=0) then
				BEGIN
					if (i < 10) then
					BEGIN
						write('|0', i);
					END
					else
					BEGIN
						write('|', i);
					END;
				END
				else
				BEGIN
					write('|~');
				END;
			END;
			if (j=10) then
			BEGIN
				write('|');
			END;
		END;
		writeln();
	END;
END;

//Déplacement vers une case
procedure allerVersCase(x, y : integer; terrain : boolean);

BEGIN
	if terrain then
		gotoxy(x*2+3, y+12)
	else
		gotoxy(x*2+3, y+1);
END;

procedure afficherTexte (texte : string; ligne : integer);

BEGIN
	gotoxy(26, ligne);
	write(texte);
END;

procedure nettoyageEcran();

VAR
	nettoyageX, nettoyageY : integer;

BEGIN
	for nettoyageY:=1 to 5 do
	BEGIN
		for nettoyageX:=26 to 70 do
		BEGIN
			gotoxy(nettoyageX, nettoyageY);
			write(' ');
		END;
	END;
END;

function navigation(terrainAdversaire : boolean) : cellule;

VAR
	key : char;
	x, y : integer;

BEGIN
x := 5;
y := 5;

if terrainAdversaire then
	allerVersCase(x, y, true)
else
	allerVersCase(x, y, false);
repeat
    key:=ReadKey;
    case key of
		#75 :
		BEGIN
			if (x-1 > 0) then
			BEGIN
				x:=x-1;
				if terrainAdversaire then
					allerVersCase(x, y, true)
				else 
					allerVersCase(x, y, false)
			END;
		END;
        #77 :
		BEGIN
			if (x+1 <= 10) then
			BEGIN
				x:=x+1;
				if terrainAdversaire then
					allerVersCase(x, y, true)
				else 
					allerVersCase(x, y, false)
			END;
		END;
		#72:
		BEGIN
			if (y-1 > 0) then
			BEGIN
				y:=y-1;
				if terrainAdversaire then
					allerVersCase(x, y, true)
				else 
					allerVersCase(x, y, false)
			END;
		END;
		#80:
		BEGIN
			if (y+1 <= 10) then
			BEGIN
				y:=y+1;
				if terrainAdversaire then
					allerVersCase(x, y, true)
				else 
					allerVersCase(x, y, false)
			END;
		END;
    end;
until key=#13;

navigation:=creationCellule(x, y);
END;

function choixDirection() : string;

VAR
	key : char;

BEGIN
repeat
    key:=ReadKey;
    case key of
		#75 :
		BEGIN
			nettoyageEcran();
			afficherTexte('Gauche', 1);
			choixDirection:='gauche';
		END;
        #77 :
		BEGIN
			nettoyageEcran();
			afficherTexte('Droite', 1);
			choixDirection:='droite';
		END;
		#72:
		BEGIN
			nettoyageEcran();
			afficherTexte('Haut', 1);
			choixDirection:='haut';
		END;
		#80:
		BEGIN
			nettoyageEcran();
			afficherTexte('Bas', 1);
			choixDirection:='bas';
		END;
    end;
until key=#13;

END;

function tourJoueur(var flotte : flotte; casesTouchees : array of cellule) : cellule;

VAR
	caseSelectionnee : cellule;
	attaque : boolean;
	i, j : integer;

BEGIN
	repeat
		attaque:=false;
		afficherTexte('Choisissez la case a attaquer : ', 3);
		
		caseSelectionnee:=navigation(true);
		
		for i:=1 to length(casesTouchees) do
		BEGIN
			if (comparaisonCellules(caseSelectionnee, casesTouchees[i-1])) then
			BEGIN
				afficherTexte('Vous avez deja attaque cette case.', 4);
				attaque:=false;
				break;
			END
			else
			BEGIN
				attaque:=true;
			END;
		END;
	until attaque=true;
	
	
	if testFlotte(caseSelectionnee, flotte) then
	BEGIN
		for i:=1 to length(flotte.bateaux) do
		BEGIN
			if (testBateau(caseSelectionnee, flotte.bateaux[i])) then
			BEGIN
				flotte.bateaux[i].vie:=flotte.bateaux[i].vie-1;
				if flotte.bateaux[i].vie > 0 then
				BEGIN
					afficherTexte('Touche !', 2);
					allerVersCase(caseSelectionnee.ligne, caseSelectionnee.colonne, true);
					write('T');
				END
				else
				BEGIN
					afficherTexte('Coule !', 2);
					flotte.taille:=flotte.taille-1;
					for j:=1 to length(flotte.bateaux) do
					BEGIN
						allerVersCase(flotte.bateaux[i].cellules[j].ligne, flotte.bateaux[i].cellules[j].colonne, true);
						write('C');
					END;
					
				END;
			END;
		END;
	END
	else
	BEGIN
		afficherTexte('A l''eau', 2);
		
		allerVersCase(caseSelectionnee.ligne, caseSelectionnee.colonne, true);
		write('*');
	END;
	afficherTexte('Appuyez sur entree pour continuer...', 3);
	readln();
	tourJoueur:=caseSelectionnee;
END;

function tourAdversaire(var flotte : flotte; casesTouchees : array of cellule) : cellule;

VAR
	caseSelectionnee : cellule;
	attaque : boolean;
	i, j : integer;
	
BEGIN
	repeat
		attaque:=false;
		
		caseSelectionnee:=creationCellule(random(10)+1, random(10)+1);
		
		for i:=1 to length(casesTouchees) do
		BEGIN
			if (comparaisonCellules(caseSelectionnee, casesTouchees[i-1])) then
			BEGIN
				attaque:=false;
				break;
			END
			else
			BEGIN
				attaque:=true;
			END;
		END;
	until attaque=true;
	
	
	if testFlotte(caseSelectionnee, flotte) then
	BEGIN
		for i:=1 to length(flotte.bateaux) do
		BEGIN
			if (testBateau(caseSelectionnee, flotte.bateaux[i])) then
			BEGIN
				flotte.bateaux[i].vie:=flotte.bateaux[i].vie-1;
				if flotte.bateaux[i].vie > 0 then
				BEGIN
					afficherTexte('Touche !', 2);
					allerVersCase(caseSelectionnee.ligne, caseSelectionnee.colonne, false);
					write('T');
				END
				else
				BEGIN
					afficherTexte('Coule !', 2);
					flotte.taille:=flotte.taille-1;
					
					for j:=1 to flotte.bateaux[i].taille do
					BEGIN
						allerVersCase(flotte.bateaux[i].cellules[j].ligne, flotte.bateaux[i].cellules[j].colonne, false);
						write('C');
					END;
				END;
			END;
		END;
	END
	else
	BEGIN
		afficherTexte('A l''eau', 2);
		allerVersCase(caseSelectionnee.ligne, caseSelectionnee.colonne, false);
		write('*');
	END;
	afficherTexte('Appuyez sur entree pour continuer...', 3);
	readln();
	tourAdversaire:=caseSelectionnee;
END;

VAR
	ligne, colonne, tailleBateau, randomDirection,randomPositionX, randomPositionY, tour, i, j : integer;
	directionBateau : string;
	bateauTest : bateau;
	caseSelectionnee : cellule;
	flotteJoueur, flotteAdversaire : flotte;
	placementCorrect : boolean;
	joueurCasesTouchees, adversaireCasesTouchees : array[1..100] of cellule;
	
BEGIN
	randomize;
	clrscr;
	
	affichageTerrain();
	
	//On initialise les flottes
	flotteJoueur.taille:=5;
	flotteAdversaire.taille:=5;
	
	//Le joueur place ses bateaux
	for i:=1 to length(flotteJoueur.bateaux) do
	BEGIN
	repeat
		case i of
			1: tailleBateau:=5;
			2: tailleBateau:=4;
			3: tailleBateau:=3;
			4: tailleBateau:=3;
			5: tailleBateau:=2;
		end;
	
		nettoyageEcran();
		afficherTexte('Choisissez ou vous voulez placer votre', 1);
		
		case i of
			1: afficherTexte('porte-avions (5 cases)', 2);
			2: afficherTexte('croiseur (4 cases)', 2);
			3: afficherTexte('contre-torpilleur (3 cases)', 2);
			4: afficherTexte('sous-marin (3 cases)', 2);
			5: afficherTexte('torpilleur (2 cases)', 2);
		end;
	
		afficherTexte('Appuyez sur entree pour valider', 4);
	
		caseSelectionnee:=navigation(false);
	
		nettoyageEcran();
		afficherTexte('Choisissez la direction de votre', 1);
		case i of
			1: afficherTexte('porte-avions', 2);
			2: afficherTexte('croiseur', 2);
			3: afficherTexte('contre-torpilleur', 2);
			4: afficherTexte('sous-marin', 2);
			5: afficherTexte('torpilleur', 2);
		end;
		
		directionBateau:=choixDirection();
	
		bateauTest:=creationBateau(caseSelectionnee, tailleBateau, directionBateau);
		placementCorrect:=false;
		for j:=1 to tailleBateau do
		BEGIN
			if (placementCorrect=false) then
			BEGIN
				placementCorrect:=testFlotte(bateauTest.cellules[j], flotteJoueur);
			END;
			if (bateauTest.cellules[j].ligne <= 0) or (bateauTest.cellules[j].ligne > 10) or (bateauTest.cellules[j].colonne <= 0) or (bateauTest.cellules[j].colonne > 10) then
			BEGIN
				placementCorrect:=true;
			END;
		END;
	
		if placementCorrect=false then
		BEGIN
			flotteJoueur.bateaux[i]:=bateauTest;
			
			for j:=1 to tailleBateau do
			BEGIN
				allerVersCase(flotteJoueur.bateaux[i].cellules[j].ligne, flotteJoueur.bateaux[i].cellules[j].colonne, false);
				write('B');
			END;
		END
		else
		BEGIN
			afficherTexte('Placement incorrect', 3);
			readln();
		END;
	until placementCorrect=false;
	END;
	
	//On place aléatoirement les bateaux de l'adversaire
	afficherTexte('Votre adversaire place ses bateaux.', 1);
	afficherTexte('Appuyez sur entree pour continuer...', 2);
	readln();
		
	for i:=1 to length(flotteAdversaire.bateaux) do
	BEGIN
	repeat
		
		case i of
			1: tailleBateau:=5;
			2: tailleBateau:=4;
			3: tailleBateau:=3;
			4: tailleBateau:=3;
			5: tailleBateau:=2;
		end;
		
		randomDirection:=random(4)+1;
		
		case randomDirection of
			1: directionBateau:='haut';
			2: directionBateau:='bas';
			3: directionBateau:='gauche';
			4: directionBateau:='droite';
		end;
		
		
		randomPositionX:=random(10)+1;
		randomPositionY:=random(10)+1;
		
		bateauTest:=creationBateau(creationCellule(randomPositionX, randomPositionY), tailleBateau, directionBateau);
		placementCorrect:=false;
		
		for j:=1 to tailleBateau do
		BEGIN
			if (placementCorrect=false) then
			BEGIN
				placementCorrect:=testFlotte(bateauTest.cellules[j], flotteAdversaire);
			END;
			if (bateauTest.cellules[j].ligne <= 0) or (bateauTest.cellules[j].ligne > 10) or (bateauTest.cellules[j].colonne <= 0) or (bateauTest.cellules[j].colonne > 10) then
			BEGIN
				placementCorrect:=true;
			END;
		END;		
	
		if placementCorrect=false then
		BEGIN
			flotteAdversaire.bateaux[i]:=bateauTest;
		END;
	until placementCorrect=false;
	END;
	
	//On initialise les cases du joueur touchées
	for i:=1 to 100 do
	BEGIN
		joueurCasesTouchees[i].ligne:=0;
		joueurCasesTouchees[i].colonne:=0;
	END;
	
	//Jeu
	tour:=0;
	repeat
		tour:=tour+1;
		//Tour du joueur
		nettoyageEcran();
		afficherTexte('Votre tour...', 1);
		joueurCasesTouchees[tour]:=tourJoueur(flotteAdversaire, joueurCasesTouchees);

		//Tour de l'adversaire
		nettoyageEcran();
		afficherTexte('Tour de l''adversaire...', 1);
		adversaireCasesTouchees[tour]:=tourAdversaire(flotteJoueur, adversaireCasesTouchees);
	until (flotteJoueur.taille <= 0) or (flotteAdversaire.taille <= 0);
	
	if (flotteAdversaire.taille <= 0) then
	BEGIN
		nettoyageEcran();
		afficherTexte('Gagne !!', 1);
	END
	else
	BEGIN
		nettoyageEcran();
		afficherTexte('Perdu...', 1);
	END;
	readln();
END.
