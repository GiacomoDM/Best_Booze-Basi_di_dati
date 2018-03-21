/* Database Progetto: Best Booze - Del Moro Giacomo 1123117, Coletti Andrea 1096089 */
/* Ogni riferimento a persone esistenti o a fatti realmente accaduti è puramente casuale. */


SET FOREIGN_KEY_CHECKS = 0;


/* Creazione tabelle per il Database */


DROP TABLE IF EXISTS Cliente;

CREATE TABLE Cliente (

    Username VARCHAR(20),
    Nominativo VARCHAR(50),
    Indirizzo VARCHAR(50), 
    Email VARCHAR(50), 
    Telefono VARCHAR(10), 
    PartitaIVA VARCHAR(11) DEFAULT NULL,
    
    PRIMARY KEY (Username)
);

DROP TABLE IF EXISTS Prodotto;

CREATE TABLE Prodotto (

    Codice INT, 
    Nome VARCHAR(30), 
    Prezzo NUMERIC(8,2), 
    Categoria VARCHAR(20), 
    Anno YEAR DEFAULT NULL, 
    Produttore VARCHAR(20),

    PRIMARY KEY (Codice)
);

DROP TABLE IF EXISTS Carrello;

CREATE TABLE Carrello (
	   
    Prodotto INT, 	
    OrdineInCorso INT, 
    Quantità SMALLINT, 
    Costo NUMERIC(8,2),
    
    PRIMARY KEY (Prodotto, OrdineInCorso),
    FOREIGN KEY (Prodotto) REFERENCES Prodotto(Codice) ON DELETE CASCADE,
    FOREIGN KEY (OrdineInCorso) REFERENCES OrdineInCorso(ID) ON DELETE CASCADE 
);

DROP TABLE IF EXISTS OrdineInCorso;

CREATE TABLE OrdineInCorso (
    
    ID INT, 
    Cliente VARCHAR(20), 
    Data DATE, 
    PrezzoProdotti NUMERIC(8,2) DEFAULT 0,
    
    PRIMARY KEY (ID),
    FOREIGN KEY (Cliente) REFERENCES Cliente(Username) ON DELETE NO ACTION
); 

DROP TABLE IF EXISTS Fattura;

CREATE TABLE Fattura (
    
    ID INT, 
    Intestatario VARCHAR(20),
    Data DATE,
    Totale NUMERIC(8,2),
    
    PRIMARY KEY (ID),
    FOREIGN KEY (Intestatario) REFERENCES Cliente(Username) ON DELETE NO ACTION
);

DROP TABLE IF EXISTS DettaglioFattura;

CREATE TABLE DettaglioFattura (
    
    Fattura INT, 
    Prodotto INT, 
    Quantità SMALLINT, 
    Costo NUMERIC(8,2), 
    
    PRIMARY KEY (Fattura, Prodotto),
    FOREIGN KEY (Fattura) REFERENCES Fattura(ID) ON DELETE CASCADE,
    FOREIGN KEY (Prodotto) REFERENCES Prodotto(Codice) ON DELETE NO ACTION
); 

DROP TABLE IF EXISTS OrdineConcluso;

CREATE TABLE OrdineConcluso (
    
    ID INT, 
    Fattura INT, 
    Spedizione ENUM('Standard', 'Express', 'Daily'), 
    GiorniLavorativi ENUM('7-10', '3-5', '1'), 
    CostoFinale NUMERIC(8,2), 
    
    PRIMARY KEY (ID),
    FOREIGN KEY (Fattura) REFERENCES Fattura(ID) ON DELETE NO ACTION
);


/* Popolo le tabelle */


