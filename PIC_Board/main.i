#line 1 "main.c"
#line 1 "main.c"

#line 1 "./ecan.h"

#line 38 "./ecan.h"
 


#line 42 "./ecan.h"

 
#line 45 "./ecan.h"
#line 46 "./ecan.h"
#line 47 "./ecan.h"
#line 48 "./ecan.h"

 
 
#line 52 "./ecan.h"

 
#line 55 "./ecan.h"
#line 56 "./ecan.h"
#line 57 "./ecan.h"
#line 58 "./ecan.h"
#line 59 "./ecan.h"
#line 60 "./ecan.h"

 

#line 66 "./ecan.h"
 
#line 68 "./ecan.h"
 
#line 70 "./ecan.h"

#line 71 "./ecan.h"
 
#line 73 "./ecan.h"

#line 74 "./ecan.h"
 
#line 76 "./ecan.h"

#line 80 "./ecan.h"
 
#line 82 "./ecan.h"
#line 83 "./ecan.h"

 
typedef unsigned int ECAN1MSGBUF [4 ][8];
extern ECAN1MSGBUF  ecan1msgBuf __attribute__((space(dma)));

 
typedef struct{
	 
	unsigned char buffer_status;
	 
	unsigned char message_type;
	 
	unsigned char frame_type;
	 
	unsigned char buffer;
	
#line 99 "./ecan.h"
 
	unsigned long id; 
	unsigned char data[8];	
	unsigned char data_length;
}mID;

 
void initECAN (void);
void sendECAN(mID *message);
void initDMAECAN(void);
void rxECAN(mID *message);
void clearRxFlags(unsigned char buffer_number);
	
#line 113 "./ecan.h"
#line 2 "main.c"

#line 1 "c:/mcc18/h/stdio.h"

#line 3 "c:/mcc18/h/stdio.h"

#line 1 "c:/mcc18/h/stdarg.h"
 


#line 5 "c:/mcc18/h/stdarg.h"

typedef void* va_list;
#line 8 "c:/mcc18/h/stdarg.h"
#line 9 "c:/mcc18/h/stdarg.h"
#line 10 "c:/mcc18/h/stdarg.h"
#line 11 "c:/mcc18/h/stdarg.h"
#line 12 "c:/mcc18/h/stdarg.h"
#line 4 "c:/mcc18/h/stdio.h"

#line 1 "c:/mcc18/h/stddef.h"
 

#line 4 "c:/mcc18/h/stddef.h"

typedef unsigned char wchar_t;


#line 10 "c:/mcc18/h/stddef.h"
 
typedef signed short int ptrdiff_t;
typedef signed short int ptrdiffram_t;
typedef signed short long int ptrdiffrom_t;


#line 20 "c:/mcc18/h/stddef.h"
 
typedef unsigned short int size_t;
typedef unsigned short int sizeram_t;
typedef unsigned short long int sizerom_t;


#line 34 "c:/mcc18/h/stddef.h"
 
#line 36 "c:/mcc18/h/stddef.h"


#line 41 "c:/mcc18/h/stddef.h"
 
#line 43 "c:/mcc18/h/stddef.h"

#line 45 "c:/mcc18/h/stddef.h"
#line 5 "c:/mcc18/h/stdio.h"



#line 9 "c:/mcc18/h/stdio.h"
 
#line 11 "c:/mcc18/h/stdio.h"

#line 13 "c:/mcc18/h/stdio.h"


typedef unsigned char FILE;

 
#line 19 "c:/mcc18/h/stdio.h"
#line 20 "c:/mcc18/h/stdio.h"

extern FILE *stderr;
extern FILE *stdout;


int putc (auto char c, auto FILE *f);
int vsprintf (auto char *buf, auto const far  rom char *fmt, auto va_list ap);
int vprintf (auto const far  rom char *fmt, auto va_list ap);
int sprintf (auto char *buf, auto const far  rom char *fmt, ...);
int printf (auto const far  rom char *fmt, ...);
int fprintf (auto FILE *f, auto const far  rom char *fmt, ...);
int vfprintf (auto FILE *f, auto const far  rom char *fmt, auto va_list ap);
int puts (auto const far  rom char *s);
int fputs (auto const far  rom char *s, auto FILE *f);

#line 36 "c:/mcc18/h/stdio.h"
#line 3 "main.c"

#line 1 "c:/mcc18/h/stdlib.h"
 

#line 4 "c:/mcc18/h/stdlib.h"

#line 6 "c:/mcc18/h/stdlib.h"

#line 9 "c:/mcc18/h/stdlib.h"
 
 

#line 16 "c:/mcc18/h/stdlib.h"
 
double atof (const auto char *s);

#line 28 "c:/mcc18/h/stdlib.h"
 
signed char atob (const auto char *s);


#line 39 "c:/mcc18/h/stdlib.h"
 
int atoi (const auto char *s);

#line 47 "c:/mcc18/h/stdlib.h"
 
long atol (const auto char *s);

#line 58 "c:/mcc18/h/stdlib.h"
 
unsigned long atoul (const auto char *s);


#line 71 "c:/mcc18/h/stdlib.h"
 
char *btoa (auto signed char value, auto char *s);

#line 83 "c:/mcc18/h/stdlib.h"
 
char *itoa (auto int value, auto char *s);

#line 95 "c:/mcc18/h/stdlib.h"
 
char *ltoa (auto long value, auto char *s);

#line 107 "c:/mcc18/h/stdlib.h"
 
char *ultoa (auto unsigned long value, auto char *s);
 


#line 112 "c:/mcc18/h/stdlib.h"
 
 

#line 116 "c:/mcc18/h/stdlib.h"
 
#line 118 "c:/mcc18/h/stdlib.h"


#line 124 "c:/mcc18/h/stdlib.h"
 
int rand (void);

#line 136 "c:/mcc18/h/stdlib.h"
 
void srand (auto unsigned int seed);
 
#line 140 "c:/mcc18/h/stdlib.h"
#line 149 "c:/mcc18/h/stdlib.h"

#line 151 "c:/mcc18/h/stdlib.h"
#line 4 "main.c"

#line 1 "c:/mcc18/h/string.h"

#line 3 "c:/mcc18/h/string.h"

#line 7 "c:/mcc18/h/string.h"


#line 20 "c:/mcc18/h/string.h"
 
#line 22 "c:/mcc18/h/string.h"


#line 25 "c:/mcc18/h/string.h"
 
#line 27 "c:/mcc18/h/string.h"

 

#line 39 "c:/mcc18/h/string.h"
 
void *memcpy (auto void *s1, auto const void *s2, auto size_t n);


#line 55 "c:/mcc18/h/string.h"
 
void *memmove (auto void *s1, auto const void *s2, auto size_t n);


#line 67 "c:/mcc18/h/string.h"
 
char *strcpy (auto char *s1, auto const char *s2);


#line 83 "c:/mcc18/h/string.h"
 
char *strncpy (auto char *s1, auto const char *s2, auto size_t n);


#line 97 "c:/mcc18/h/string.h"
 
char *strcat (auto char *s1, auto const char *s2);


#line 113 "c:/mcc18/h/string.h"
 
char *strncat (auto char *s1, auto const char *s2, auto size_t n);


#line 128 "c:/mcc18/h/string.h"
 
signed char memcmp (auto const void *s1, auto const void *s2, auto size_t n);


#line 141 "c:/mcc18/h/string.h"
 
signed char strcmp (auto const char *s1, auto const char *s2);


#line 147 "c:/mcc18/h/string.h"
 


#line 161 "c:/mcc18/h/string.h"
 
signed char strncmp (auto const char *s1, auto const char *s2, auto size_t n);


#line 167 "c:/mcc18/h/string.h"
 


#line 183 "c:/mcc18/h/string.h"
 
void *memchr (auto const void *s, auto unsigned char c, auto size_t n);


#line 199 "c:/mcc18/h/string.h"
 
char *strchr (auto const char *s, auto unsigned char c);


#line 210 "c:/mcc18/h/string.h"
 
size_t strcspn (auto const char *s1, auto const char *s2);


#line 222 "c:/mcc18/h/string.h"
 
char *strpbrk (auto const char *s1, auto const char *s2);


#line 238 "c:/mcc18/h/string.h"
 
char *strrchr (auto const char *s, auto unsigned char c);


#line 249 "c:/mcc18/h/string.h"
 
size_t strspn (auto const char *s1, auto const char *s2);


#line 262 "c:/mcc18/h/string.h"
 
char *strstr (auto const char *s1, auto const char *s2);


#line 305 "c:/mcc18/h/string.h"
 
char *strtok (auto char *s1, auto const char *s2);


#line 321 "c:/mcc18/h/string.h"
 
void *memset (auto void *s, auto unsigned char c, auto size_t n);


#line 339 "c:/mcc18/h/string.h"
 
#line 341 "c:/mcc18/h/string.h"


#line 349 "c:/mcc18/h/string.h"
 
size_t strlen (auto const char *s);


#line 358 "c:/mcc18/h/string.h"
 
char *strupr (auto char *s);


#line 367 "c:/mcc18/h/string.h"
 
char *strlwr (auto char *s);



 

#line 379 "c:/mcc18/h/string.h"
 
far  rom void *memcpypgm (auto far  rom void *s1, auto const far  rom void *s2, auto sizerom_t n);


#line 389 "c:/mcc18/h/string.h"
 
void *memcpypgm2ram (auto void *s1, auto const far  rom void *s2, auto sizeram_t n);


#line 398 "c:/mcc18/h/string.h"
 
far  rom void *memcpyram2pgm (auto far  rom void *s1, auto const void *s2, auto sizeram_t n);


#line 407 "c:/mcc18/h/string.h"
 
far  rom void *memmovepgm (auto far  rom void *s1, auto const far  rom void *s2, auto sizerom_t n);


#line 417 "c:/mcc18/h/string.h"
 
void *memmovepgm2ram (auto void *s1, auto const far  rom void *s2, auto sizeram_t n);


#line 426 "c:/mcc18/h/string.h"
 
far  rom void *memmoveram2pgm (auto far  rom void *s1, auto const void *s2, auto sizeram_t n);


#line 434 "c:/mcc18/h/string.h"
 
far  rom char *strcpypgm (auto far  rom char *s1, auto const far  rom char *s2);


#line 443 "c:/mcc18/h/string.h"
 
char *strcpypgm2ram (auto char *s1, auto const far  rom char *s2);


#line 451 "c:/mcc18/h/string.h"
 
far  rom char *strcpyram2pgm (auto far  rom char *s1, auto const char *s2);


#line 460 "c:/mcc18/h/string.h"
 
far  rom char *strncpypgm (auto far  rom char *s1, auto const far  rom char *s2, auto sizerom_t n);


#line 470 "c:/mcc18/h/string.h"
 
char *strncpypgm2ram (auto char *s1, auto const far  rom char *s2, auto sizeram_t n);


#line 479 "c:/mcc18/h/string.h"
 
far  rom char *strncpyram2pgm (auto far  rom char *s1, auto const char *s2, auto sizeram_t n);


#line 487 "c:/mcc18/h/string.h"
 
far  rom char *strcatpgm (auto far  rom char *s1, auto const far  rom char *s2);


#line 496 "c:/mcc18/h/string.h"
 
char *strcatpgm2ram (auto char *s1, auto const far  rom char *s2);


#line 504 "c:/mcc18/h/string.h"
 
far  rom char *strcatram2pgm (auto far  rom char *s1, auto const char *s2);


#line 513 "c:/mcc18/h/string.h"
 
far  rom char *strncatpgm (auto far  rom char *s1, auto const far  rom char *s2, auto sizerom_t n);


#line 523 "c:/mcc18/h/string.h"
 
char *strncatpgm2ram (auto char *s1, auto const far  rom char *s2, auto sizeram_t n);


#line 532 "c:/mcc18/h/string.h"
 
far  rom char *strncatram2pgm (auto far  rom char *s1, auto const char *s2, auto sizeram_t n);


#line 541 "c:/mcc18/h/string.h"
 
signed char memcmppgm (auto far  rom void *s1, auto const far  rom void *s2, auto sizerom_t n);


#line 551 "c:/mcc18/h/string.h"
 
signed char memcmppgm2ram (auto void *s1, auto const far  rom void *s2, auto sizeram_t n);


