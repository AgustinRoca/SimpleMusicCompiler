#ifndef __MUSIC_COMPILER_UTILS__
#define __MUSIC_COMPILER_UTILS__

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <ctype.h>


char * smallocf(const char * format, ...);
char * smallocfwd(const char * fmt, ...);

#endif