INSERT INTO Cliente (Username, Nominativo, Indirizzo, Email, Telefono, PartitaIVA) 
VALUES ('gdelmoro','Giacomo Del Moro','via Venezia 15, Padova','gdelmoro@mail.it','3485647896', NULL), ('acoletti','Andrea Coletti','via Tommaseo 68, Padova','acoletti@mail.it','3659845621', NULL), ('frossi','Francesco Rossi','via Roma 1, Udine','frossi@mail.it','3296514782','21648579623'), ('mverdi','Mario Verdi','via Firenze 78, Torino','mverdi@mail.it','3453164978', NULL), ('gbruni','Giovanni Bruni','viale Ledra 10, Udine','gbruni@mail.it','3211233211', NULL), ('maztek','Maztek S.p.a.','via Napoli 128, Milano','maztek@maztek.com','02346985','21675943028'), ('aibagni','Bar ai Bagni','piazzale XXVI Luglio 4, Udine','bar@aibagni.it','0432150099','69851302657'), ('mconti','Mauro Conti','via Venezia 63, Padova','mconti@mail.it','049657815', NULL), ('discostu','Discoteca Discostu','via Udine 31, Milano','discoteca@discostu.it','02657811','12345678910'), ('hpalace','Hotel Palace','via Savonarola 49, Torino','hotel@palace.it','0123456789','98765432108'), ('aravanelli','Andrea Ravanelli','via Portello 14, Padova','aravanelli@mail.it','3488520258', NULL), ('bbagnato','Barbara Bagnato','viale Europa Unita 254, Milano','bbagnato@mail.it','3931237894', NULL), ('aviola','Anna Viola','piazzetta San Cristoforo 5, Torino','aviola@mail.it','3210044587', NULL), ('fmano','Federica Mano','via Trieste 69, Firenze','fmano@mail.it','3333113131','99846582103'), ('gmarquina','Genoveffa Marquina','corso Stati Uniti 648, Roma','gmarquina@mail.it','3249888870', NULL), ('mmarchetto','Marco Marchettini','via Drenassi 44, Sella Nevea','mmarc@libero.it','3451117890', NULL), ('univep','Univep S.r.l','via Angioni 64, Varese','univep11@mail.it','0415778822','00211340198');

INSERT INTO Prodotto (Codice, Nome, Prezzo, Categoria, Anno, Produttore) 
VALUES (567844,'Uber Lager','5.00','Birra','2008','Uber'), (125647,'Montenegro','12.00','Distillato','2005','MontenegroSRL'), (610227,'Brut','4.00','Vino','2002','Amietti'), (445771,'Ribolla Gialla','22.00','Vino','2006','Frassini'), (781130,'Sauvignon','7.50','Vino','2003','Fabbrideico'), (445701,'Fragolino','9.80','Liquori','2011','Zibbino'), (461026,'Mirto','6.70','Liquori','1997','Esperd'), (121045,'Bacardi','14.00','Superalcolici','2015','Zappi'), (650021,'Amaro Lucano','17.00','Superalcolici','2016','Frossi'), (223456,'Château Lafite','117530.00','Vino','1901','Rothschild'), (608793,'Apple Jack','7.00','Superalcolici','2009','Sbrontz'), (497760,'Jägermeister','9.77','Superalcolici','2001','Quiry'), (220115,'Richbourg','16000.00','Vino','1980','Côte-d’Or'), (544953,'Daiquiri','9.00','Cocktail','2004','Saffi'), (697452,'Rosolio','13.00','Liquori','2013','ACQUAVAs'), (235541,'Gin Fizz','11.80','Cocktail','2011','Aerte'), (121234,'Angry Orchard','14.00','Sidro','1999','Dufflung '), (343465,'Old Fashioned','6.50','Cocktail','2009','Passanti'), (555567,'Harp Lager','6.20','Birra','2011','Fritaio'), (334218,'Sambuca','11.00','Liquori','2015','Sempliciottoh'), (095623,'Grolsch','7.00','Birra','1987','Olandiskii'), (459043,'God Mother','17.00','Cocktail','2003','Oaza'), (324053,'Dreher','6.20','Birra','2011','Dinko'), (345686,'Duff','4.30','Birra','2012','Sabbopa'), (466245,'Bollinger Champagne','200.00','Vino','2002','Preppiou'), (987877,'Krug Brut Rosé Champagne','290.00','Vino','1966','Scrapopolo'), (999112,'Grosperrin Cognac Petite','295.00','Vino','1962','Filecomp'), (232131,'Frescobaldi','504.00','Vino','2013','Ventin'), (111112,'Antinori','600.00','Vino','2008','Sabbiosi'), (999234,'Cardinal','6.00','Birra','2015','Pillercompany');

