#include <stdio.h>
// do not use the built-in printf optimizations
#undef printf

// low level functions built in to the kernel
extern int _tx(int c);
extern int _rx(void);

// our replacement transmit function
int my_tx(int c)
{
    if (c >= 'a' && c <= 'z')
        _tx(c + 1);
    else
        _tx(c);
    return 1;
}

int main()
{
    // replace stdout put function
    stdout->putcf = my_tx;
    // now use it
    printf("hello\n");
    printf("HELLO\n");
    return 0;
}
