

int t1 = 2;
int t2 = 3;
int t3 = 12;
int t4 = 14;

// deklaracija niza
int[] niz;

// konstruiranje niza
niz = new int[3];

// dodjeljivanje vrijednosti
niz[0] = 2; 
niz[1]=1;
niz[2]=3;

Console.WriteLine(niz[2]);
Console.WriteLine(niz[^1]);
Console.WriteLine(niz[niz.Length-1]);


// jednodimenzionalni niz
int[] podaci = { 2, 3, 23, 2, 2, 2, 3, 3, 22 };


// dvodimenzionalni niz
int[,] tablica= new int[3,3]; // 9 podataka

// trodimenzinalni niz

int[,,] kocka = new int[3, 3,3]; // 27 podataka

// višedimenzionalni nizovi do 32 dimenzije


