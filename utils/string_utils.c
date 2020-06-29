#include <string.h>
#include <stdlib.h>

#include "string_utils.h"

char *dupstr(const char *s) {
    char *const result = malloc(strlen(s) + 1);
    if (result != NULL) strcpy(result, s);
    return result;
}