#line 560 "c:/mcc18/h/string.h"
 
signed char memcmpram2pgm (auto far  rom void *s1, auto const void *s2, auto sizeram_t n);


#line 568 "c:/mcc18/h/string.h"
 
signed char strcmppgm (auto const far  rom char *s1, auto const far  rom char *s2);


#line 577 "c:/mcc18/h/string.h"
 
signed char strcmppgm2ram (auto const char *s1, auto const far  rom char *s2);


#line 585 "c:/mcc18/h/string.h"
 
signed char strcmpram2pgm (auto const far  rom char *s1, auto const char *s2);


#line 594 "c:/mcc18/h/string.h"
 
signed char strncmppgm (auto const far  rom char *s1, auto const far  rom char *s2, auto sizerom_t n);


#line 604 "c:/mcc18/h/string.h"
 
signed char strncmppgm2ram (auto char *s1, auto const far  rom char *s2, auto sizeram_t n);


#line 613 "c:/mcc18/h/string.h"
 
signed char strncmpram2pgm (auto far  rom char *s1, auto const char *s2, auto sizeram_t n);


#line 622 "c:/mcc18/h/string.h"
 
far  rom char *memchrpgm (auto const far  rom char *s, auto const unsigned char c, auto sizerom_t n);


#line 631 "c:/mcc18/h/string.h"
 
far  rom char *strchrpgm (auto const far  rom char *s, auto unsigned char c);


#line 639 "c:/mcc18/h/string.h"
 
sizerom_t strcspnpgm (auto const far  rom char *s1, auto const far  rom char *s2);


#line 647 "c:/mcc18/h/string.h"
 
sizerom_t strcspnpgmram (auto const far  rom char *s1, auto const char *s2);


#line 655 "c:/mcc18/h/string.h"
 
sizeram_t strcspnrampgm (auto const char *s1, auto const far  rom char *s2);


#line 663 "c:/mcc18/h/string.h"
 
far  rom char *strpbrkpgm (auto const far  rom char *s1, auto const far  rom char *s2);


#line 671 "c:/mcc18/h/string.h"
 
far  rom char *strpbrkpgmram (auto const far  rom char *s1, auto const char *s2);


#line 679 "c:/mcc18/h/string.h"
 
char *strpbrkrampgm (auto const char *s1, auto const far  rom char *s2);


#line 688 "c:/mcc18/h/string.h"
 
 


#line 696 "c:/mcc18/h/string.h"
 
sizerom_t strspnpgm (auto const far  rom char *s1, auto const far  rom char *s2);


#line 704 "c:/mcc18/h/string.h"
 
sizerom_t strspnpgmram (auto const far  rom char *s1, auto const char *s2);


#line 712 "c:/mcc18/h/string.h"
 
sizeram_t strspnrampgm (auto const char *s1, auto const far  rom char *s2);


#line 720 "c:/mcc18/h/string.h"
 
far  rom char *strstrpgm (auto const far  rom char *s1, auto const far  rom char *s2);


#line 729 "c:/mcc18/h/string.h"
 
far  rom char *strstrpgmram (auto const far  rom char *s1, auto const char *s2);


#line 737 "c:/mcc18/h/string.h"
 
char *strstrrampgm (auto const char *s1, auto const far  rom char *s2);


#line 745 "c:/mcc18/h/string.h"
 
far  rom char *strtokpgm (auto far  rom char *s1, auto const far  rom char *s2);


#line 754 "c:/mcc18/h/string.h"
 
char *strtokpgmram (auto char *s1, auto const far  rom char *s2);


#line 762 "c:/mcc18/h/string.h"
 
far  rom char *strtokrampgm (auto far  rom char *s1, auto const char *s2);


#line 771 "c:/mcc18/h/string.h"
 
far  rom void *memsetpgm (auto far  rom void *s, auto unsigned char c, auto sizerom_t n);


#line 778 "c:/mcc18/h/string.h"
 
far  rom char *struprpgm (auto far  rom char *s);


#line 785 "c:/mcc18/h/string.h"
 
far  rom char *strlwrpgm (auto far  rom char *s);


#line 792 "c:/mcc18/h/string.h"
 
sizerom_t strlenpgm (auto const far  rom char *s);

#line 796 "c:/mcc18/h/string.h"

#line 798 "c:/mcc18/h/string.h"

#line 805 "c:/mcc18/h/string.h"
#line 814 "c:/mcc18/h/string.h"

#line 816 "c:/mcc18/h/string.h"
#line 5 "main.c"

#line 1 "c:/mcc18/h/adc.h"

#line 3 "c:/mcc18/h/adc.h"

#line 30 "c:/mcc18/h/adc.h"
 

#line 1 "c:/mcc18/h/pconfig.h"



#line 5 "c:/mcc18/h/pconfig.h"

#line 11 "c:/mcc18/h/pconfig.h"
 



#line 1 "c:/mcc18/h/p18cxxx.h"

#line 3 "c:/mcc18/h/p18cxxx.h"

#line 5 "c:/mcc18/h/p18cxxx.h"
#line 7 "c:/mcc18/h/p18cxxx.h"
#line 9 "c:/mcc18/h/p18cxxx.h"
#line 11 "c:/mcc18/h/p18cxxx.h"
#line 13 "c:/mcc18/h/p18cxxx.h"
#line 15 "c:/mcc18/h/p18cxxx.h"
#line 17 "c:/mcc18/h/p18cxxx.h"
#line 19 "c:/mcc18/h/p18cxxx.h"
#line 21 "c:/mcc18/h/p18cxxx.h"
#line 23 "c:/mcc18/h/p18cxxx.h"
#line 25 "c:/mcc18/h/p18cxxx.h"
#line 27 "c:/mcc18/h/p18cxxx.h"
#line 29 "c:/mcc18/h/p18cxxx.h"
#line 31 "c:/mcc18/h/p18cxxx.h"
#line 33 "c:/mcc18/h/p18cxxx.h"
#line 35 "c:/mcc18/h/p18cxxx.h"
#line 37 "c:/mcc18/h/p18cxxx.h"
#line 39 "c:/mcc18/h/p18cxxx.h"
#line 41 "c:/mcc18/h/p18cxxx.h"
#line 43 "c:/mcc18/h/p18cxxx.h"
#line 45 "c:/mcc18/h/p18cxxx.h"
#line 47 "c:/mcc18/h/p18cxxx.h"
#line 49 "c:/mcc18/h/p18cxxx.h"
#line 51 "c:/mcc18/h/p18cxxx.h"
#line 53 "c:/mcc18/h/p18cxxx.h"
#line 55 "c:/mcc18/h/p18cxxx.h"
#line 57 "c:/mcc18/h/p18cxxx.h"
#line 59 "c:/mcc18/h/p18cxxx.h"
#line 61 "c:/mcc18/h/p18cxxx.h"
#line 63 "c:/mcc18/h/p18cxxx.h"
#line 65 "c:/mcc18/h/p18cxxx.h"
#line 67 "c:/mcc18/h/p18cxxx.h"
#line 69 "c:/mcc18/h/p18cxxx.h"
#line 71 "c:/mcc18/h/p18cxxx.h"
#line 73 "c:/mcc18/h/p18cxxx.h"
#line 75 "c:/mcc18/h/p18cxxx.h"
#line 77 "c:/mcc18/h/p18cxxx.h"
#line 79 "c:/mcc18/h/p18cxxx.h"
#line 81 "c:/mcc18/h/p18cxxx.h"
#line 83 "c:/mcc18/h/p18cxxx.h"
#line 85 "c:/mcc18/h/p18cxxx.h"
#line 87 "c:/mcc18/h/p18cxxx.h"
#line 89 "c:/mcc18/h/p18cxxx.h"
#line 91 "c:/mcc18/h/p18cxxx.h"
#line 93 "c:/mcc18/h/p18cxxx.h"
#line 95 "c:/mcc18/h/p18cxxx.h"
#line 97 "c:/mcc18/h/p18cxxx.h"
#line 99 "c:/mcc18/h/p18cxxx.h"
#line 101 "c:/mcc18/h/p18cxxx.h"
#line 103 "c:/mcc18/h/p18cxxx.h"
#line 105 "c:/mcc18/h/p18cxxx.h"
#line 107 "c:/mcc18/h/p18cxxx.h"
#line 109 "c:/mcc18/h/p18cxxx.h"
#line 111 "c:/mcc18/h/p18cxxx.h"
#line 113 "c:/mcc18/h/p18cxxx.h"
#line 115 "c:/mcc18/h/p18cxxx.h"
#line 117 "c:/mcc18/h/p18cxxx.h"
#line 119 "c:/mcc18/h/p18cxxx.h"
#line 121 "c:/mcc18/h/p18cxxx.h"
#line 123 "c:/mcc18/h/p18cxxx.h"
#line 125 "c:/mcc18/h/p18cxxx.h"
#line 127 "c:/mcc18/h/p18cxxx.h"
#line 129 "c:/mcc18/h/p18cxxx.h"
#line 131 "c:/mcc18/h/p18cxxx.h"
#line 133 "c:/mcc18/h/p18cxxx.h"
#line 135 "c:/mcc18/h/p18cxxx.h"
#line 137 "c:/mcc18/h/p18cxxx.h"
#line 139 "c:/mcc18/h/p18cxxx.h"
#line 141 "c:/mcc18/h/p18cxxx.h"
#line 143 "c:/mcc18/h/p18cxxx.h"
#line 145 "c:/mcc18/h/p18cxxx.h"
#line 147 "c:/mcc18/h/p18cxxx.h"
#line 149 "c:/mcc18/h/p18cxxx.h"
#line 151 "c:/mcc18/h/p18cxxx.h"
#line 153 "c:/mcc18/h/p18cxxx.h"
#line 155 "c:/mcc18/h/p18cxxx.h"
#line 157 "c:/mcc18/h/p18cxxx.h"
#line 159 "c:/mcc18/h/p18cxxx.h"
#line 161 "c:/mcc18/h/p18cxxx.h"
#line 163 "c:/mcc18/h/p18cxxx.h"
#line 165 "c:/mcc18/h/p18cxxx.h"
#line 167 "c:/mcc18/h/p18cxxx.h"
#line 169 "c:/mcc18/h/p18cxxx.h"
#line 171 "c:/mcc18/h/p18cxxx.h"
#line 173 "c:/mcc18/h/p18cxxx.h"
#line 175 "c:/mcc18/h/p18cxxx.h"
#line 177 "c:/mcc18/h/p18cxxx.h"
#line 179 "c:/mcc18/h/p18cxxx.h"
#line 181 "c:/mcc18/h/p18cxxx.h"
#line 1 "c:/mcc18/h/p18f452.h"

#line 5 "c:/mcc18/h/p18f452.h"
 


#line 9 "c:/mcc18/h/p18f452.h"

