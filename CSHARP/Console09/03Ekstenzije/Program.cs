

using _03Ekstenzije;

Console.Write("Upisi ime: ");
string ime = Console.ReadLine() ?? "";

Console.WriteLine(ime?.brojPonavljanja('a'));

var s = new Smjer();

s.OdradiPosao();

Grupa g = new();
g.OdradiPosao();
