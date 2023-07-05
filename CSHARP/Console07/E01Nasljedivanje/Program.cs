

using E01Nasljedivanje;

var o = new Osoba
{
    Sifra = 1,
    Ime = "Pero",
    Prezime = "Perić"
};

Console.WriteLine(o);

var drugaOsoba = new Osoba
{
    Sifra = 1,
    Ime = "Marina",
    Prezime = "Marić"
};

Console.WriteLine(o.Equals(drugaOsoba));

var p = new Polaznik
{
    Sifra = 1,
    Ime = "Marko",
    Prezime = "Kat",
    BrojUgovora="2023/56"
};

Console.WriteLine(p);

var pr = new Predavac
{
    Sifra = 1,
    Ime = "Rita",
    Prezime = "Man",
    Iban = "HR458585255555"
};

Console.WriteLine(pr);