INSERT INTO Carrello (Prodotto, OrdineInCorso, Quantità, Costo)
VALUES (610227,970,5,'20.00'), (121045,970,3,'42.00'), (235541,970,2,'23.60'), (497760,1289,1,'9.77'), (781130,1289,10,'75.00'), (608793,1289,11,'77.00'), (121234,1289,4,'56.00'), (459043,149,100,'1700.00'), (345686,149,200,'860.00'), (445771,4450,2,'44.00'), (461026,4450,5,'33.50'), (324053,4450,6,'37.20'), (567844,4450,2,'10.00'), (567844,7843,7,'35.00'), (445701,7843,2,'19.60'), (343465,7843,1,'6.50'), (999234,1234,10,'60.00'), (555567,3265,3,'18.60'), (650021,3265,6,'102.00'), (544953,3265,7,'63.00');

INSERT INTO OrdineInCorso (ID, Cliente, Data, PrezzoProdotti)
VALUES (1289,'bbagnato','2016-06-24','217.77'), (1234,'gmarquina','2016-07-01','60.00'), (3265,'aviola','2016-06-25','183.60'), (7843,'gbruni','2016-06-29','60.50'), (4450,'fmano','2016-06-05','126.70'), (0970,'frossi','2016-06-21','85.60'), (0149,'maztek','2016-06-17','2560.00');

INSERT INTO Fattura (ID, Intestatario, Data, Totale)
VALUES (498146504,'mconti','2015-12-20','134615.70'), (843020184,'aibagni','2015-09-15','281.00'), (687465120,'gdelmoro','2016-03-08','115200.00'), (436824165,'bbagnato','2015-08-10','199.80'), (462843652,'discostu','2015-10-21','45174.60'), (595629595,'aravanelli','2015-06-21','1646.80'), (468468432,'hpalace','2015-04-17','3349.39'), (416813518,'fmano','2015-03-03','126.00'), (468135138,'acoletti','2015-09-06','2700.00'), (498465815,'frossi','2015-07-06','363.87'), (616831681,'aibagni','2015-02-16','2587.50'), (981651398,'aviola','2015-12-01','72.50'), (613518616,'gmarquina','2016-02-29','32.80'), (681981395,'gdelmoro','2016-05-03','1638.00'), (618498420,'hpalace','2015-11-11','28261.80'), (100649867,'gbruni','2015-08-08','61.25'), (449891195,'aibagni','2015-05-21','1379.66'), (984521385,'maztek','2016-04-15','170775.00'), (489152891,'maztek','2016-05-15','162250.92'), (948561846,'maztek','2016-06-15','47232.00');

