

using E02Ucahurivanje;

Osoba osoba = new Osoba();
osoba.setIme("Pero");
osoba.Prezime = "Perić"; // ovako ćemo u nastavku koristiti

Console.WriteLine("{0} {1}",osoba.Prezime, osoba.getIme());


Smjer smjer = new Smjer();
smjer.Sifra = 1;
smjer.Naziv = "Web programiranje";
smjer.Trajanje = 250;
// .. ostala svojstva

// brža sintaksa
smjer = new Smjer
{
    Sifra = 1,
    Naziv = "Java programiranje"
    // .. ostale vrijednosti
};

Zupanija zupanija = new Zupanija
{
    Naziv = "Osječko baranjska",
    Zupan = "Anušić"
};

Grad grad = new Grad
{
    Naziv = "Osijek",
    zupanija = zupanija
};

// ispis svojstava kada jedna klasa sadrži nastnacu druge klase
Console.WriteLine("Grad je {0}, županija je {1}", grad.Naziv, grad.zupanija.Naziv );


