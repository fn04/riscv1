#ifndef __STDIO__
#define __STDIO__

#define EOF   -1
#define NUL   0
#define NULL  (void *)0

int getchar(void);
int putchar(int c);
char *gets(char *p,int s);
void putstr(char *p);
int puts(char *p);
int printf(char *fmt,...);
int strcmp(char *s1, char *s2);
int strncmp(char *s1, char *s2, int len);
int strlen(char *s1);
void putx(unsigned);
void putd(int);
char *memcpy(char *dptr,char *sptr,int len);
char *memset(char *dptr, int c, int len);
char *strtok(char *str,char *dptr);
int atoi(char *);
int xtoi(char *);
int mac(int,short,short);
void usleep(int);

#define EBREAK asm("ebreak")

#endif