INSERT INTO DettaglioFattura (Fattura, Prodotto, Quantità, Costo)
VALUES (498146504,223456,1,'117530.00'), (498146504,220115,2,'32000.00'), (498146504,345686,10,'43.00'), (843020184,125647,5,'60.00'), (843020184,497760,12,'117.24'), (843020184,121045,7,'98.00'), (843020184,345686,2,'8.60'), (687465120,220115,8,'128000.00'), (436824165,235541,16,'188.80'), (436824165,334218,1,'11.00'), (462843652,125647,10,'120.00'), (462843652,111112,30,'18000.00'), (462843652,232131,8,'4032.00'), (462843652,121045,3,'42.00'), (462843652,987877,40,'11600.00'), (462843652,466245,82,'16400.00'), (595629595,459043,60,'1020.00'), (595629595,121045,45,'630.00'), (595629595,095623,20,'140.00'), (468468432,095623,5,'35.00'), (468468432,466245,10,'2000.00'), (468468432,497760,2,'19.54'), (468468432,235541,10,'118.00'), (468468432,334218,20,'220.00'), (468468432,459043,30,'510.00'), (468468432,555567,120,'744.00'), (468468432,567844,15,'75.00'), (416813518,095623,8,'56.00'), (416813518,121045,5,'70.00'), (468135138,466245,15,'3000.00'), (498465815,324053,30,'186.00'), (498465815,497760,15,'146.55'), (498465815,095623,5,'35.00'), (616831681,343465,30,'195.00'), (616831681,121045,50,'700.00'), (616831681,555567,100,'620.00'), (616831681,459043,80,'1360.00'), (981651398,781130,5,'37.50'), (981651398,095623,5,'35.00'), (613518616,125647,1,'12.00'), (613518616,334218,1,'11.00'), (613518616,445701,1,'9.80'), (681981395,111112 ,3,'1800.00'), (618498420,445701,80,'784.00'), (618498420,987877,100,'29000.00'), (618498420,121045,40,'560.00'), (618498420,334218,35,'385.00'), (618498420,095623,60,'420.00'), (618498420,324053,30,'186.00'), (618498420,461026,10,'67.00'), (100649867,555567,2,'12.40'), (100649867,497760,5,'48.85'), (449891195,334218,10,'110.00'), (449891195,324053,85,'527.00'), (449891195,125647,70,'840.00'), (449891195,343465,1,'6.50'), (984521385,781130,100,'750.00'), (984521385,220115,10,'160000.00'), (984521385,987877,100,'29000.00'), (489152891,781130,150,'1125.00'), (489152891,111112,40,'24000.00'), (489152891,235541,80,'944.00'), (489152891,343465,75,'487.50'), (489152891,324053,60,'372.00'), (489152891,121045,20,'280.00'), (489152891,497760,90,'879.30'), (489152891,555567,55,'341.00'), (489152891,459043,150,'2550.00'), (489152891,987877,30,'8700.00'), (489152891,220115,8,'128000.00'), (489152891,232131,25,'12600.00'), (948561846,111112,5,'3000.00'), (948561846,125647,25,'300.00'), (948561846,235541,100,'1180.00'), (948561846,220115,3,'48000.00');

INSERT INTO OrdineConcluso (ID, Fattura, Spedizione, GiorniLavorativi, CostoFinale)
VALUES (0654,498146504,'Daily','1','134665.70'), (4982,843020184,'Standard','7-10','281.00'), (1908,687465120,'Express','3-5','115220.00'), (9872,436824165,'Daily','1','249.80'), (0158,462843652,'Standard','7-10','45174.60'), (6548,595629595,'Standard','7-10','1646.80'), (3210,468468432,'Express','3-5','3369.39'), (1894,416813518,'Standard','7-10','126.00'), (8231,468135138,'Express','3-5','2720.00'), (1978,498465815,'Daily','1','413.87'), (8887,616831681,'Daily','1','2637.50'), (1477,981651398,'Standard','7-10','72.50'), (9967,613518616,'Standard','7-10','32.80'), (1322,681981395,'Express','3-5','1658.00'), (0221,618498420,'Daily','1','28311.80'), (3315,100649867,'Standard','7-10','61.25'), (0256,449891195,'Standard','7-10','1379.66'), (1239,984521385,'Express','3-5','170795.00'), (1111,489152891,'Express','3-5','162300.92'), (1010,948561846,'Express','3-5','47252.00');


SET FOREIGN_KEY_CHECKS = 1;


/* Query, Procedure, Funzioni, Trigger	*/ 


/* Funzione 1, 2 e 3: Funzioni di utilità che mostrano: prezzo medio, massimo o minimo di una data categoria.  */

DELIMITER |

DROP FUNCTION IF EXISTS MPC |

CREATE FUNCTION MPC (Categoria VARCHAR(20)) RETURNS NUMERIC(8,2)
 	
 	BEGIN
 	 
		DECLARE val NUMERIC(8,2); 
		SELECT AVG(P.Prezzo) INTO val 
		FROM Prodotto P 
		WHERE P.Categoria = Categoria; 
	
		RETURN val; 
	
	END |
	
