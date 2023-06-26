

int[] niz = { 2, 3, 3, 4, 5, 5 };

for(int i = 0; i < niz.Length; i++)
{
    Console.WriteLine(niz[i]);
}
Console.WriteLine("*******************");
// unazad
for (int i=niz.Length-1; i>=0; i--)
{
    Console.WriteLine(niz[i]);
}
Console.WriteLine("*******************");
// ako želimo ići od prvog do zanjeg

foreach (int en in niz)
{
    Console.WriteLine(en);
}

// ugnježđivanje, nastavak i prekidanje jednako kao na for, while i do
