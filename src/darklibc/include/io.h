#ifndef __IO__
#define __IO__

extern volatile int utimers; // microsecond timer

struct DARKIO {

    unsigned char board_id; // 00
    unsigned char board_cm; // 01
    unsigned char core_id;  // 02
    unsigned char irq;      // 03

    struct DARKUART {
        
        unsigned char  stat; // 04
        unsigned char  fifo; // 05
        unsigned short baud; // 06/07

    } uart;

    unsigned short led;     // 08/09
    unsigned short gpio;    // 0a/0b

    unsigned int timer;     // 0c
    unsigned int timeus;    // 10
};

extern volatile struct DARKIO *io;

extern char *board_name(int);

#ifdef __RISCV__
#define kmem 0
#else
extern unsigned char kmem[8192];
#endif

#define IRQ_TIMR 0x80
#define IRQ_UART 0x02

int  check4rv32i(void);
void set_mtvec(void (*f)(void));
void set_mepc(void (*f)(void));
void set_mie(int);
int  get_mtvec(void);
int  get_mepc(void);
int  get_mie(void);
void banner(void);

__attribute__ ((interrupt ("machine"))) void irq_handler(void);

extern unsigned _text;
extern unsigned _data;
extern unsigned _etext; 
extern unsigned _edata; 
extern unsigned _stack;

#endif
