
// 10 puta ispiši Osijek
// najgore rješenje
//Console.WriteLine("Osijek");
//Console.WriteLine("Osijek");
//Console.WriteLine("Osijek");
//Console.WriteLine("Osijek");
//Console.WriteLine("Osijek");
//Console.WriteLine("Osijek");
//Console.WriteLine("Osijek");
//Console.WriteLine("Osijek");
//Console.WriteLine("Osijek");
//Console.WriteLine("Osijek");


// for(od kuda;do kuda;korak)

Console.WriteLine("1. *****************");
for (int i = 0; i < 10; i = i + 1)
{
    Console.WriteLine("Osijek");
}

Console.WriteLine("2. *****************");
int j=0;
for (j = 10; j > 0; j--)
{
    Console.WriteLine("Edunova");
}

// Domaća zadaća: vježbati s break point i debug


Console.WriteLine("3. *****************");
for (int i = 0;i < 10; i=i+2)
{
    Console.WriteLine("CSHARP");
}

// varijabla u petlji mijenja vrijednost!!!!
Console.WriteLine("4. *****************");
for (int i = 0; i<10; i++)
{
    Console.WriteLine(i);
}

Console.WriteLine("5. *****************");
for (int i = 0; i < 10; i++)
{
    Console.WriteLine(i+1); // i+1 ne mijenja vrijednost varijable i
}

Console.WriteLine("6. *****************");
// ne koristiti
for (int i = 1; i <= 10; i++)
{
    Console.WriteLine(i); 
}

Console.WriteLine("7. *****************");
// zbroj prvih 100 brojeva
int zbroj = 0;
for(int i = 1; i <= 100; i++)
{
   // Console.WriteLine(i);
    zbroj += i; // zbroj=zbroj+i
    //Console.WriteLine(zbroj);
}
Console.WriteLine(zbroj);



Console.WriteLine("8. *****************");
// ispisati sve parne brojeve od 1 do 57
for(int i = 1; i <= 57; i++)
{
    if(i%2== 0)
    {
        Console.WriteLine(i);
    }
}

Console.WriteLine("9. *****************");
// ispiši zbroj svih parnih brojeva od 2 do 18
zbroj = 0;
for(int i = 2; i <= 18; i++)
{
    if(i%2==0)
    {
        zbroj += i;
    }
}
Console.WriteLine(zbroj);

int[] niz = { 2, 2, 34, 54, 5, 6, 76, 7,8,7,8 };


Console.WriteLine("10. *****************");
// jedno ispod drugog ispisati svaki element niza
for(int i = 0; i < niz.Length; i++)
{
    Console.WriteLine(niz[i]);
}

// Program učitava koliko će se brojeva unijeti
// Program učitava brojeve za provjeru
// Program ispisuje najveći uneseni broj

//Console.WriteLine("11. *****************");
//Console.Write("Unesi koliko brojeva provjeravaš: ");
//int brojeva = int.Parse(Console.ReadLine());
//int broj; //unutar petlje nikada ne deklarirati varijablu, uvije izvan petlje
//int najveci = int.MinValue;
//for(int i = 0; i < brojeva; i++)
//{
//    Console.Write("Unesi {0}. broj: ",i+1);
//    broj = int.Parse(Console.ReadLine());
//    if (broj > najveci)
//    {
//        najveci = broj;
//    }
//}
//Console.WriteLine("Najveći broj je {0}",najveci);

//beskonačna petlja

//Ovo nije beskonačna petlja
//for (int i=1; i > 0; i++)
//{

//}

Console.WriteLine("12. *****************");
// OVO JE BESKONAČNA FOR PETLJA
// nasilno prekidanje petlje: break
for (; ; )
{
    Console.WriteLine(new Random().NextDouble()); //loša sintaksa
    break;
}

Console.WriteLine("12. *****************");
for (int i = 0; i < 10; i++)
{
    if (i == 3)
    {
        break;
    }
    Console.WriteLine(i);
}


// petlja se može nastaviti/preskočiti
Console.WriteLine("13. *****************");
for (int i = 0; i < 10; i++)
{
    if(i==2 || i == 5)
    {
        continue;
    }
    Console.WriteLine(i);
}


Console.WriteLine("14. *****************");
//ugnježđivanje petlji
string s;
for(int i=1; i <=10; i++)
{
    for(int k = 1; k <=10; k++)
    {
        s = "    " + i * k;
        Console.Write(s[^4..]);
    }
    Console.WriteLine();
}


// DZ
//		Kreiraj program koji će koristeći for petlje
//		automatizirati ispis tablice množenja u ovom obliku:
//		-------------------------------
//		: : :  TABLICA  MNOZENJA  : : :
//		-------------------------------
//		 * |  1  2  3  4  5  6  7  8  9
//		-------------------------------
//		 1 |  1  2  3  4  5  6  7  8  9
//		 2 |  2  4  6  8 10 12 14 16 18
//		 3 |  3  6  9 12 15 18 21 24 27
//		 4 |  4  8 12 16 20 24 28 32 36
//		 5 |  5 10 15 20 25 30 35 40 45
//		 6 |  6 12 18 24 30 36 42 48 54
//		 7 |  7 14 21 28 35 42 49 56 63
//		 8 |  8 16 24 32 40 48 56 64 72
//		 9 |  9 18 27 36 45 54 63 72 81
//		-------------------------------
//		:  :  :  :  :  :   :by Tomislav
//		-------------------------------
//		Umjesto "Ime" treba ispisati ime uneseno s
//		konzole i pri tome pripaziti da zadnje slovo
//		imena bude poravnato s desnim rubom tablice.


// nasilno prekidanje unutarnjih petlji
Console.WriteLine("15. *****************");
for (int i = 0;i<10; i++)
{
    for(int k=0;k<10; k++)
    {
       // break; //ovo prekida samo unutrarnju petlju, ne i vanjsku
        // želim prekinuti i vanjsku petlju
        goto labela;
    }
}

labela:;



// 9 različitih načina zbaranja prvih 100 brojeva

//int i, s=0; for(i=1;i<=100;i++) s+=i;

// int i, s; for(i=1, s=0;i<=100; s+=i, i++);
//
// int i=1, s=0; for( ; i<=100; i++){ s+=i; }
//
//		 int i, s=0; for(i=1; ; i++){ if(i<=100) s+=i; else break;}
//
//		 int i, s=0; for(i=1;i<=100;){ s+=i; i++;}
//
//		 int i, s=0; for(i=1; ; ){ if(i<=100) {s+=i; i++;} else break;}
//
//		 int i=1, s=0; for( ; i<=100 ; ){ s+=i; i++;}
//
//		  int i=1, s=0; for( ; ; i++){if(i<=100)  s+=i; else break;}
//
//		 int i=1, s=0; for( ;  ; ){if(i<=100) {s+=i; i++;} else break;} 
//		


// 1. zadatak
// Korisnik unosi dva cijela broja
// Program ispisuje 
// zbroj svih parnih brojeva
// između dva unesena broja



// U for petlju se ne mora ući

int t = 100;

for(int i = 0; i > t; i++)
{
    Console.WriteLine("Ušao u petlju");
}



// 2. zadatak
// Program ispisuje brojeve od 100 do 1
// u istom redu odvojeno zarezom

