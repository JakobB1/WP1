

using E02ApstraknaKlasaIMetoda;

//var o = new Osoba(); apstraktnu klasu ne možemo instancirati


var p = new Polaznik
{
    Ime = "Pero",
    Spol="Muško"
};

var pr = new Predavac
{
    Ime="Mario",
    Godine=24
};

void ispis(Osoba o)
{
    o.Pozdravi();
}

ispis(p);
ispis(pr);