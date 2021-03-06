-- Generated by Oracle SQL Developer Data Modeler 17.3.0.261.1541
--   at:        2018-01-16 20:07:38 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g

IF OBJECT_ID('Wypozyczenia','U') IS NOT NULL
	DROP TABLE Wypozyczenia

IF OBJECT_ID('Uszkodzenia', 'U') IS NOT NULL 
	DROP TABLE Uszkodzenia;

IF OBJECT_ID('Samochody', 'U') IS NOT NULL 
	DROP TABLE Samochody;

IF OBJECT_ID('Rezerwacje', 'U') IS NOT NULL 
	DROP TABLE Rezerwacje;

IF OBJECT_ID('Klienci', 'U') IS NOT NULL 
	DROP TABLE Klienci;

IF OBJECT_ID('Modele', 'U') IS NOT NULL 
	DROP TABLE Modele;

IF OBJECT_ID('Pracownicy', 'U') IS NOT NULL 
	DROP TABLE Pracownicy;

IF OBJECT_ID('Rabaty', 'U') IS NOT NULL 
	DROP TABLE Rabaty;

IF OBJECT_ID('Salony', 'U') IS NOT NULL 
	DROP TABLE Salony;

IF OBJECT_ID('Ubezpieczenia', 'U') IS NOT NULL 
	DROP TABLE Ubezpieczenia;

IF OBJECT_ID('Wypozyczenia', 'U') IS NOT NULL 
	DROP TABLE Wypozyczenia;

CREATE TABLE Klienci (
    id_klienta         INTEGER NOT NULL PRIMARY KEY,
    imie               VARCHAR(20) NOT NULL,
    nazwisko           VARCHAR(20) NOT NULL,
    nr_telefonu        INTEGER NOT NULL,
    ilosc_wypozyczen   INTEGER NOT NULL
);

CREATE TABLE Modele (
	id_model		INTEGER NOT NULL PRIMARY KEY,
    marka           VARCHAR(20) NOT NULL,
    model           VARCHAR(20) NOT NULL,
    rok_produkcji   INTEGER
);

CREATE TABLE Pracownicy (
    id_pracownika   INTEGER NOT NULL PRIMARY KEY,
    imie            VARCHAR(20) NOT NULL,
    nazwisko        VARCHAR(20) NOT NULL,
    nr_telefonu     VARCHAR(20) NOT NULL,
    pensja          VARCHAR(20) NOT NULL,
    premia          VARCHAR(20) NOT NULL
);

CREATE TABLE Rabaty (
    id_rabat           INTEGER NOT NULL PRIMARY KEY,
    ilosc_wypozyczen   INTEGER NOT NULL
);

CREATE TABLE Rezerwacje (
    id_rezerwacji       INTEGER NOT NULL PRIMARY KEY,
    data_rezerwacji     DATE NOT NULL,
    liczba_dni          INTEGER NOT NULL,
    klient			    INTEGER REFERENCES Klienci(id_klienta)
);

CREATE TABLE Salony (
    id_salonu     INTEGER NOT NULL PRIMARY KEY,
    miejscowosc   VARCHAR(30) NOT NULL,
    adres         VARCHAR(30) NOT NULL
);

CREATE TABLE Ubezpieczenia (
    id_ubezpieczenia   INTEGER NOT NULL PRIMARY KEY,
    nazwa              VARCHAR(30) NOT NULL,
    opis               VARCHAR(200) NOT NULL,
    cena               VARCHAR(20) NOT NULL
);

CREATE TABLE Samochody (
    id_auta                          INTEGER NOT NULL PRIMARY KEY,
    nr_rejestracyjny                 VARCHAR(10) NOT NULL,
    uszkodzony                       VARCHAR(3) NOT NULL,
    dostepnosc                       VARCHAR(3) NOT NULL,
    przebieg                         INTEGER NOT NULL,
    vin                              VARCHAR(17) NOT NULL,
    rodzaj_nadwozia                  VARCHAR(30) NOT NULL,
    system_napedowy                  VARCHAR(30) NOT NULL,
    pojemnosc_silnika                VARCHAR(10) NOT NULL,
    moc_silnika                      INTEGER NOT NULL,
    salon							 INTEGER REFERENCES Salony(id_salonu),
    marka						     INTEGER REFERENCES Modele(id_model),
    ubezpieczenie				     INTEGER REFERENCES Ubezpieczenia(id_ubezpieczenia),
    rezerwacja						 INTEGER REFERENCES Rezerwacje(id_rezerwacji)
);