extern volatile near unsigned char       PORTA;
extern volatile near union {
  struct {
    unsigned RA0:1;
    unsigned RA1:1;
    unsigned RA2:1;
    unsigned RA3:1;
    unsigned RA4:1;
    unsigned RA5:1;
    unsigned RA6:1;
  };
  struct {
    unsigned AN0:1;
    unsigned AN1:1;
    unsigned AN2:1;
    unsigned AN3:1;
    unsigned :1;
    unsigned AN4:1;
    unsigned OSC2:1;
  };
  struct {
    unsigned :2;
    unsigned VREFM:1;
    unsigned VREFP:1;
    unsigned T0CKI:1;
    unsigned SS:1;
    unsigned CLK0:1;
  };
  struct {
    unsigned :5;
    unsigned LVDIN:1;
  };
} PORTAbits;
extern volatile near unsigned char       PORTB;
extern volatile near union {
  struct {
    unsigned RB0:1;
    unsigned RB1:1;
    unsigned RB2:1;
    unsigned RB3:1;
    unsigned RB4:1;
    unsigned RB5:1;
    unsigned RB6:1;
    unsigned RB7:1;
  };
  struct {
    unsigned INT0:1;
    unsigned INT1:1;
    unsigned INT2:1;
    unsigned CCP2:1;
    unsigned :1;
    unsigned PGM:1;
    unsigned PGC:1;
    unsigned PGD:1;
  };
} PORTBbits;
extern volatile near unsigned char       PORTC;
extern volatile near union {
  struct {
    unsigned RC0:1;
    unsigned RC1:1;
    unsigned RC2:1;
    unsigned RC3:1;
    unsigned RC4:1;
    unsigned RC5:1;
    unsigned RC6:1;
    unsigned RC7:1;
  };
  struct {
    unsigned T1OSO:1;
    unsigned T1OSI:1;
    unsigned :1;
    unsigned SCK:1;
    unsigned SDI:1;
    unsigned SDO:1;
    unsigned TX:1;
    unsigned RX:1;
  };
  struct {
    unsigned T1CKI:1;
    unsigned CCP2:1;
    unsigned CCP1:1;
    unsigned SCL:1;
    unsigned SDA:1;
    unsigned :1;
    unsigned CK:1;
    unsigned DT:1;
  };
} PORTCbits;
extern volatile near unsigned char       PORTD;
extern volatile near union {
  struct {
    unsigned RD0:1;
    unsigned RD1:1;
    unsigned RD2:1;
    unsigned RD3:1;
    unsigned RD4:1;
    unsigned RD5:1;
    unsigned RD6:1;
    unsigned RD7:1;
  };
  struct {
    unsigned PSP0:1;
    unsigned PSP1:1;
    unsigned PSP2:1;
    unsigned PSP3:1;
    unsigned PSP4:1;
    unsigned PSP5:1;
    unsigned PSP6:1;
    unsigned PSP7:1;
  };
} PORTDbits;
extern volatile near unsigned char       PORTE;
extern volatile near union {
  struct {
    unsigned RE0:1;
    unsigned RE1:1;
    unsigned RE2:1;
  };
  struct {
    unsigned AN5:1;
    unsigned AN6:1;
    unsigned AN7:1;
  };
} PORTEbits;
extern volatile near unsigned char       LATA;
extern volatile near struct {
  unsigned LATA0:1;
  unsigned LATA1:1;
  unsigned LATA2:1;
  unsigned LATA3:1;
  unsigned LATA4:1;
  unsigned LATA5:1;
  unsigned LATA6:1;
} LATAbits;
extern volatile near unsigned char       LATB;
extern volatile near struct {
  unsigned LATB0:1;
  unsigned LATB1:1;
  unsigned LATB2:1;
  unsigned LATB3:1;
  unsigned LATB4:1;
  unsigned LATB5:1;
  unsigned LATB6:1;
  unsigned LATB7:1;
} LATBbits;
extern volatile near unsigned char       LATC;
extern volatile near struct {
  unsigned LATC0:1;
  unsigned LATC1:1;
  unsigned LATC2:1;
  unsigned LATC3:1;
  unsigned LATC4:1;
  unsigned LATC5:1;
  unsigned LATC6:1;
  unsigned LATC7:1;
} LATCbits;
extern volatile near unsigned char       LATD;
extern volatile near struct {
  unsigned LATD0:1;
  unsigned LATD1:1;
  unsigned LATD2:1;
  unsigned LATD3:1;
  unsigned LATD4:1;
  unsigned LATD5:1;
  unsigned LATD6:1;
  unsigned LATD7:1;
} LATDbits;
extern volatile near unsigned char       LATE;
extern volatile near struct {
  unsigned LATE0:1;
  unsigned LATE1:1;
  unsigned LATE2:1;
} LATEbits;
extern volatile near unsigned char       DDRA;
extern volatile near struct {
  unsigned RA0:1;
  unsigned RA1:1;
  unsigned RA2:1;
  unsigned RA3:1;
  unsigned RA4:1;
  unsigned RA5:1;
  unsigned RA6:1;
} DDRAbits;
extern volatile near unsigned char       TRISA;
extern volatile near struct {
  unsigned TRISA0:1;
  unsigned TRISA1:1;
  unsigned TRISA2:1;
  unsigned TRISA3:1;
  unsigned TRISA4:1;
  unsigned TRISA5:1;
  unsigned TRISA6:1;
} TRISAbits;
extern volatile near unsigned char       DDRB;
extern volatile near struct {
  unsigned RB0:1;
  unsigned RB1:1;
  unsigned RB2:1;
  unsigned RB3:1;
  unsigned RB4:1;
  unsigned RB5:1;
  unsigned RB6:1;
  unsigned RB7:1;
} DDRBbits;
extern volatile near unsigned char       TRISB;
extern volatile near struct {
  unsigned TRISB0:1;
  unsigned TRISB1:1;
  unsigned TRISB2:1;
  unsigned TRISB3:1;
  unsigned TRISB4:1;
  unsigned TRISB5:1;
  unsigned TRISB6:1;
  unsigned TRISB7:1;
} TRISBbits;
extern volatile near unsigned char       DDRC;
extern volatile near struct {
  unsigned RC0:1;
  unsigned RC1:1;
  unsigned RC2:1;
  unsigned RC3:1;
  unsigned RC4:1;
  unsigned RC5:1;
  unsigned RC6:1;
  unsigned RC7:1;
} DDRCbits;
extern volatile near unsigned char       TRISC;
extern volatile near struct {
  unsigned TRISC0:1;
  unsigned TRISC1:1;
  unsigned TRISC2:1;
  unsigned TRISC3:1;
  unsigned TRISC4:1;
  unsigned TRISC5:1;
  unsigned TRISC6:1;
  unsigned TRISC7:1;
} TRISCbits;
extern volatile near unsigned char       DDRD;
extern volatile near struct {
  unsigned RD0:1;
  unsigned RD1:1;
  unsigned RD2:1;
  unsigned RD3:1;
  unsigned RD4:1;
  unsigned RD5:1;
  unsigned RD6:1;
  unsigned RD7:1;
} DDRDbits;
extern volatile near unsigned char       TRISD;
extern volatile near struct {
  unsigned TRISD0:1;
  unsigned TRISD1:1;
  unsigned TRISD2:1;
  unsigned TRISD3:1;
  unsigned TRISD4:1;
  unsigned TRISD5:1;
  unsigned TRISD6:1;
  unsigned TRISD7:1;
} TRISDbits;
extern volatile near unsigned char       DDRE;
extern volatile near union {
  struct {
    unsigned RE0:1;
    unsigned RE1:1;
    unsigned RE2:1;
  };
  struct {
    unsigned :4;
    unsigned PSPMODE:1;
    unsigned IBOV:1;
    unsigned OBF:1;
    unsigned IBF:1;
  };
} DDREbits;
extern volatile near unsigned char       TRISE;
extern volatile near union {
  struct {
    unsigned TRISE0:1;
    unsigned TRISE1:1;
    unsigned TRISE2:1;
  };
  struct {
    unsigned :4;
    unsigned PSPMODE:1;
    unsigned IBOV:1;
    unsigned OBF:1;
    unsigned IBF:1;
  };
} TRISEbits;
extern volatile near unsigned char       PIE1;
extern volatile near struct {
  unsigned TMR1IE:1;
  unsigned TMR2IE:1;
  unsigned CCP1IE:1;
  unsigned SSPIE:1;
  unsigned TXIE:1;
  unsigned RCIE:1;
  unsigned ADIE:1;
  unsigned PSPIE:1;
} PIE1bits;
extern volatile near unsigned char       PIR1;
extern volatile near struct {
  unsigned TMR1IF:1;
  unsigned TMR2IF:1;
  unsigned CCP1IF:1;
  unsigned SSPIF:1;
  unsigned TXIF:1;
  unsigned RCIF:1;
  unsigned ADIF:1;
  unsigned PSPIF:1;
} PIR1bits;
extern volatile near unsigned char       IPR1;
extern volatile near struct {
  unsigned TMR1IP:1;
  unsigned TMR2IP:1;
  unsigned CCP1IP:1;
  unsigned SSPIP:1;
  unsigned TXIP:1;
  unsigned RCIP:1;
  unsigned ADIP:1;
  unsigned PSPIP:1;
} IPR1bits;
extern volatile near unsigned char       PIE2;
extern volatile near struct {
  unsigned CCP2IE:1;
  unsigned TMR3IE:1;
  unsigned LVDIE:1;
  unsigned BCLIE:1;
  unsigned EEIE:1;
} PIE2bits;
extern volatile near unsigned char       PIR2;
extern volatile near struct {
  unsigned CCP2IF:1;
  unsigned TMR3IF:1;
  unsigned LVDIF:1;
  unsigned BCLIF:1;
  unsigned EEIF:1;
} PIR2bits;
extern volatile near unsigned char       IPR2;
extern volatile near struct {
  unsigned CCP2IP:1;
  unsigned TMR3IP:1;
  unsigned LVDIP:1;
  unsigned BCLIP:1;
  unsigned EEIP:1;
} IPR2bits;
extern volatile near unsigned char       EECON1;
extern volatile near struct {
  unsigned RD:1;
  unsigned WR:1;
  unsigned WREN:1;
  unsigned WRERR:1;
  unsigned FREE:1;
  unsigned :1;
  unsigned CFGS:1;
  unsigned EEPGD:1;
} EECON1bits;
extern volatile near unsigned char       EECON2;
extern volatile near unsigned char       EEDATA;
extern volatile near unsigned char       EEADR;
extern volatile near unsigned char       RCSTA;
extern volatile near struct {
  unsigned RX9D:1;
  unsigned OERR:1;
  unsigned FERR:1;
  unsigned ADDEN:1;
  unsigned CREN:1;
  unsigned SREN:1;
  unsigned RX9:1;
  unsigned SPEN:1;
} RCSTAbits;
extern volatile near unsigned char       TXSTA;
extern volatile near struct {
  unsigned TX9D:1;
  unsigned TRMT:1;
  unsigned BRGH:1;
  unsigned :1;
  unsigned SYNC:1;
  unsigned TXEN:1;
  unsigned TX9:1;
  unsigned CSRC:1;
} TXSTAbits;
extern volatile near unsigned char       TXREG;
extern volatile near unsigned char       RCREG;
extern volatile near unsigned char       SPBRG;
extern volatile near unsigned char       T3CON;
extern volatile near union {
  struct {
    unsigned TMR3ON:1;
    unsigned TMR3CS:1;
    unsigned T3SYNC:1;
    unsigned T3CCP1:1;
    unsigned T3CKPS0:1;
    unsigned T3CKPS1:1;
    unsigned T3CCP2:1;
    unsigned RD16:1;
  };
  struct {
    unsigned :2;
    unsigned NOT_T3SYNC:1;
  };
} T3CONbits;
extern volatile near unsigned char       TMR3L;
extern volatile near unsigned char       TMR3H;
extern volatile near unsigned char       CCP2CON;
extern volatile near union {
  struct {
    unsigned CCP2M0:1;
    unsigned CCP2M1:1;
    unsigned CCP2M2:1;
    unsigned CCP2M3:1;
    unsigned CCP2Y:1;
    unsigned CCP2X:1;
  };
  struct {
    unsigned :4;
    unsigned DC2B0:1;
    unsigned DC2B1:1;
  };
  struct {
    unsigned :5;
    unsigned DCCPX:1;
  };
} CCP2CONbits;
extern volatile near unsigned            CCPR2;
extern volatile near unsigned char       CCPR2L;
extern volatile near unsigned char       CCPR2H;
extern volatile near unsigned char       CCP1CON;
extern volatile near union {
  struct {
    unsigned CCP1M0:1;
    unsigned CCP1M1:1;
    unsigned CCP1M2:1;
    unsigned CCP1M3:1;
    unsigned CCP1Y:1;
    unsigned CCP1X:1;
  };
  struct {
    unsigned :4;
    unsigned DC1B0:1;
    unsigned DC1B1:1;
  };
} CCP1CONbits;
extern volatile near unsigned            CCPR1;
extern volatile near unsigned char       CCPR1L;
extern volatile near unsigned char       CCPR1H;
extern volatile near unsigned char       ADCON1;
extern volatile near struct {
  unsigned PCFG0:1;
  unsigned PCFG1:1;
  unsigned PCFG2:1;
  unsigned PCFG3:1;
  unsigned :2;
  unsigned ADCS2:1;
  unsigned ADFM:1;
} ADCON1bits;
extern volatile near unsigned char       ADCON0;
extern volatile near union {
  struct {
    unsigned ADON:1;
    unsigned :1;
    unsigned GO:1;
    unsigned CHS0:1;
    unsigned CHS1:1;
    unsigned CHS2:1;
    unsigned ADCS0:1;
    unsigned ADCS1:1;
  };
  struct {
    unsigned :2;
    unsigned NOT_DONE:1;
  };
  struct {
    unsigned :2;
    unsigned DONE:1;
  };
  struct {
    unsigned :2;
    unsigned GO_DONE:1;
  };
} ADCON0bits;
extern volatile near unsigned            ADRES;
extern volatile near unsigned char       ADRESL;
extern volatile near unsigned char       ADRESH;
extern volatile near unsigned char       SSPCON2;
extern volatile near struct {
  unsigned SEN:1;
  unsigned RSEN:1;
  unsigned PEN:1;
  unsigned RCEN:1;
  unsigned ACKEN:1;
  unsigned ACKDT:1;
  unsigned ACKSTAT:1;
  unsigned GCEN:1;
} SSPCON2bits;
extern volatile near unsigned char       SSPCON1;
extern volatile near struct {
  unsigned SSPM0:1;
  unsigned SSPM1:1;
  unsigned SSPM2:1;
  unsigned SSPM3:1;
  unsigned CKP:1;
  unsigned SSPEN:1;
  unsigned SSPOV:1;
  unsigned WCOL:1;
} SSPCON1bits;
extern volatile near unsigned char       SSPSTAT;
extern volatile near struct {
  unsigned BF:1;
  unsigned UA:1;
  unsigned R_W:1;
  unsigned S:1;
  unsigned P:1;
  unsigned D_A:1;
  unsigned CKE:1;
  unsigned SMP:1;
} SSPSTATbits;
extern volatile near unsigned char       SSPADD;
extern volatile near unsigned char       SSPBUF;
extern volatile near unsigned char       T2CON;
extern volatile near struct {
  unsigned T2CKPS0:1;
  unsigned T2CKPS1:1;
  unsigned TMR2ON:1;
  unsigned TOUTPS0:1;
  unsigned TOUTPS1:1;
  unsigned TOUTPS2:1;
  unsigned TOUTPS3:1;
} T2CONbits;
extern volatile near unsigned char       PR2;
extern volatile near unsigned char       TMR2;
extern volatile near unsigned char       T1CON;
extern volatile near union {
  struct {
    unsigned TMR1ON:1;
    unsigned TMR1CS:1;
    unsigned NOT_T1SYNC:1;
    unsigned T1OSCEN:1;
    unsigned T1CKPS0:1;
    unsigned T1CKPS1:1;
    unsigned :1;
    unsigned RD16:1;
  };
  struct {
    unsigned :2;
    unsigned T1SYNC:1;
  };
} T1CONbits;
extern volatile near unsigned char       TMR1L;
extern volatile near unsigned char       TMR1H;
extern volatile near unsigned char       RCON;
extern volatile near union {
  struct {
    unsigned NOT_BOR:1;
    unsigned NOT_POR:1;
    unsigned NOT_PD:1;
    unsigned NOT_TO:1;
    unsigned NOT_RI:1;
    unsigned :1;
    unsigned NOT_LWRT:1;
    unsigned NOT_IPEN:1;
  };
  struct {
    unsigned BOR:1;
    unsigned POR:1;
    unsigned PD:1;
    unsigned TO:1;
    unsigned RI:1;
    unsigned :1;
    unsigned LWRT:1;
    unsigned IPEN:1;
  };
} RCONbits;
extern volatile near unsigned char       WDTCON;
extern volatile near union {
  struct {
    unsigned SWDTEN:1;
  };
  struct {
    unsigned SWDTE:1;
  };
} WDTCONbits;
extern volatile near unsigned char       LVDCON;
extern volatile near struct {
  unsigned LVDL0:1;
  unsigned LVDL1:1;
  unsigned LVDL2:1;
  unsigned LVDL3:1;
  unsigned LVDEN:1;
  unsigned IRVST:1;
} LVDCONbits;
extern volatile near unsigned char       OSCCON;
extern volatile near struct {
  unsigned SCS:1;
} OSCCONbits;
extern volatile near unsigned char       T0CON;
extern volatile near struct {
  unsigned T0PS0:1;
  unsigned T0PS1:1;
  unsigned T0PS2:1;
  unsigned PSA:1;
  unsigned T0SE:1;
  unsigned T0CS:1;
  unsigned T08BIT:1;
  unsigned TMR0ON:1;
} T0CONbits;
extern volatile near unsigned char       TMR0L;
extern volatile near unsigned char       TMR0H;
extern          near unsigned char       STATUS;
extern          near struct {
  unsigned C:1;
  unsigned DC:1;
  unsigned Z:1;
  unsigned OV:1;
  unsigned N:1;
} STATUSbits;
extern          near unsigned            FSR2;
extern          near unsigned char       FSR2L;
extern          near unsigned char       FSR2H;
extern volatile near unsigned char       PLUSW2;
extern volatile near unsigned char       PREINC2;
extern volatile near unsigned char       POSTDEC2;
extern volatile near unsigned char       POSTINC2;
extern          near unsigned char       INDF2;
extern          near unsigned char       BSR;
extern          near unsigned            FSR1;
extern          near unsigned char       FSR1L;
extern          near unsigned char       FSR1H;
extern volatile near unsigned char       PLUSW1;
extern volatile near unsigned char       PREINC1;
extern volatile near unsigned char       POSTDEC1;
extern volatile near unsigned char       POSTINC1;
extern          near unsigned char       INDF1;
extern          near unsigned char       W;
extern          near unsigned char       WREG;
extern          near unsigned            FSR0;
extern          near unsigned char       FSR0L;
extern          near unsigned char       FSR0H;
extern volatile near unsigned char       PLUSW0;
extern volatile near unsigned char       PREINC0;
extern volatile near unsigned char       POSTDEC0;
extern volatile near unsigned char       POSTINC0;
extern          near unsigned char       INDF0;
extern volatile near unsigned char       INTCON3;
extern volatile near union {
  struct {
    unsigned INT1F:1;
    unsigned INT2F:1;
    unsigned :1;
    unsigned INT1E:1;
    unsigned INT2E:1;
    unsigned :1;
    unsigned INT1P:1;
    unsigned INT2P:1;
  };
  struct {
    unsigned INT1IF:1;
    unsigned INT2IF:1;
    unsigned :1;
    unsigned INT1IE:1;
    unsigned INT2IE:1;
    unsigned :1;
    unsigned INT1IP:1;
    unsigned INT2IP:1;
  };
} INTCON3bits;
extern volatile near unsigned char       INTCON2;
extern volatile near union {
  struct {
    unsigned RBIP:1;
    unsigned INT3P:1;
    unsigned T0IP:1;
    unsigned INTEDG3:1;
    unsigned INTEDG2:1;
    unsigned INTEDG1:1;
    unsigned INTEDG0:1;
    unsigned RBPU:1;
  };
  struct {
    unsigned :2;
    unsigned TMR0IP:1;
  };
} INTCON2bits;
extern volatile near unsigned char       INTCON;
extern volatile near union {
  struct {
    unsigned RBIF:1;
    unsigned INT0F:1;
    unsigned T0IF:1;
    unsigned RBIE:1;
    unsigned INT0E:1;
    unsigned T0IE:1;
    unsigned PEIE:1;
    unsigned GIE:1;
  };
  struct {
    unsigned :1;
    unsigned INT0IF:1;
    unsigned TMR0IF:1;
    unsigned :1;
    unsigned INT0IE:1;
    unsigned TMR0IE:1;
    unsigned GIEL:1;
    unsigned GIEH:1;
  };
} INTCONbits;
extern          near unsigned            PROD;
extern          near unsigned char       PRODL;
extern          near unsigned char       PRODH;
extern volatile near unsigned char       TABLAT;
extern volatile near unsigned short long TBLPTR;
extern volatile near unsigned char       TBLPTRL;
extern volatile near unsigned char       TBLPTRH;
extern volatile near unsigned char       TBLPTRU;
extern volatile near unsigned short long PC;
extern volatile near unsigned char       PCL;
extern volatile near unsigned char       PCLATH;
extern volatile near unsigned char       PCLATU;
extern volatile near unsigned char       STKPTR;
extern volatile near struct {
  unsigned STKPTR0:1;
  unsigned STKPTR1:1;
  unsigned STKPTR2:1;
  unsigned STKPTR3:1;
  unsigned STKPTR4:1;
  unsigned :1;
  unsigned STKUNF:1;
  unsigned STKFUL:1;
} STKPTRbits;
extern          near unsigned short long TOS;
extern          near unsigned char       TOSL;
extern          near unsigned char       TOSH;
extern          near unsigned char       TOSU;