DELIMITER ; 

DELIMITER |

DROP FUNCTION IF EXISTS PMAXC |

CREATE FUNCTION PMAXC (Categoria VARCHAR(20)) RETURNS NUMERIC(8,2)
 	
 	BEGIN
 	 
		DECLARE val NUMERIC(8,2); 
		SELECT MAX(P.Prezzo) INTO val 
		FROM Prodotto P 
		WHERE P.Categoria = Categoria; 
	
		RETURN val; 
	
	END |
	
DELIMITER ; 

DELIMITER |

DROP FUNCTION IF EXISTS PMINC |

CREATE FUNCTION PMINC (Categoria VARCHAR(20)) RETURNS NUMERIC(8,2)
 	
 	BEGIN
 	 
		DECLARE val NUMERIC(8,2); 
		SELECT MIN(P.Prezzo) INTO val 
		FROM Prodotto P 
		WHERE P.Categoria = Categoria; 
	
		RETURN val; 
	
	END |
	
DELIMITER ; 


/* Query 1: Mostra le email dei clienti che hanno speso in totale un valore maggiore della media dei prezzi della categoria 'Birra' senza mostrare coloro che hanno speso meno del 5% del vino più costoso.	*/

SELECT C.Email, F.Totale
FROM Cliente C, Fattura F 
WHERE F.Intestatario = C.Username 
	  AND F.Totale>MPC('Birra') 
	  AND C.Username NOT IN (SELECT C.username 
							 FROM Cliente C, Fattura F 
							 WHERE F.Intestatario = C.Username 
								   AND F.Totale < (PMAXC('Vino')*0.05));


/* Query 2: Si mostri il nominativo dei clienti che hanno concluso ordini nell'ultimo anno, con almeno un prodotto il cui prezzo è minore di 1000€, ad eccezzione di vini. Si mostri anche il nome del prodotto. L'ordine deve avere inoltre la spedizione di tipo Express.	*/

DROP VIEW IF EXISTS OrdiniAnno;

CREATE VIEW OrdiniAnno AS

	SELECT F.ID
	FROM Fattura F, OrdineConcluso OC
	WHERE OC.Fattura = F.ID
		  AND F.Data >= (SELECT DATE_SUB(CURDATE(), INTERVAL 1 YEAR))
	 	  AND OC.Spedizione = 'Express';

SELECT P.Nome AS Prodotto, C.Nominativo AS Cliente
FROM DettaglioFattura DF, Cliente C, Prodotto P, Fattura F, OrdiniAnno OA
WHERE DF.Fattura = OA.ID
	  AND F.ID = OA.ID
	  AND F.Intestatario = C.Username
	  AND P.Codice = DF.Prodotto
	  AND DF.Costo <= '1000.00'
	  AND P.Categoria <> 'Vino'
ORDER BY Prodotto;


/* Funzione 4: Funzione che dato l'username di un utente restituisce il costo medio degli ordini di quel cliente.	*/

DELIMITER |

DROP FUNCTION IF EXISTS GiveAVG |

CREATE FUNCTION GiveAVG (usr VARCHAR(20)) RETURNS NUMERIC(8,2)

	BEGIN

		DECLARE Media NUMERIC(8,2);
		SELECT AVG(Totale) INTO Media
		FROM Fattura  
		WHERE Intestatario = usr;
		
		RETURN Media;
		
	END |

DELIMITER ;


/* Funzione 5: Funzione che calcola il numero di ordini effettuato da un cliente dato il suo username.	*/ 

DELIMITER |

DROP FUNCTION IF EXISTS NumOrdini |

CREATE FUNCTION NumOrdini (usr VARCHAR(20)) RETURNS TINYINT

	BEGIN

		DECLARE NumOrdini NUMERIC(8,2);
		SELECT COUNT(*) INTO NumOrdini
		FROM Fattura
		WHERE Intestatario = usr;
		
		RETURN NumOrdini;
		
	END |

DELIMITER ;


