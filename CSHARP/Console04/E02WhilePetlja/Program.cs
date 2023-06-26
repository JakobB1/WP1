

//while radi s bool tipom podatka

// beskonačna petlja
while(true)
{
    break;
}

// u for se ne mora ući
for(int i = 0; i < 0; i++)
{
    Console.WriteLine("01 Nisam ušao");
}

// u while se ne mora ući

while(false)
{
    Console.WriteLine("02 Nisam ušao");
}


int b = 0;

while(b<10)
{
    Console.WriteLine(++b);
    
}

int t = 2;
b = 0;
while(t==2 && b < 10)
{
    Console.WriteLine(++b);
}
Console.WriteLine("*************");
b =0;
while (true)
{
    if (b == 2)
    {
        b++;
        continue;
    }
    if (b ==5) {
        break;
    }
    Console.WriteLine(b++);
}


// Program unsi broj između 1 i 10
// Program ispisuje uneseni broj
//while (true)
//{
//    Console.Write("Unesi cijeli broj: ");
//    b = int.Parse(Console.ReadLine());
//    if(b>0 && b <= 10)
//    {
//        break;
//    }
//    Console.WriteLine("Morate unijeti broj između 1 i 10");
//}
//Console.WriteLine("Uneseni broj je: {0}",b);


// Napišite program koji pomoću while petlje ispisuje 
// Svaki 3. broj između 2 i 97

// 1. rješenje
b = 2;
while (b <= 97)
{
    Console.WriteLine(b);
    b += 3;
}

// 2. rješenje

b = 2;
while(true)
{
    Console.WriteLine(b);
    b += 3;
    if (b > 97)
    {
        break;
    }
}

// 3. zadatak 
// zbrojite prvih 100 brojeva s while petljom

int zbroj = 0;
b = 0;
while (b++ < 100)
{
    zbroj += b;
}
Console.WriteLine(zbroj);

// drugi način
zbroj = 0; b = 1;
while (b <= 100)
{
    zbroj += b;
    b++;
}
Console.WriteLine(zbroj);

// ugnježđivanje i prekidanje unutarnjih petlji jednako kao u for