#line 748 "c:/mcc18/h/p18f452.h"
 
#line 750 "c:/mcc18/h/p18f452.h"
#line 751 "c:/mcc18/h/p18f452.h"


#line 754 "c:/mcc18/h/p18f452.h"
 
#line 756 "c:/mcc18/h/p18f452.h"
#line 757 "c:/mcc18/h/p18f452.h"
#line 758 "c:/mcc18/h/p18f452.h"
#line 759 "c:/mcc18/h/p18f452.h"

#line 761 "c:/mcc18/h/p18f452.h"
#line 762 "c:/mcc18/h/p18f452.h"
#line 763 "c:/mcc18/h/p18f452.h"
#line 764 "c:/mcc18/h/p18f452.h"
#line 765 "c:/mcc18/h/p18f452.h"


#line 769 "c:/mcc18/h/p18f452.h"
 
#line 771 "c:/mcc18/h/p18f452.h"


#line 786 "c:/mcc18/h/p18f452.h"
 

#line 813 "c:/mcc18/h/p18f452.h"
#line 814 "c:/mcc18/h/p18f452.h"


#line 817 "c:/mcc18/h/p18f452.h"
 
#line 819 "c:/mcc18/h/p18f452.h"
#line 820 "c:/mcc18/h/p18f452.h"
#line 821 "c:/mcc18/h/p18f452.h"
#line 822 "c:/mcc18/h/p18f452.h"
#line 823 "c:/mcc18/h/p18f452.h"
#line 824 "c:/mcc18/h/p18f452.h"
#line 825 "c:/mcc18/h/p18f452.h"
#line 826 "c:/mcc18/h/p18f452.h"
#line 827 "c:/mcc18/h/p18f452.h"

#line 829 "c:/mcc18/h/p18f452.h"
#line 830 "c:/mcc18/h/p18f452.h"


#line 833 "c:/mcc18/h/p18f452.h"
 
#line 835 "c:/mcc18/h/p18f452.h"
#line 836 "c:/mcc18/h/p18f452.h"
#line 837 "c:/mcc18/h/p18f452.h"

#line 839 "c:/mcc18/h/p18f452.h"
#line 840 "c:/mcc18/h/p18f452.h"

#line 842 "c:/mcc18/h/p18f452.h"
#line 843 "c:/mcc18/h/p18f452.h"
#line 844 "c:/mcc18/h/p18f452.h"
#line 845 "c:/mcc18/h/p18f452.h"


#line 848 "c:/mcc18/h/p18f452.h"
 
#line 850 "c:/mcc18/h/p18f452.h"
#line 851 "c:/mcc18/h/p18f452.h"
#line 852 "c:/mcc18/h/p18f452.h"

#line 854 "c:/mcc18/h/p18f452.h"
#line 855 "c:/mcc18/h/p18f452.h"
#line 856 "c:/mcc18/h/p18f452.h"
#line 857 "c:/mcc18/h/p18f452.h"
#line 858 "c:/mcc18/h/p18f452.h"
#line 859 "c:/mcc18/h/p18f452.h"
#line 860 "c:/mcc18/h/p18f452.h"
#line 861 "c:/mcc18/h/p18f452.h"


#line 864 "c:/mcc18/h/p18f452.h"
 
#line 866 "c:/mcc18/h/p18f452.h"
#line 867 "c:/mcc18/h/p18f452.h"
#line 868 "c:/mcc18/h/p18f452.h"


#line 871 "c:/mcc18/h/p18f452.h"
 
#line 873 "c:/mcc18/h/p18f452.h"
#line 874 "c:/mcc18/h/p18f452.h"
#line 875 "c:/mcc18/h/p18f452.h"

#line 877 "c:/mcc18/h/p18f452.h"
#line 878 "c:/mcc18/h/p18f452.h"

#line 880 "c:/mcc18/h/p18f452.h"
#line 881 "c:/mcc18/h/p18f452.h"