CREATE TABLE Uszkodzenia (
    id_uszkodzenia     INTEGER NOT NULL PRIMARY KEY,
    koszt_naprawy      INTEGER NOT NULL,
    szczegoly          VARCHAR(300) NOT NULL,
    data_zdarzenia     DATE NOT NULL,
    samochod		   INTEGER REFERENCES Samochody(id_auta)
);

CREATE TABLE Wypozyczenia (
	id                         INTEGER NOT NULL PRIMARY KEY,
    poczatkowy_stan_licznika   INTEGER NOT NULL,
    koncowy_stan_licznika      INTEGER NOT NULL,
    data_wypozyczenia          DATE NOT NULL,
    data_zwrotu                DATE NOT NULL,
    termin_zwrotu              DATE NOT NULL,
    kaucja                     INTEGER NOT NULL,
    komentarz                  VARCHAR(300),
    cena                       INTEGER NOT NULL,
    samochod			       INTEGER REFERENCES Samochody(id_auta),
    pracownik				   INTEGER REFERENCES Pracownicy(id_pracownika),
    rabat		               INTEGER REFERENCES Rabaty(id_rabat),
    klient					   INTEGER REFERENCES Klienci(id_klienta)
);

-----INSER-----

INSERT INTO Klienci VALUES
(1,'Damian','Kaminski',603283183,2),
(2,'Adrian','Zawadzki',652832657,6),
(3,'Olga','Kulesza',723841749,4),
(4,'Daria','Zadranowicz',502482374,9),
(5,'Patryk','Suchocki',518304229,2);

INSERT INTO Modele VALUES
(1,'Audi','A4',2011),
(2,'Ford','Mondeo',2011),
(3,'Renault','Scenic',2008),
(4,'Fiat','Multipla',2006),
(5,'Audi','A6',2015);

INSERT INTO Pracownicy VALUES 
(1,'Marek','Judym',611384992,2310,100),
(2,'Krzysztof','Kapusta',542773821,2540,200);

INSERT INTO Rabaty VALUES
(1,0),
(2,5),
(3,10);

INSERT INTO Rezerwacje VALUES
(1,'2018-02-05',4,4),
(2,'2018-02-07',2,5),
(3,'2018-02-22',5,1);

INSERT INTO Salony VALUES
(1,'Poznan','Wichrowe Wzgorze 20'),
(2,'Poznan','Marcelinska 4');

INSERT INTO Ubezpieczenia VALUES
(1,'Podstawowe','Ubezpieczenie do tanszych aut',50),
(2,'Premium','Ubezpieczenie do drozszych aut',110);

INSERT INTO Samochody VALUES
(1,'PO 98D3E','NIE','TAK','110345','WAUZZZ8P17A049423','Sedan','Diesel','2.5',210,1,1,2,1),
(2,'PO A43F7','NIE','TAK','30345','WRECDZ5G17V549423','MiniVan','Diesel','1.8',140,1,3,1,2),
(3,'PP C2SA2','NIE','TAK','230421','WFRDCA8B57N040213','Sedan','Diesel','1.9',135,2,2,2,3),
(4,'PO 98D3E','TAK','TAK','110345','WFIZFC8L23D293298','MiniVan','Benzyna','1.4',113,2,4,1,NULL);

INSERT INTO Uszkodzenia VALUES
(1,1320,'Spalona skrzynia biegow(cala do wymiany).','2018-01-30',4);

INSERT INTO Wypozyczenia VALUES
(1,'29945','30345','2018-01-05','2018-01-07','2018-01-07',1000,'bez zazstrzezen',400,2,1,1,1),
(2,'109600','109985','2018-01-08','2018-01-12','2018-01-12',1500,'bez zazstrzezen',1000,1,1,2,4),
(3,'109985','110345','2018-01-14','2018-01-17','2018-01-17',1300,'bez zazstrzezen',800,1,2,1,3);



SELECT *
FROM   WzorowiKlienci;

SELECT dbo.ZarobkiRocznazPremiaa(1200,200);

SELECT * FROM NrRejeWedlugNadwozia('MiniVan');