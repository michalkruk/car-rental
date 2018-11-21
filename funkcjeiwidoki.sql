CREATE VIEW WzorowiKlienci(nazwisko, ilosc_wypozyczen, nr_telefonu)
AS
(
    SELECT  nazwisko, 
            ilosc_wypozyczen, 
            nr_telefonu
    FROM    Klienci
    WHERE   ilosc_wypozyczen > 5
);
GO

CREATE FUNCTION ZarobkiRocznazPremiaa
(
    @pensja INTEGER,
	@premia INTEGER
)
    RETURNS INTEGER
AS
BEGIN
    RETURN (@pensja * 12)+@premia;
END;

CREATE FUNCTION NrRejeWedlugNadwozia
(
    @a VARCHAR(20)
)
    RETURNS TABLE
AS
    RETURN SELECT nr_rejestracyjny
           FROM   Samochody
           WHERE  rodzaj_nadwozia = @a;