#line 884 "c:/mcc18/h/p18f452.h"
 
#line 886 "c:/mcc18/h/p18f452.h"
#line 887 "c:/mcc18/h/p18f452.h"
#line 888 "c:/mcc18/h/p18f452.h"

#line 890 "c:/mcc18/h/p18f452.h"
#line 891 "c:/mcc18/h/p18f452.h"

#line 893 "c:/mcc18/h/p18f452.h"
#line 894 "c:/mcc18/h/p18f452.h"

#line 896 "c:/mcc18/h/p18f452.h"
#line 897 "c:/mcc18/h/p18f452.h"


#line 900 "c:/mcc18/h/p18f452.h"
 
#line 902 "c:/mcc18/h/p18f452.h"
#line 903 "c:/mcc18/h/p18f452.h"
#line 904 "c:/mcc18/h/p18f452.h"

#line 906 "c:/mcc18/h/p18f452.h"
#line 907 "c:/mcc18/h/p18f452.h"


#line 910 "c:/mcc18/h/p18f452.h"
 
#line 912 "c:/mcc18/h/p18f452.h"
#line 913 "c:/mcc18/h/p18f452.h"
#line 914 "c:/mcc18/h/p18f452.h"

#line 916 "c:/mcc18/h/p18f452.h"
#line 917 "c:/mcc18/h/p18f452.h"

#line 919 "c:/mcc18/h/p18f452.h"
#line 920 "c:/mcc18/h/p18f452.h"

#line 922 "c:/mcc18/h/p18f452.h"
#line 923 "c:/mcc18/h/p18f452.h"


#line 926 "c:/mcc18/h/p18f452.h"
 
#line 928 "c:/mcc18/h/p18f452.h"
#line 929 "c:/mcc18/h/p18f452.h"
#line 930 "c:/mcc18/h/p18f452.h"

#line 932 "c:/mcc18/h/p18f452.h"
#line 933 "c:/mcc18/h/p18f452.h"

#line 935 "c:/mcc18/h/p18f452.h"
#line 936 "c:/mcc18/h/p18f452.h"


#line 939 "c:/mcc18/h/p18f452.h"
 
#line 941 "c:/mcc18/h/p18f452.h"
#line 942 "c:/mcc18/h/p18f452.h"
#line 943 "c:/mcc18/h/p18f452.h"

#line 945 "c:/mcc18/h/p18f452.h"
#line 946 "c:/mcc18/h/p18f452.h"

#line 948 "c:/mcc18/h/p18f452.h"
#line 949 "c:/mcc18/h/p18f452.h"

#line 951 "c:/mcc18/h/p18f452.h"
#line 952 "c:/mcc18/h/p18f452.h"


#line 955 "c:/mcc18/h/p18f452.h"
 
#line 957 "c:/mcc18/h/p18f452.h"
#line 958 "c:/mcc18/h/p18f452.h"
#line 959 "c:/mcc18/h/p18f452.h"


#line 962 "c:/mcc18/h/p18f452.h"
#line 181 "c:/mcc18/h/p18cxxx.h"

#line 183 "c:/mcc18/h/p18cxxx.h"
#line 185 "c:/mcc18/h/p18cxxx.h"
#line 187 "c:/mcc18/h/p18cxxx.h"
#line 189 "c:/mcc18/h/p18cxxx.h"
#line 191 "c:/mcc18/h/p18cxxx.h"
#line 193 "c:/mcc18/h/p18cxxx.h"
#line 195 "c:/mcc18/h/p18cxxx.h"
#line 197 "c:/mcc18/h/p18cxxx.h"
#line 199 "c:/mcc18/h/p18cxxx.h"
#line 201 "c:/mcc18/h/p18cxxx.h"
#line 203 "c:/mcc18/h/p18cxxx.h"
#line 205 "c:/mcc18/h/p18cxxx.h"
#line 207 "c:/mcc18/h/p18cxxx.h"
#line 209 "c:/mcc18/h/p18cxxx.h"
#line 211 "c:/mcc18/h/p18cxxx.h"
#line 213 "c:/mcc18/h/p18cxxx.h"
#line 215 "c:/mcc18/h/p18cxxx.h"
#line 217 "c:/mcc18/h/p18cxxx.h"
#line 219 "c:/mcc18/h/p18cxxx.h"
#line 221 "c:/mcc18/h/p18cxxx.h"
#line 223 "c:/mcc18/h/p18cxxx.h"
#line 225 "c:/mcc18/h/p18cxxx.h"
#line 227 "c:/mcc18/h/p18cxxx.h"
#line 229 "c:/mcc18/h/p18cxxx.h"
#line 231 "c:/mcc18/h/p18cxxx.h"
#line 233 "c:/mcc18/h/p18cxxx.h"
#line 235 "c:/mcc18/h/p18cxxx.h"
#line 237 "c:/mcc18/h/p18cxxx.h"
#line 239 "c:/mcc18/h/p18cxxx.h"
#line 241 "c:/mcc18/h/p18cxxx.h"
#line 243 "c:/mcc18/h/p18cxxx.h"
#line 245 "c:/mcc18/h/p18cxxx.h"
#line 247 "c:/mcc18/h/p18cxxx.h"
#line 249 "c:/mcc18/h/p18cxxx.h"
#line 251 "c:/mcc18/h/p18cxxx.h"
#line 253 "c:/mcc18/h/p18cxxx.h"
#line 255 "c:/mcc18/h/p18cxxx.h"
#line 257 "c:/mcc18/h/p18cxxx.h"
#line 259 "c:/mcc18/h/p18cxxx.h"
#line 261 "c:/mcc18/h/p18cxxx.h"
#line 263 "c:/mcc18/h/p18cxxx.h"
#line 265 "c:/mcc18/h/p18cxxx.h"
#line 267 "c:/mcc18/h/p18cxxx.h"
#line 269 "c:/mcc18/h/p18cxxx.h"
#line 271 "c:/mcc18/h/p18cxxx.h"
#line 273 "c:/mcc18/h/p18cxxx.h"
#line 275 "c:/mcc18/h/p18cxxx.h"
#line 277 "c:/mcc18/h/p18cxxx.h"
#line 279 "c:/mcc18/h/p18cxxx.h"
#line 281 "c:/mcc18/h/p18cxxx.h"
#line 283 "c:/mcc18/h/p18cxxx.h"
#line 285 "c:/mcc18/h/p18cxxx.h"
#line 287 "c:/mcc18/h/p18cxxx.h"
#line 289 "c:/mcc18/h/p18cxxx.h"
#line 291 "c:/mcc18/h/p18cxxx.h"
#line 293 "c:/mcc18/h/p18cxxx.h"
#line 295 "c:/mcc18/h/p18cxxx.h"
#line 297 "c:/mcc18/h/p18cxxx.h"
#line 299 "c:/mcc18/h/p18cxxx.h"
#line 301 "c:/mcc18/h/p18cxxx.h"
#line 303 "c:/mcc18/h/p18cxxx.h"
#line 305 "c:/mcc18/h/p18cxxx.h"
#line 307 "c:/mcc18/h/p18cxxx.h"
#line 309 "c:/mcc18/h/p18cxxx.h"
#line 311 "c:/mcc18/h/p18cxxx.h"
#line 313 "c:/mcc18/h/p18cxxx.h"
#line 315 "c:/mcc18/h/p18cxxx.h"
#line 317 "c:/mcc18/h/p18cxxx.h"
#line 319 "c:/mcc18/h/p18cxxx.h"
#line 321 "c:/mcc18/h/p18cxxx.h"
#line 323 "c:/mcc18/h/p18cxxx.h"
#line 325 "c:/mcc18/h/p18cxxx.h"
#line 327 "c:/mcc18/h/p18cxxx.h"
#line 329 "c:/mcc18/h/p18cxxx.h"
#line 331 "c:/mcc18/h/p18cxxx.h"
#line 333 "c:/mcc18/h/p18cxxx.h"
#line 335 "c:/mcc18/h/p18cxxx.h"
#line 337 "c:/mcc18/h/p18cxxx.h"
#line 339 "c:/mcc18/h/p18cxxx.h"
#line 341 "c:/mcc18/h/p18cxxx.h"
#line 343 "c:/mcc18/h/p18cxxx.h"
#line 345 "c:/mcc18/h/p18cxxx.h"
#line 347 "c:/mcc18/h/p18cxxx.h"
#line 349 "c:/mcc18/h/p18cxxx.h"
#line 351 "c:/mcc18/h/p18cxxx.h"
#line 353 "c:/mcc18/h/p18cxxx.h"
#line 355 "c:/mcc18/h/p18cxxx.h"
#line 357 "c:/mcc18/h/p18cxxx.h"
#line 359 "c:/mcc18/h/p18cxxx.h"
#line 361 "c:/mcc18/h/p18cxxx.h"
#line 363 "c:/mcc18/h/p18cxxx.h"
#line 365 "c:/mcc18/h/p18cxxx.h"
#line 367 "c:/mcc18/h/p18cxxx.h"
#line 369 "c:/mcc18/h/p18cxxx.h"
#line 371 "c:/mcc18/h/p18cxxx.h"
#line 373 "c:/mcc18/h/p18cxxx.h"
#line 375 "c:/mcc18/h/p18cxxx.h"
#line 377 "c:/mcc18/h/p18cxxx.h"
#line 379 "c:/mcc18/h/p18cxxx.h"
#line 381 "c:/mcc18/h/p18cxxx.h"
#line 383 "c:/mcc18/h/p18cxxx.h"
#line 385 "c:/mcc18/h/p18cxxx.h"
#line 387 "c:/mcc18/h/p18cxxx.h"
#line 389 "c:/mcc18/h/p18cxxx.h"
#line 391 "c:/mcc18/h/p18cxxx.h"
#line 393 "c:/mcc18/h/p18cxxx.h"
#line 395 "c:/mcc18/h/p18cxxx.h"
#line 397 "c:/mcc18/h/p18cxxx.h"
#line 399 "c:/mcc18/h/p18cxxx.h"
#line 401 "c:/mcc18/h/p18cxxx.h"
#line 403 "c:/mcc18/h/p18cxxx.h"
#line 405 "c:/mcc18/h/p18cxxx.h"
#line 407 "c:/mcc18/h/p18cxxx.h"
#line 409 "c:/mcc18/h/p18cxxx.h"
#line 411 "c:/mcc18/h/p18cxxx.h"
#line 413 "c:/mcc18/h/p18cxxx.h"
#line 415 "c:/mcc18/h/p18cxxx.h"
#line 417 "c:/mcc18/h/p18cxxx.h"
#line 419 "c:/mcc18/h/p18cxxx.h"
#line 421 "c:/mcc18/h/p18cxxx.h"
#line 423 "c:/mcc18/h/p18cxxx.h"
#line 425 "c:/mcc18/h/p18cxxx.h"
#line 427 "c:/mcc18/h/p18cxxx.h"
#line 429 "c:/mcc18/h/p18cxxx.h"
#line 431 "c:/mcc18/h/p18cxxx.h"
#line 433 "c:/mcc18/h/p18cxxx.h"
#line 435 "c:/mcc18/h/p18cxxx.h"
#line 437 "c:/mcc18/h/p18cxxx.h"
#line 439 "c:/mcc18/h/p18cxxx.h"
#line 441 "c:/mcc18/h/p18cxxx.h"
#line 443 "c:/mcc18/h/p18cxxx.h"
#line 445 "c:/mcc18/h/p18cxxx.h"
#line 447 "c:/mcc18/h/p18cxxx.h"
#line 449 "c:/mcc18/h/p18cxxx.h"
#line 451 "c:/mcc18/h/p18cxxx.h"
#line 453 "c:/mcc18/h/p18cxxx.h"
#line 455 "c:/mcc18/h/p18cxxx.h"
#line 457 "c:/mcc18/h/p18cxxx.h"
#line 459 "c:/mcc18/h/p18cxxx.h"
#line 461 "c:/mcc18/h/p18cxxx.h"
#line 463 "c:/mcc18/h/p18cxxx.h"
#line 465 "c:/mcc18/h/p18cxxx.h"
#line 467 "c:/mcc18/h/p18cxxx.h"
#line 469 "c:/mcc18/h/p18cxxx.h"
#line 471 "c:/mcc18/h/p18cxxx.h"
#line 473 "c:/mcc18/h/p18cxxx.h"
#line 475 "c:/mcc18/h/p18cxxx.h"
#line 477 "c:/mcc18/h/p18cxxx.h"
#line 479 "c:/mcc18/h/p18cxxx.h"
#line 481 "c:/mcc18/h/p18cxxx.h"
#line 483 "c:/mcc18/h/p18cxxx.h"
#line 485 "c:/mcc18/h/p18cxxx.h"
#line 487 "c:/mcc18/h/p18cxxx.h"
#line 489 "c:/mcc18/h/p18cxxx.h"