/* Funzione 6: FUnzione che, a seconda del parametro di ingresso, restituisce il nome del cliente con più ordini o il nome di quello con meno ordini. A parità di numero di ordini si sceglie il cliente con costo medio più alto o più basso a seconda che si sia scelto rispettivamente il cliente con più ordini o quello con meno.	*/

DROP VIEW IF EXISTS UtentiDistinti;

CREATE VIEW UtentiDistinti AS 
	
	SELECT Intestatario 
	FROM Fattura 
	GROUP BY Intestatario;

DROP VIEW IF EXISTS ResocontoOrdini;

CREATE VIEW ResocontoOrdini AS

	SELECT C.Nominativo AS Cliente, NumOrdini(UD.Intestatario) AS NumeroOrdini, GiveAVG(UD.Intestatario) AS MediaOrdini
	FROM Cliente C, UtentiDistinti UD
	WHERE C.Username = UD.Intestatario;

DELIMITER |

DROP FUNCTION IF EXISTS MaxMinOrdini |

CREATE FUNCTION MaxMinOrdini (MinMax ENUM('min', 'max')) RETURNS VARCHAR(20)

	BEGIN
	
		DECLARE nome VARCHAR(20);
		
		IF MinMax = 'max'
		THEN		
			SELECT Cliente INTO nome
			FROM ResocontoOrdini
			WHERE MediaOrdini = (SELECT MAX(RO.MediaOrdini) 
								 FROM ResocontoOrdini RO
								 WHERE NumeroOrdini = (SELECT MAX(RO.NumeroOrdini)
													   FROM ResocontoOrdini RO));
		ELSE
			SELECT Cliente INTO nome
			FROM ResocontoOrdini
			WHERE MediaOrdini = (SELECT MIN(RO.MediaOrdini) 
								 FROM ResocontoOrdini RO
								 WHERE NumeroOrdini = (SELECT MIN(RO.NumeroOrdini)
													   FROM ResocontoOrdini RO));
		END IF; 
								 
		RETURN nome;
		
	END |

DELIMITER ;


/* Query 3: Query che ritorna il numero medio di ordini effettuati per cliente, il nome del cliente che ha effettuato più ordini e il cliente che ha effettuato meno ordini. A parità di numero di ordini, selezionare il cliente che ha la spesa media più alta per il cliente che ha effettuato più ordini, la spesa minima per il ciente che ha effettuato meno ordini.	*/ 
	
SELECT AVG(RO.NumeroOrdini) AS NumeroMedioOrdini, MaxMinOrdini('max') AS ClienteMAX, MaxMinOrdini('min') AS ClienteMIN
FROM ResocontoOrdini RO;


/* Query 4: Mostra l'email dei clienti residenti a Padova che hanno effettuato almeno un ordine il cui costo sia maggiore o uguale del prezzo medio di ordini diversi dei clienti di Milano. */

SELECT C.Email 
FROM Cliente C, Fattura F 
WHERE C.Username = F.Intestatario 
	  AND C.Indirizzo LIKE '%, Padova' 
	  AND NumOrdini(Username) >= 1 
	  AND F.Totale >= (SELECT AVG(Totale) 
					   FROM Cliente C, Fattura F  
					   WHERE C.Username = F.Intestatario 
					   AND C.Indirizzo like '%, Milano')
GROUP BY C.Email;


/* Query 5: Mostra per ogni categoria di Prodotto il guadagno totale derivato dalle vendite effettuate di quella categoria e la percentuale rispetto al guadagno totale dell'azienda. Si ignorano gli sconti applicati a fine ordine. */

DELIMITER |
	
DROP PROCEDURE IF EXISTS PercentualeGuadagno |
	
