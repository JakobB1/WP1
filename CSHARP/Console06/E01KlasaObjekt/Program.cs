

using E01KlasaObjekt;

string ime = "Pero";
string prezime = "Perić";
int godine = 24;

ime = "marija";

string ime1 = "marija";

// Ovo morate znati nakon svatova u 4 ujutro
// Objekt je instanca/pojavnost klase
// Osoba je naziv klase (tip podatka)
// o je instanca klase, o je objet, o je varijabla
// new je ključna riječ koja poziva posebnu metodu: konstruktor
Osoba o=new Osoba();

o = new Osoba("Pero");

// eksplicitni način deklariranja varijabli
Osoba natjecatelj = new Osoba();


// implicitni način deklariranja varijabli

var prijavitelj = new Osoba("Marija"); //desna strana određuje tip podatka varijable
var i = 1;

// drugi dio Z01
Dokument[] dokumenti = new Dokument[3];
dokumenti[0] = new Dokument();
dokumenti[1] = new Dokument();
dokumenti[2] = new Dokument("Račun");



Smjer smjer = new Smjer("mora biti string",3);


Grupa grupa;
for(int j = 0; j < 128; j++)
{
    grupa = new Grupa();
}