#line 491 "c:/mcc18/h/p18cxxx.h"
#line 15 "c:/mcc18/h/pconfig.h"



#line 84 "c:/mcc18/h/pconfig.h"
#line 150 "c:/mcc18/h/pconfig.h"
#line 216 "c:/mcc18/h/pconfig.h"
#line 282 "c:/mcc18/h/pconfig.h"
#line 348 "c:/mcc18/h/pconfig.h"
#line 414 "c:/mcc18/h/pconfig.h"
#line 480 "c:/mcc18/h/pconfig.h"

 
 
 

 
#line 487 "c:/mcc18/h/pconfig.h"

 
 

 
#line 493 "c:/mcc18/h/pconfig.h"

 
 

 
#line 499 "c:/mcc18/h/pconfig.h"

 
 

 
#line 505 "c:/mcc18/h/pconfig.h"

 
#line 508 "c:/mcc18/h/pconfig.h"

 
#line 511 "c:/mcc18/h/pconfig.h"

 
#line 514 "c:/mcc18/h/pconfig.h"

 
#line 517 "c:/mcc18/h/pconfig.h"

 
#line 520 "c:/mcc18/h/pconfig.h"

 
 

 
#line 526 "c:/mcc18/h/pconfig.h"

 
 

 
 

 
 

 
 

 
 

 
#line 544 "c:/mcc18/h/pconfig.h"

#line 546 "c:/mcc18/h/pconfig.h"
#line 612 "c:/mcc18/h/pconfig.h"
#line 678 "c:/mcc18/h/pconfig.h"
#line 744 "c:/mcc18/h/pconfig.h"
#line 810 "c:/mcc18/h/pconfig.h"
#line 876 "c:/mcc18/h/pconfig.h"
#line 942 "c:/mcc18/h/pconfig.h"
#line 1008 "c:/mcc18/h/pconfig.h"
#line 1074 "c:/mcc18/h/pconfig.h"
#line 1140 "c:/mcc18/h/pconfig.h"
#line 1206 "c:/mcc18/h/pconfig.h"
#line 1272 "c:/mcc18/h/pconfig.h"
#line 1338 "c:/mcc18/h/pconfig.h"
#line 1404 "c:/mcc18/h/pconfig.h"
#line 1470 "c:/mcc18/h/pconfig.h"
#line 1536 "c:/mcc18/h/pconfig.h"
#line 1602 "c:/mcc18/h/pconfig.h"
#line 1668 "c:/mcc18/h/pconfig.h"
#line 1734 "c:/mcc18/h/pconfig.h"
#line 1800 "c:/mcc18/h/pconfig.h"
#line 1866 "c:/mcc18/h/pconfig.h"
#line 1932 "c:/mcc18/h/pconfig.h"
#line 1998 "c:/mcc18/h/pconfig.h"
#line 2064 "c:/mcc18/h/pconfig.h"
#line 2130 "c:/mcc18/h/pconfig.h"
#line 2196 "c:/mcc18/h/pconfig.h"
#line 2262 "c:/mcc18/h/pconfig.h"
#line 2328 "c:/mcc18/h/pconfig.h"
#line 2394 "c:/mcc18/h/pconfig.h"
#line 2460 "c:/mcc18/h/pconfig.h"
#line 2526 "c:/mcc18/h/pconfig.h"
#line 2592 "c:/mcc18/h/pconfig.h"
#line 2658 "c:/mcc18/h/pconfig.h"
#line 2724 "c:/mcc18/h/pconfig.h"
#line 2790 "c:/mcc18/h/pconfig.h"
#line 2856 "c:/mcc18/h/pconfig.h"
#line 2922 "c:/mcc18/h/pconfig.h"
#line 2988 "c:/mcc18/h/pconfig.h"
#line 3054 "c:/mcc18/h/pconfig.h"
#line 3120 "c:/mcc18/h/pconfig.h"
#line 3186 "c:/mcc18/h/pconfig.h"
#line 3252 "c:/mcc18/h/pconfig.h"
#line 3318 "c:/mcc18/h/pconfig.h"
#line 3384 "c:/mcc18/h/pconfig.h"
#line 3450 "c:/mcc18/h/pconfig.h"
#line 3516 "c:/mcc18/h/pconfig.h"
#line 3582 "c:/mcc18/h/pconfig.h"
#line 3648 "c:/mcc18/h/pconfig.h"
#line 3714 "c:/mcc18/h/pconfig.h"
#line 3780 "c:/mcc18/h/pconfig.h"
#line 3846 "c:/mcc18/h/pconfig.h"
#line 3912 "c:/mcc18/h/pconfig.h"
#line 3978 "c:/mcc18/h/pconfig.h"
#line 4044 "c:/mcc18/h/pconfig.h"
#line 4110 "c:/mcc18/h/pconfig.h"
#line 4176 "c:/mcc18/h/pconfig.h"
#line 4242 "c:/mcc18/h/pconfig.h"
#line 4308 "c:/mcc18/h/pconfig.h"
#line 4374 "c:/mcc18/h/pconfig.h"
#line 4440 "c:/mcc18/h/pconfig.h"
#line 4506 "c:/mcc18/h/pconfig.h"
#line 4572 "c:/mcc18/h/pconfig.h"
#line 4638 "c:/mcc18/h/pconfig.h"
#line 4704 "c:/mcc18/h/pconfig.h"
#line 4770 "c:/mcc18/h/pconfig.h"
#line 4836 "c:/mcc18/h/pconfig.h"
#line 4902 "c:/mcc18/h/pconfig.h"
#line 4968 "c:/mcc18/h/pconfig.h"
#line 5034 "c:/mcc18/h/pconfig.h"
#line 5100 "c:/mcc18/h/pconfig.h"
#line 5166 "c:/mcc18/h/pconfig.h"
#line 5232 "c:/mcc18/h/pconfig.h"
#line 5298 "c:/mcc18/h/pconfig.h"
#line 5364 "c:/mcc18/h/pconfig.h"
#line 5430 "c:/mcc18/h/pconfig.h"
#line 5496 "c:/mcc18/h/pconfig.h"
#line 5562 "c:/mcc18/h/pconfig.h"
#line 5628 "c:/mcc18/h/pconfig.h"
#line 5694 "c:/mcc18/h/pconfig.h"
#line 5760 "c:/mcc18/h/pconfig.h"
#line 5826 "c:/mcc18/h/pconfig.h"
#line 5892 "c:/mcc18/h/pconfig.h"
#line 5958 "c:/mcc18/h/pconfig.h"
#line 6024 "c:/mcc18/h/pconfig.h"
#line 6090 "c:/mcc18/h/pconfig.h"
#line 6156 "c:/mcc18/h/pconfig.h"
#line 6222 "c:/mcc18/h/pconfig.h"
#line 6288 "c:/mcc18/h/pconfig.h"
#line 6354 "c:/mcc18/h/pconfig.h"
#line 6420 "c:/mcc18/h/pconfig.h"
#line 6486 "c:/mcc18/h/pconfig.h"
#line 6552 "c:/mcc18/h/pconfig.h"
#line 6618 "c:/mcc18/h/pconfig.h"
#line 6684 "c:/mcc18/h/pconfig.h"
#line 6750 "c:/mcc18/h/pconfig.h"
#line 6816 "c:/mcc18/h/pconfig.h"
#line 6882 "c:/mcc18/h/pconfig.h"
#line 6948 "c:/mcc18/h/pconfig.h"
#line 7014 "c:/mcc18/h/pconfig.h"
#line 7080 "c:/mcc18/h/pconfig.h"
#line 7146 "c:/mcc18/h/pconfig.h"
#line 7212 "c:/mcc18/h/pconfig.h"
#line 7278 "c:/mcc18/h/pconfig.h"
#line 7344 "c:/mcc18/h/pconfig.h"
#line 7410 "c:/mcc18/h/pconfig.h"
#line 7476 "c:/mcc18/h/pconfig.h"
#line 7542 "c:/mcc18/h/pconfig.h"
#line 7608 "c:/mcc18/h/pconfig.h"
#line 7674 "c:/mcc18/h/pconfig.h"
#line 7740 "c:/mcc18/h/pconfig.h"
#line 7806 "c:/mcc18/h/pconfig.h"
#line 7872 "c:/mcc18/h/pconfig.h"
#line 7938 "c:/mcc18/h/pconfig.h"
#line 8004 "c:/mcc18/h/pconfig.h"
#line 8070 "c:/mcc18/h/pconfig.h"
#line 8136 "c:/mcc18/h/pconfig.h"
#line 8202 "c:/mcc18/h/pconfig.h"
#line 8268 "c:/mcc18/h/pconfig.h"
#line 8334 "c:/mcc18/h/pconfig.h"
#line 8400 "c:/mcc18/h/pconfig.h"
#line 8466 "c:/mcc18/h/pconfig.h"
#line 8532 "c:/mcc18/h/pconfig.h"
#line 8598 "c:/mcc18/h/pconfig.h"
#line 8664 "c:/mcc18/h/pconfig.h"
#line 8730 "c:/mcc18/h/pconfig.h"
#line 8796 "c:/mcc18/h/pconfig.h"
#line 8862 "c:/mcc18/h/pconfig.h"
#line 8928 "c:/mcc18/h/pconfig.h"
#line 8994 "c:/mcc18/h/pconfig.h"
#line 9060 "c:/mcc18/h/pconfig.h"
#line 9126 "c:/mcc18/h/pconfig.h"
#line 9192 "c:/mcc18/h/pconfig.h"
#line 9258 "c:/mcc18/h/pconfig.h"
#line 9324 "c:/mcc18/h/pconfig.h"
#line 9390 "c:/mcc18/h/pconfig.h"
#line 9456 "c:/mcc18/h/pconfig.h"
#line 9522 "c:/mcc18/h/pconfig.h"
#line 9588 "c:/mcc18/h/pconfig.h"
#line 9654 "c:/mcc18/h/pconfig.h"
#line 9720 "c:/mcc18/h/pconfig.h"
#line 9786 "c:/mcc18/h/pconfig.h"
#line 9852 "c:/mcc18/h/pconfig.h"
#line 9918 "c:/mcc18/h/pconfig.h"
#line 9984 "c:/mcc18/h/pconfig.h"
#line 10050 "c:/mcc18/h/pconfig.h"
#line 10116 "c:/mcc18/h/pconfig.h"
#line 10182 "c:/mcc18/h/pconfig.h"
#line 10248 "c:/mcc18/h/pconfig.h"
#line 10314 "c:/mcc18/h/pconfig.h"
#line 10380 "c:/mcc18/h/pconfig.h"
#line 10446 "c:/mcc18/h/pconfig.h"
#line 10512 "c:/mcc18/h/pconfig.h"
#line 10578 "c:/mcc18/h/pconfig.h"
#line 10644 "c:/mcc18/h/pconfig.h"
#line 10710 "c:/mcc18/h/pconfig.h"
#line 10776 "c:/mcc18/h/pconfig.h"
#line 10842 "c:/mcc18/h/pconfig.h"
#line 10908 "c:/mcc18/h/pconfig.h"
#line 10974 "c:/mcc18/h/pconfig.h"
#line 11040 "c:/mcc18/h/pconfig.h"
#line 11106 "c:/mcc18/h/pconfig.h"
#line 11172 "c:/mcc18/h/pconfig.h"
#line 11238 "c:/mcc18/h/pconfig.h"
#line 11304 "c:/mcc18/h/pconfig.h"
#line 11370 "c:/mcc18/h/pconfig.h"
#line 11436 "c:/mcc18/h/pconfig.h"
#line 11502 "c:/mcc18/h/pconfig.h"
#line 11568 "c:/mcc18/h/pconfig.h"
#line 11634 "c:/mcc18/h/pconfig.h"
#line 11700 "c:/mcc18/h/pconfig.h"
#line 11766 "c:/mcc18/h/pconfig.h"
#line 11832 "c:/mcc18/h/pconfig.h"
#line 11898 "c:/mcc18/h/pconfig.h"
#line 11964 "c:/mcc18/h/pconfig.h"
#line 12030 "c:/mcc18/h/pconfig.h"
#line 12096 "c:/mcc18/h/pconfig.h"
#line 12162 "c:/mcc18/h/pconfig.h"
#line 12228 "c:/mcc18/h/pconfig.h"
#line 12294 "c:/mcc18/h/pconfig.h"
#line 12360 "c:/mcc18/h/pconfig.h"
#line 12426 "c:/mcc18/h/pconfig.h"
#line 12492 "c:/mcc18/h/pconfig.h"
#line 12558 "c:/mcc18/h/pconfig.h"
#line 12624 "c:/mcc18/h/pconfig.h"
#line 12690 "c:/mcc18/h/pconfig.h"
#line 12756 "c:/mcc18/h/pconfig.h"
#line 12822 "c:/mcc18/h/pconfig.h"
#line 12888 "c:/mcc18/h/pconfig.h"
#line 12954 "c:/mcc18/h/pconfig.h"
#line 13020 "c:/mcc18/h/pconfig.h"
#line 13086 "c:/mcc18/h/pconfig.h"
#line 13152 "c:/mcc18/h/pconfig.h"
#line 13218 "c:/mcc18/h/pconfig.h"
#line 13284 "c:/mcc18/h/pconfig.h"
#line 13350 "c:/mcc18/h/pconfig.h"
#line 13416 "c:/mcc18/h/pconfig.h"
#line 13482 "c:/mcc18/h/pconfig.h"
#line 13548 "c:/mcc18/h/pconfig.h"
#line 13614 "c:/mcc18/h/pconfig.h"
#line 13680 "c:/mcc18/h/pconfig.h"
#line 13746 "c:/mcc18/h/pconfig.h"
#line 13812 "c:/mcc18/h/pconfig.h"
#line 13878 "c:/mcc18/h/pconfig.h"
#line 13944 "c:/mcc18/h/pconfig.h"
#line 14010 "c:/mcc18/h/pconfig.h"
#line 14076 "c:/mcc18/h/pconfig.h"
#line 14142 "c:/mcc18/h/pconfig.h"
#line 14208 "c:/mcc18/h/pconfig.h"
#line 14274 "c:/mcc18/h/pconfig.h"
#line 14340 "c:/mcc18/h/pconfig.h"
#line 14406 "c:/mcc18/h/pconfig.h"
#line 14472 "c:/mcc18/h/pconfig.h"
#line 14538 "c:/mcc18/h/pconfig.h"
#line 14604 "c:/mcc18/h/pconfig.h"
#line 14670 "c:/mcc18/h/pconfig.h"
#line 14736 "c:/mcc18/h/pconfig.h"
#line 14802 "c:/mcc18/h/pconfig.h"