CREATE PROCEDURE PercentualeGuadagno (tot NUMERIC(8,2))

	BEGIN 
		DECLARE Done INT DEFAULT 0;
		DECLARE cat VARCHAR(20);
		DECLARE guad NUMERIC(8,2);
		
		DECLARE cat_cursor CURSOR FOR 
						   SELECT P.Categoria 
						   FROM Prodotto P
						   GROUP BY P.Categoria;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET Done = 1;
	
		DROP TEMPORARY TABLE IF EXISTS Aux;
		CREATE TEMPORARY TABLE Aux (Categoria VARCHAR(20), GuadagnoCategoria NUMERIC(8,2), GuadagnoInPercentuale NUMERIC(8,2));	
	
		OPEN cat_cursor;
	
		REPEAT
			FETCH cat_cursor INTO cat;
			SELECT SUM(DF.Costo) AS GuadagnoCategoria INTO guad
			FROM DettaglioFattura DF, Prodotto P
			WHERE P.Categoria = cat
				  AND P.Codice = DF.Prodotto;
			
			IF NOT Done THEN
				IF (SELECT P.Categoria
					FROM DettaglioFattura DF, Prodotto P
					WHERE P.Categoria = cat
				 	  	  AND P.Codice = DF.Prodotto
				 	GROUP BY P.Categoria) IS NOT NULL 
				THEN
					INSERT INTO Aux (Categoria, GuadagnoCategoria, GuadagnoInPercentuale) SELECT P.Categoria, SUM(DF.Costo), (100 * guad / tot)
																						  FROM DettaglioFattura DF, Prodotto P
																						  WHERE P.Categoria = cat
				 	      					AND P.Codice = DF.Prodotto;
				END IF;
			END IF;
		UNTIL Done END REPEAT;
     	
     	CLOSE cat_cursor; 

		SELECT * FROM Aux;
		DROP TEMPORARY TABLE Aux;

	END |

DELIMITER ;

CALL PercentualeGuadagno((SELECT SUM(Costo) FROM DettaglioFattura));


/* Query 6: Mostra il nome del prodotto che è stato acquistato di più in un dato anno e il numero di clienti con e senza partita IVA che hanno acquistato quel prodotto.  */

DELIMITER |
	
DROP PROCEDURE IF EXISTS PiùVenduto |
	
CREATE PROCEDURE PiùVenduto (Anno YEAR)

	BEGIN 

		DECLARE prod INT; 
		DECLARE pIVA INT;
		DECLARE nonpIVA INT;
		
		DROP TABLE IF EXISTS VenditeProdotto;
		
		CREATE TABLE VenditeProdotto (
			Prodotto INT,
			NumeroOrdini INT, 
			QuantitàTotalE INT
		);
				 
		INSERT INTO VenditeProdotto (SELECT P.Codice, COUNT(DF.Quantità), SUM(DF.Quantità)
									 FROM DettaglioFattura DF JOIN Prodotto P ON (DF.Prodotto = P.Codice) JOIN Fattura F ON (F.ID = DF.Fattura) 
									 WHERE YEAR(F.Data) = Anno
									 GROUP BY DF.Prodotto);

		SELECT Prodotto INTO prod
		FROM VenditeProdotto 
		WHERE QuantitàTotale = (SELECT MAX(QuantitàTotale)
								FROM VenditeProdotto);
								
		SELECT COUNT(*) INTO pIVA
		FROM Fattura F, DettaglioFattura DF, Cliente C
		WHERE DF.Prodotto = prod
			  AND F.ID = DF.Fattura 
			  AND YEAR(F.Data) = Anno
			  AND C.Username = F.Intestatario
			  AND C.PartitaIva IS NOT NULL;
		
		SELECT COUNT(*) INTO nonpIVA
		FROM Fattura F, DettaglioFattura DF, Cliente C
		WHERE DF.Prodotto = prod
			  AND F.ID = DF.Fattura 
			  AND YEAR(F.Data) = Anno
			  AND C.Username = F.Intestatario
			  AND C.PartitaIva IS NULL;	  
			  
		
		SELECT P.Nome AS PiùVenduto, pIVA AS N_pIVA, nonpIVA AS N_non_pIVA
		FROM Prodotto P 
		WHERE P.Codice = prod;

		DROP TABLE VenditeProdotto;

	END |
	
