#include <stdio.h>
// do not use the built-in printf optimizations
#undef printf
#undef putchar 

struct __using("hn008.spin2") v; // video driver

int main()
{
    stdout->putcf = v.putchar;
    int cog=v.start(256);

    printf("hello\n");
    printf("HELLO\n");
    return 0;
}