#line 14804 "c:/mcc18/h/pconfig.h"




 
 
 

#line 14838 "c:/mcc18/h/pconfig.h"
 
 


#line 14843 "c:/mcc18/h/pconfig.h"

#line 14845 "c:/mcc18/h/pconfig.h"
#line 14846 "c:/mcc18/h/pconfig.h"
#line 14847 "c:/mcc18/h/pconfig.h"


#line 14858 "c:/mcc18/h/pconfig.h"
#line 14859 "c:/mcc18/h/pconfig.h"
#line 14860 "c:/mcc18/h/pconfig.h"
#line 14861 "c:/mcc18/h/pconfig.h"


#line 14881 "c:/mcc18/h/pconfig.h"
#line 14882 "c:/mcc18/h/pconfig.h"
#line 14883 "c:/mcc18/h/pconfig.h"

#line 14888 "c:/mcc18/h/pconfig.h"
#line 14889 "c:/mcc18/h/pconfig.h"
#line 14891 "c:/mcc18/h/pconfig.h"
#line 14892 "c:/mcc18/h/pconfig.h"

#line 14894 "c:/mcc18/h/pconfig.h"
#line 14899 "c:/mcc18/h/pconfig.h"

#line 14901 "c:/mcc18/h/pconfig.h"
#line 14904 "c:/mcc18/h/pconfig.h"

#line 14906 "c:/mcc18/h/pconfig.h"
#line 14911 "c:/mcc18/h/pconfig.h"

#line 14913 "c:/mcc18/h/pconfig.h"
#line 14917 "c:/mcc18/h/pconfig.h"


#line 14925 "c:/mcc18/h/pconfig.h"
#line 14926 "c:/mcc18/h/pconfig.h"
#line 14927 "c:/mcc18/h/pconfig.h"
#line 14928 "c:/mcc18/h/pconfig.h"
#line 14929 "c:/mcc18/h/pconfig.h"
#line 14930 "c:/mcc18/h/pconfig.h"
#line 14931 "c:/mcc18/h/pconfig.h"


#line 14933 "c:/mcc18/h/pconfig.h"
#line 14934 "c:/mcc18/h/pconfig.h"
#line 14938 "c:/mcc18/h/pconfig.h"


#line 14940 "c:/mcc18/h/pconfig.h"
#line 14941 "c:/mcc18/h/pconfig.h"
#line 14948 "c:/mcc18/h/pconfig.h"

#line 14950 "c:/mcc18/h/pconfig.h"
#line 14955 "c:/mcc18/h/pconfig.h"


#line 14962 "c:/mcc18/h/pconfig.h"
#line 14963 "c:/mcc18/h/pconfig.h"

#line 14966 "c:/mcc18/h/pconfig.h"
#line 14967 "c:/mcc18/h/pconfig.h"
#line 14969 "c:/mcc18/h/pconfig.h"
#line 14970 "c:/mcc18/h/pconfig.h"


#line 14974 "c:/mcc18/h/pconfig.h"
#line 14975 "c:/mcc18/h/pconfig.h"
#line 14979 "c:/mcc18/h/pconfig.h"
#line 14981 "c:/mcc18/h/pconfig.h"
#line 14982 "c:/mcc18/h/pconfig.h"


#line 14986 "c:/mcc18/h/pconfig.h"
#line 14987 "c:/mcc18/h/pconfig.h"
#line 14989 "c:/mcc18/h/pconfig.h"
	
#line 14991 "c:/mcc18/h/pconfig.h"
#line 14993 "c:/mcc18/h/pconfig.h"


#line 14998 "c:/mcc18/h/pconfig.h"
#line 14999 "c:/mcc18/h/pconfig.h"
#line 15005 "c:/mcc18/h/pconfig.h"


#line 15007 "c:/mcc18/h/pconfig.h"
#line 15008 "c:/mcc18/h/pconfig.h"
#line 15016 "c:/mcc18/h/pconfig.h"

#line 15018 "c:/mcc18/h/pconfig.h"
#line 15027 "c:/mcc18/h/pconfig.h"

#line 15029 "c:/mcc18/h/pconfig.h"
#line 15036 "c:/mcc18/h/pconfig.h"

#line 15038 "c:/mcc18/h/pconfig.h"
#line 15046 "c:/mcc18/h/pconfig.h"


#line 15048 "c:/mcc18/h/pconfig.h"
#line 15049 "c:/mcc18/h/pconfig.h"
#line 15059 "c:/mcc18/h/pconfig.h"

#line 15061 "c:/mcc18/h/pconfig.h"
#line 15067 "c:/mcc18/h/pconfig.h"

#line 15069 "c:/mcc18/h/pconfig.h"
#line 15074 "c:/mcc18/h/pconfig.h"


#line 15078 "c:/mcc18/h/pconfig.h"
#line 15079 "c:/mcc18/h/pconfig.h"
#line 15089 "c:/mcc18/h/pconfig.h"
#line 15091 "c:/mcc18/h/pconfig.h"

#line 15092 "c:/mcc18/h/pconfig.h"
#line 15093 "c:/mcc18/h/pconfig.h"
#line 15095 "c:/mcc18/h/pconfig.h"
#line 15096 "c:/mcc18/h/pconfig.h"

#line 15098 "c:/mcc18/h/pconfig.h"
#line 15109 "c:/mcc18/h/pconfig.h"


#line 15111 "c:/mcc18/h/pconfig.h"
#line 15112 "c:/mcc18/h/pconfig.h"
#line 15115 "c:/mcc18/h/pconfig.h"


#line 15122 "c:/mcc18/h/pconfig.h"
#line 15123 "c:/mcc18/h/pconfig.h"
#line 15128 "c:/mcc18/h/pconfig.h"


#line 15130 "c:/mcc18/h/pconfig.h"
#line 15131 "c:/mcc18/h/pconfig.h"
#line 15134 "c:/mcc18/h/pconfig.h"


#line 15136 "c:/mcc18/h/pconfig.h"
#line 15137 "c:/mcc18/h/pconfig.h"
#line 15142 "c:/mcc18/h/pconfig.h"
#line 15145 "c:/mcc18/h/pconfig.h"
#line 15146 "c:/mcc18/h/pconfig.h"


#line 15148 "c:/mcc18/h/pconfig.h"
#line 15149 "c:/mcc18/h/pconfig.h"
#line 15156 "c:/mcc18/h/pconfig.h"
#line 15158 "c:/mcc18/h/pconfig.h"

#line 15159 "c:/mcc18/h/pconfig.h"
#line 15160 "c:/mcc18/h/pconfig.h"
#line 15164 "c:/mcc18/h/pconfig.h"
#line 15165 "c:/mcc18/h/pconfig.h"


#line 15170 "c:/mcc18/h/pconfig.h"
#line 15171 "c:/mcc18/h/pconfig.h"
#line 15181 "c:/mcc18/h/pconfig.h"

#line 15183 "c:/mcc18/h/pconfig.h"
#line 15189 "c:/mcc18/h/pconfig.h"

#line 15191 "c:/mcc18/h/pconfig.h"
#line 15198 "c:/mcc18/h/pconfig.h"

#line 15200 "c:/mcc18/h/pconfig.h"
#line 15208 "c:/mcc18/h/pconfig.h"

#line 15210 "c:/mcc18/h/pconfig.h"
#line 15220 "c:/mcc18/h/pconfig.h"


#line 15223 "c:/mcc18/h/pconfig.h"
#line 15224 "c:/mcc18/h/pconfig.h"

#line 15231 "c:/mcc18/h/pconfig.h"
#line 15232 "c:/mcc18/h/pconfig.h"
#line 15234 "c:/mcc18/h/pconfig.h"
#line 15235 "c:/mcc18/h/pconfig.h"


#line 15238 "c:/mcc18/h/pconfig.h"
#line 15239 "c:/mcc18/h/pconfig.h"
#line 15245 "c:/mcc18/h/pconfig.h"


#line 15247 "c:/mcc18/h/pconfig.h"
#line 15248 "c:/mcc18/h/pconfig.h"
#line 15252 "c:/mcc18/h/pconfig.h"


#line 15254 "c:/mcc18/h/pconfig.h"
#line 15255 "c:/mcc18/h/pconfig.h"
#line 15259 "c:/mcc18/h/pconfig.h"

#line 15261 "c:/mcc18/h/pconfig.h"
#line 32 "c:/mcc18/h/adc.h"




#line 40 "c:/mcc18/h/adc.h"
 
#line 42 "c:/mcc18/h/adc.h"


#line 48 "c:/mcc18/h/adc.h"
 
#line 50 "c:/mcc18/h/adc.h"



#line 54 "c:/mcc18/h/adc.h"
#line 55 "c:/mcc18/h/adc.h"



#line 59 "c:/mcc18/h/adc.h"
#line 60 "c:/mcc18/h/adc.h"
#line 61 "c:/mcc18/h/adc.h"
#line 62 "c:/mcc18/h/adc.h"
#line 63 "c:/mcc18/h/adc.h"
#line 64 "c:/mcc18/h/adc.h"
#line 65 "c:/mcc18/h/adc.h"


#line 68 "c:/mcc18/h/adc.h"
#line 69 "c:/mcc18/h/adc.h"
#line 70 "c:/mcc18/h/adc.h"
#line 71 "c:/mcc18/h/adc.h"
#line 72 "c:/mcc18/h/adc.h"
#line 73 "c:/mcc18/h/adc.h"
#line 74 "c:/mcc18/h/adc.h"
#line 75 "c:/mcc18/h/adc.h"