DELIMITER ;

CALL PiùVenduto (2015);


/* Trigger 1: Dopo l'inserimento di una entry in Fattura si applica uno sconto al prezzo totale se il cliente ha speso oltre una certa soglia in denaro. Se ha speso meno di 200€ lo sconto non si applica. Lo sconto aumenta del 1% per ogni 200€ fino ad un massimo del 10%. */

DELIMITER |

DROP TRIGGER IF EXISTS Sconto |

CREATE TRIGGER Sconto 

BEFORE INSERT ON Fattura
FOR EACH ROW

	BEGIN
		
		DECLARE sc INT;
	
		SET sc = NEW.Totale DIV 200;
	
		IF sc > 10
			THEN SET sc = 10;
		END IF;
		
		IF NEW.Totale > 200
			THEN SET NEW.Totale = NEW.Totale - (NEW.Totale * sc / 100);
		END IF;

	END |

DELIMITER ;


/* Trigger 2: All'agiornamento della quantità di un prodotto nel carello, e quindi del prezzo, aggiorna il costo totale dei prodotti del carrello appropriato nella tabella OrdineInCorso. */

DELIMITER |

DROP TRIGGER IF EXISTS AggiungiAlCarrello |

CREATE TRIGGER AggiungiAlCarrello	

AFTER UPDATE ON Carrello
FOR EACH ROW 
		
	BEGIN	

		UPDATE OrdineInCorso OIC
		SET PrezzoProdotti = PrezzoProdotti + NEW.Costo - OLD.Costo 
		WHERE OIC.ID = NEW.OrdineInCorso;
	
	END |

DELIMITER ;


/* Trigger 3: Stesso concetto di prima, solo che aggiorna il costo di OrdineInCorso quando viene aggiunto un prodotto in un carrello. */

DELIMITER |

DROP TRIGGER IF EXISTS AggiungiAlCarrello |

CREATE TRIGGER AggiungiAlCarrello	

AFTER INSERT ON Carrello
FOR EACH ROW 
		
	BEGIN	

		UPDATE OrdineInCorso OIC
		SET PrezzoProdotti = PrezzoProdotti + NEW.Costo
		WHERE OIC.ID = NEW.OrdineInCorso;
	
	END |

DELIMITER ;


/* Trigger 4: Trigger che alla rimozione di un prodotto nel carrello, aggiorna il costo totale nella tabella OrdineInCorso e se l'ordine in corso conteneva solo quel prodotto, elimina l'entry. */

DELIMITER |

DROP TRIGGER IF EXISTS RimuoviDalCarrello |

CREATE TRIGGER RimuoviDalCarrello	

AFTER DELETE ON Carrello 
FOR EACH ROW 
		
	BEGIN	

		UPDATE OrdineInCorso OIC
		SET PrezzoProdotti = PrezzoProdotti - OLD.Costo 
		WHERE OIC.ID = OLD.OrdineInCorso;
		
		IF (SELECT PrezzoProdotti
			FROM OrdineInCorso
			WHERE ID = OLD.OrdineInCorso) = 0
			
		THEN 
			
			DELETE FROM OrdineInCorso
			WHERE ID = OLD.OrdineInCorso;
			
		END IF;
	
	END |

DELIMITER ;


/* Trigger 5: Dopo l'inserimento nella tabella OrdineConcluso, aggiorna il costo totale aggiungendo al costo della fattura il costo della spedizione selezionata. */

DELIMITER |

DROP TRIGGER IF EXISTS AggiungiSpedizione |

CREATE TRIGGER AggiungiSpedizione	

BEFORE INSERT ON OrdineConcluso
FOR EACH ROW 
		
	BEGIN	

		IF (NEW.Spedizione = 'Express')	
		THEN 
			SET NEW.CostoFinale = NEW.CostoFinale + 20;
		ELSEIF (NEW.Spedizione = 'Daily')
		THEN 
			SET NEW.CostoFinale = NEW.CostoFinale + 50;
		
		END IF;
	
	END |

DELIMITER ;