#line 78 "c:/mcc18/h/adc.h"
#line 79 "c:/mcc18/h/adc.h"

#line 81 "c:/mcc18/h/adc.h"
#line 107 "c:/mcc18/h/adc.h"

#line 109 "c:/mcc18/h/adc.h"



#line 113 "c:/mcc18/h/adc.h"
#line 114 "c:/mcc18/h/adc.h"
#line 122 "c:/mcc18/h/adc.h"
#line 129 "c:/mcc18/h/adc.h"
#line 131 "c:/mcc18/h/adc.h"




#line 136 "c:/mcc18/h/adc.h"
#line 137 "c:/mcc18/h/adc.h"
#line 138 "c:/mcc18/h/adc.h"
#line 143 "c:/mcc18/h/adc.h"


#line 146 "c:/mcc18/h/adc.h"



#line 150 "c:/mcc18/h/adc.h"
#line 151 "c:/mcc18/h/adc.h"
#line 152 "c:/mcc18/h/adc.h"
#line 153 "c:/mcc18/h/adc.h"
#line 154 "c:/mcc18/h/adc.h"
#line 155 "c:/mcc18/h/adc.h"
#line 156 "c:/mcc18/h/adc.h"
#line 157 "c:/mcc18/h/adc.h"
#line 158 "c:/mcc18/h/adc.h"
#line 159 "c:/mcc18/h/adc.h"
#line 160 "c:/mcc18/h/adc.h"
#line 161 "c:/mcc18/h/adc.h"
#line 162 "c:/mcc18/h/adc.h"
#line 163 "c:/mcc18/h/adc.h"
#line 164 "c:/mcc18/h/adc.h"
#line 165 "c:/mcc18/h/adc.h"
#line 183 "c:/mcc18/h/adc.h"

#line 185 "c:/mcc18/h/adc.h"
#line 206 "c:/mcc18/h/adc.h"
#line 207 "c:/mcc18/h/adc.h"
#line 226 "c:/mcc18/h/adc.h"
#line 228 "c:/mcc18/h/adc.h"
#line 230 "c:/mcc18/h/adc.h"
#line 242 "c:/mcc18/h/adc.h"
#line 251 "c:/mcc18/h/adc.h"
#line 259 "c:/mcc18/h/adc.h"
#line 262 "c:/mcc18/h/adc.h"
#line 284 "c:/mcc18/h/adc.h"
#line 302 "c:/mcc18/h/adc.h"
#line 306 "c:/mcc18/h/adc.h"
#line 308 "c:/mcc18/h/adc.h"


#line 311 "c:/mcc18/h/adc.h"
#line 386 "c:/mcc18/h/adc.h"
#line 469 "c:/mcc18/h/adc.h"
#line 471 "c:/mcc18/h/adc.h"


#line 474 "c:/mcc18/h/adc.h"
#line 475 "c:/mcc18/h/adc.h"


#line 478 "c:/mcc18/h/adc.h"
#line 479 "c:/mcc18/h/adc.h"
#line 480 "c:/mcc18/h/adc.h"
#line 481 "c:/mcc18/h/adc.h"
#line 482 "c:/mcc18/h/adc.h"
#line 483 "c:/mcc18/h/adc.h"
#line 484 "c:/mcc18/h/adc.h"
#line 485 "c:/mcc18/h/adc.h"
#line 486 "c:/mcc18/h/adc.h"
#line 487 "c:/mcc18/h/adc.h"
#line 488 "c:/mcc18/h/adc.h"
#line 489 "c:/mcc18/h/adc.h"
#line 490 "c:/mcc18/h/adc.h"
#line 491 "c:/mcc18/h/adc.h"
#line 495 "c:/mcc18/h/adc.h"
#line 496 "c:/mcc18/h/adc.h"
#line 497 "c:/mcc18/h/adc.h"
#line 498 "c:/mcc18/h/adc.h"
#line 499 "c:/mcc18/h/adc.h"

#line 501 "c:/mcc18/h/adc.h"
#line 517 "c:/mcc18/h/adc.h"
#line 522 "c:/mcc18/h/adc.h"
#line 524 "c:/mcc18/h/adc.h"
#line 529 "c:/mcc18/h/adc.h"
#line 531 "c:/mcc18/h/adc.h"
#line 532 "c:/mcc18/h/adc.h"

#line 534 "c:/mcc18/h/adc.h"
#line 560 "c:/mcc18/h/adc.h"
#line 583 "c:/mcc18/h/adc.h"
#line 585 "c:/mcc18/h/adc.h"

#line 587 "c:/mcc18/h/adc.h"
#line 593 "c:/mcc18/h/adc.h"
#line 598 "c:/mcc18/h/adc.h"
#line 600 "c:/mcc18/h/adc.h"


#line 603 "c:/mcc18/h/adc.h"
#line 619 "c:/mcc18/h/adc.h"
#line 624 "c:/mcc18/h/adc.h"
#line 629 "c:/mcc18/h/adc.h"
#line 636 "c:/mcc18/h/adc.h"
#line 640 "c:/mcc18/h/adc.h"
#line 655 "c:/mcc18/h/adc.h"
#line 660 "c:/mcc18/h/adc.h"
#line 665 "c:/mcc18/h/adc.h"
#line 672 "c:/mcc18/h/adc.h"
#line 677 "c:/mcc18/h/adc.h"
#line 685 "c:/mcc18/h/adc.h"
#line 692 "c:/mcc18/h/adc.h"
#line 706 "c:/mcc18/h/adc.h"
#line 717 "c:/mcc18/h/adc.h"
#line 728 "c:/mcc18/h/adc.h"
#line 739 "c:/mcc18/h/adc.h"
#line 769 "c:/mcc18/h/adc.h"
#line 778 "c:/mcc18/h/adc.h"
#line 790 "c:/mcc18/h/adc.h"
#line 799 "c:/mcc18/h/adc.h"
#line 804 "c:/mcc18/h/adc.h"

 
union ADCResult
{
	int lr;			
 	char br[2];		
};

char BusyADC (void);

void ConvertADC (void);

int ReadADC(void);

void CloseADC(void);


#line 822 "c:/mcc18/h/adc.h"

void OpenADC ( unsigned char ,
               unsigned char );


#line 827 "c:/mcc18/h/adc.h"
#line 828 "c:/mcc18/h/adc.h"
#line 834 "c:/mcc18/h/adc.h"
#line 840 "c:/mcc18/h/adc.h"
#line 847 "c:/mcc18/h/adc.h"
#line 852 "c:/mcc18/h/adc.h"

 

#line 857 "c:/mcc18/h/adc.h"
#line 858 "c:/mcc18/h/adc.h"
void SetChanADC(unsigned char );
#line 860 "c:/mcc18/h/adc.h"

void SelChanConvADC( unsigned char );




#line 867 "c:/mcc18/h/adc.h"

#line 873 "c:/mcc18/h/adc.h"

#line 881 "c:/mcc18/h/adc.h"
#line 885 "c:/mcc18/h/adc.h"


#line 888 "c:/mcc18/h/adc.h"

#line 894 "c:/mcc18/h/adc.h"

#line 902 "c:/mcc18/h/adc.h"
#line 907 "c:/mcc18/h/adc.h"

#line 913 "c:/mcc18/h/adc.h"

#line 921 "c:/mcc18/h/adc.h"
#line 925 "c:/mcc18/h/adc.h"

#line 931 "c:/mcc18/h/adc.h"

#line 939 "c:/mcc18/h/adc.h"
#line 943 "c:/mcc18/h/adc.h"


#line 946 "c:/mcc18/h/adc.h"

#line 962 "c:/mcc18/h/adc.h"

#line 970 "c:/mcc18/h/adc.h"

#line 978 "c:/mcc18/h/adc.h"

#line 986 "c:/mcc18/h/adc.h"

#line 994 "c:/mcc18/h/adc.h"
#line 998 "c:/mcc18/h/adc.h"

#line 1000 "c:/mcc18/h/adc.h"

#line 1014 "c:/mcc18/h/adc.h"

#line 1022 "c:/mcc18/h/adc.h"

#line 1030 "c:/mcc18/h/adc.h"

#line 1038 "c:/mcc18/h/adc.h"

#line 1046 "c:/mcc18/h/adc.h"
#line 1050 "c:/mcc18/h/adc.h"


  
#line 1054 "c:/mcc18/h/adc.h"
#line 1073 "c:/mcc18/h/adc.h"


#line 1077 "c:/mcc18/h/adc.h"
#line 1078 "c:/mcc18/h/adc.h"
#line 1084 "c:/mcc18/h/adc.h"
#line 1090 "c:/mcc18/h/adc.h"

#line 1092 "c:/mcc18/h/adc.h"
#line 6 "main.c"



mID canTxMessage;
mID canRxMessage;
unsigned char random=0;


 
ECAN1MSGBUF ecan1msgBuf __attribute__((space(dma),aligned(4 *16)));

void __attribute__ ((interrupt, no_auto_psv)) _U2RXInterrupt(void)
{
	char a;
	a=U2RXREG;
	U2TXREG=a;
	__builtin_btg((unsigned int*)&LATE,0x02);
	IFS1bits.U2RXIF = 0;
}

void __attribute__ ((interrupt, no_auto_psv)) _U2TXInterrupt(void)
{
	IFS1bits.U2TXIF = 0;
	__builtin_btg((unsigned int*)&LATE,0x03);
}

void __attribute__ ((interrupt, no_auto_psv)) _U1TXInterrupt(void)
{
	IFS0bits.U1TXIF = 0;
	__builtin_btg((unsigned int*)&LATE,0x00);
}

void __attribute__ ((interrupt, no_auto_psv)) _U1RXInterrupt(void)
{
	char a;
	a=U1RXREG;
	U1TXREG=a;
	__builtin_btg((unsigned int*)&LATE,0x01);
	IFS0bits.U1RXIF = 0;
}

 
void __attribute__((__interrupt__, __shadow__)) _T2Interrupt(void)
{
	 
	__builtin_btg((unsigned int*)&LATE,0x04);
	IFS0bits.T2IF = 0; 
}
	
 
void __attribute__((__interrupt__, __shadow__)) _T3Interrupt(void)
{
	
	IFS0bits.T3IF = 0; 
	__builtin_btg((unsigned int*)&LATE,0x05);
}


void __attribute__((interrupt,no_auto_psv))_C1Interrupt(void)  
{
	      	 
    if(C1INTFbits.RBIF)
    {
	     
	    if(C1RXFUL1bits.RXFUL1)
	    {			
			 
			canRxMessage.buffer_status=0x05 ;
			canRxMessage.buffer=1;	
		}		
		 
		else if(C1RXFUL1bits.RXFUL2)
		{
			 
			canRxMessage.buffer_status=0x05 ;
			canRxMessage.buffer=2;					
		}
		 
		else if(C1RXFUL1bits.RXFUL3)
		{
			 
			canRxMessage.buffer_status=0x05 ;
			canRxMessage.buffer=3;					
		}
		else;
		 
		C1INTFbits.RBIF = 0;
	}
	else if(C1INTFbits.TBIF)
    {
	   sendECAN(&canTxMessage);
	     
		C1INTFbits.TBIF = 0;	    
	}
	else;
	
	 
	IFS2bits.C1IF=0;
}


void make_canmesg()
{
	 
	canTxMessage.message_type=0x01 ;
	
	canTxMessage.frame_type=0x03 ;
	
	canTxMessage.buffer=0;
	canTxMessage.id=0x123;
	canTxMessage.data[0]=random;
	canTxMessage.data[1]=random;
	canTxMessage.data[2]=random;
	canTxMessage.data[3]=random;
	canTxMessage.data[4]=random;
	canTxMessage.data[5]=random;
	canTxMessage.data[6]=random;
	canTxMessage.data[7]=random;
	canTxMessage.data_length=8;
}

int main(void)
{
	
	init();
	LATE=0x000A;

	make_canmesg();

	 
	sendECAN(&canTxMessage);
	
	while(1)
	{	
	__builtin_btg((unsigned int*)&LATE,0x07);
	make_canmesg();
	random+=11;
	}	
	
}	

