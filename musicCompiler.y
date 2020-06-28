%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>

#include "utils/sorted_hashmap.h"
#include "utils/variable_types.h"

#define CHUNK 10

const variable_type_t variable_type_int = variable_type_int_;
const variable_type_t variable_type_double = variable_type_double_;
const variable_type_t variable_type_note = variable_type_note_;
const variable_type_t variable_type_int_array = variable_type_int_array_;
const variable_type_t variable_type_double_array = variable_type_double_array_;
const variable_type_t variable_type_note_array = variable_type_note_array_;

int yylex();
void yylex_destroy();
void yyerror(char ** result, const char *s);
double semitones(int qty);
void indent(char * s, int n);
void addToInts(char * s);
void addToDoubles(char * s);
void addToNotes(char * s);
void addToIntArrays(char * s);
void addToDoubleArrays(char * s);
void addToNoteArrays(char * s);
void addThread(char * s);
int isNewThread(char * s);
void freeVars(void);
char * init_threads();
char * thread_list();
void freeThreads();
char * closing_parenthesis_threads();

hash_t vars_hasher_hasher(void *key);
int8_t vars_hasher_cmp(void *k1, void *k2);
void vars_hasher_freer(void *key, void *value);

int yydebug=1;
int tab_qty=0;

sorted_hashmap_t vars_hashmap = NULL;

//char ** int_vars = NULL;
//size_t int_vars_length = 0;
//char ** double_vars = NULL;
//size_t double_vars_length = 0;
//char ** note_vars = NULL;
//size_t note_vars_length = 0;
//char ** int_array_vars = NULL;
//size_t int_array_vars_length = 0;
//char ** double_array_vars = NULL;
//size_t double_array_vars_length = 0;
//char ** note_array_vars = NULL;
//size_t note_array_vars_length = 0;

char ** threads = NULL;
size_t threads_length = 0;
%}

%union
{
    int integer;
    float decimal;
    char *string;
}

%left BOOL_OP
%left '+' '-' 
%left '*' '/'

%token BPM INTEGER DOUBLE VOLUME NOTE_T NOTE INT_T DOUBLE_T NEW_ID WHILE PLAY DURING LENGTH INT_VAR DOUBLE_VAR NOTE_VAR INT_ARRAY_VAR DOUBLE_ARRAY_VAR NOTE_ARRAY_VAR AS GUITAR PIANO IN THREAD IF
%parse-param {char **result}

%%
S                   : SET_BPM VOL LINE {*result = (char*)malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3)+ 3); sprintf(*result,"%s\n%s\n%s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3);}

SET_BPM             : BPM INT_STRING ';' {$<string>$ = malloc(21 + strlen($<string>2)); sprintf($<string>$, "length_of_beat = 60/%s", $<string>2); free($<string>1); free($<string>2);}

VOL                 : VOLUME NUMBER ';' {$<string>$ = malloc(10 + strlen($<string>2)); sprintf($<string>$, "volume = %s", $<string>2); free($<string>1); free($<string>2);}

NUMBER              : INT_STRING {$<string>$ = $<string>1;}
                    | DOUBLE_STRING {$<string>$ = $<string>1;}

PLAY_FUNC           : PLAY NOTE_VAL DURING NUMBER {$<string>$ = malloc(strlen($<string>2) + 74 + strlen($<string>4)); sprintf($<string>$, "thread_0 = np.concatenate((thread_0, sound(%s, length_of_beat * %s, volume)))", $<string>2, $<string>4);  free($<string>1); free($<string>2); free($<string>3); free($<string>4);}
                    | PLAY NOTE_VAL DURING NUMBER AS PIANO {$<string>$ = malloc(strlen($<string>2) + 74 + strlen($<string>4)); sprintf($<string>$, "thread_0 = np.concatenate((thread_0,sound(%s, length_of_beat * %s, volume)))", $<string>2, $<string>4);  free($<string>1); free($<string>2); free($<string>3); free($<string>4); free($<string>5); free($<string>6);}
                    | PLAY NOTE_VAL DURING NUMBER AS GUITAR {$<string>$ = malloc(strlen($<string>2) + 74 + 6 + strlen($<string>4)); sprintf($<string>$, "thread_0 = np.concatenate((thread_0,sound(%s, length_of_beat * %s, volume, True)))", $<string>2, $<string>4);  free($<string>1); free($<string>2); free($<string>3); free($<string>4); free($<string>5); free($<string>6);}
                    | PLAY NOTE_VAL DURING NUMBER IN THREAD {addThread($<string>6); $<string>$ = malloc(2* strlen($<string>6) + strlen($<string>2) + 58 + strlen($<string>4)); sprintf($<string>$, "%s = np.concatenate((%s, sound(%s, length_of_beat * %s, volume)))", $<string>6, $<string>6, $<string>2, $<string>4);  free($<string>1); free($<string>2); free($<string>3); free($<string>4); free($<string>5); free($<string>6);}
                    | PLAY NOTE_VAL DURING NUMBER AS PIANO IN THREAD {addThread($<string>8); $<string>$ = malloc(2* strlen($<string>8) + strlen($<string>2) + 58 + strlen($<string>4)); sprintf($<string>$, "%s = np.concatenate((%s, sound(%s, length_of_beat * %s, volume)))", $<string>8, $<string>8, $<string>2, $<string>4);  free($<string>1); free($<string>2); free($<string>3); free($<string>4); free($<string>5); free($<string>6); free($<string>7); free($<string>8);}
                    | PLAY NOTE_VAL DURING NUMBER AS GUITAR IN THREAD {addThread($<string>8); $<string>$ = malloc(2* strlen($<string>8) + strlen($<string>2) + 58 + 6 + strlen($<string>4)); sprintf($<string>$, "%s = np.concatenate((%s, sound(%s, length_of_beat * %s, volume, True)))", $<string>8, $<string>8, $<string>2, $<string>4);  free($<string>1); free($<string>2); free($<string>3); free($<string>4); free($<string>5); free($<string>6); free($<string>7); free($<string>8);}

LENGTH_FUNC         : LENGTH '(' ARRAY ')' {$<string>$ = malloc(strlen($<string>3) + 6);sprintf($<string>$, "len(%s)", $<string>3); free($<string>1); free($<string>3);}
                    | LENGTH '(' ARRAY_VAR ')' {$<string>$ = malloc(strlen($<string>3) + 6); sprintf($<string>$, "len(%s)", $<string>3);  free($<string>1); free($<string>3);}

ARRAY               : INT_ARRAY {$<string>$ = $<string>1;}
                    | DOUBLE_ARRAY {$<string>$ = $<string>1;}
                    | NOTE_ARRAY {$<string>$ = $<string>1;}

ARRAY_VAR           : NUMBER_ARRAY_VAR {$<string>$ = $<string>1;}
                    | NOTE_ARRAY_VAR {$<string>$ = $<string>1;}

NUMBER_ARRAY_VAR    : INT_ARRAY_VAR {$<string>$ = $<string>1;}
                    | DOUBLE_ARRAY_VAR {$<string>$ = $<string>1;}

NOTE_ARRAY          : '[' NOTE_LIST ']' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "[%s]", $<string>2); free($<string>2);}

NOTE_LIST           : NOTE_VAL ',' NOTE_LIST {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3); sprintf($<string>$, "%s,%s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | NOTE_VAL {$<string>$ = $<string>1;}

INT_ARRAY           : '[' INT_LIST ']' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "[%s]", $<string>2); free($<string>2);}

INT_LIST            : INT_STRING ',' INT_LIST {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3); sprintf($<string>$, "%s, %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | INT_STRING {$<string>$ = $<string>1;}

DOUBLE_ARRAY        : '[' DOUBLE_LIST ']' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "[%s]", $<string>2); free($<string>2);}

DOUBLE_LIST         : DOUBLE_STRING ',' DOUBLE_LIST {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3); sprintf($<string>$, "%s, %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | DOUBLE_STRING {$<string>$ = $<string>1;}

IF_BLOCK            : IF '(' BOOLEAN_VAL ')' OPEN_BRACKET LINE CLOSE_BRACKET {$<string>$ = malloc(strlen($<string>3) +  strlen($<string>6) + 9);sprintf($<string>$, "if %s:\n%s", $<string>3, $<string>6); free($<string>1); free($<string>3); free($<string>6);}

WHILE_LOOP          : WHILE '(' BOOLEAN_VAL ')' OPEN_BRACKET LINE CLOSE_BRACKET {$<string>$ = malloc(strlen($<string>3) +  strlen($<string>6) + 9);sprintf($<string>$, "while %s:\n%s", $<string>3, $<string>6); free($<string>1); free($<string>3); free($<string>6);}

OPEN_BRACKET        : '{' {tab_qty++;}
CLOSE_BRACKET       : '}' {tab_qty--;}

EXPRESION           : ASSIGNATION {$<string>$ = $<string>1;}
                    | NOTE_VAL {$<string>$ = $<string>1;}
                    | NUMBER {$<string>$ = $<string>1;}

INT_ASSIGNATION     : INT_T NEW_ID '=' INT_STRING {addToInts($<string>2); $<string>$ = malloc(strlen($<string>2) + strlen($<string>4) + 4); sprintf($<string>$, "%s = %s", $<string>2, $<string>4); free($<string>1); free($<string>2); free($<string>4);}; 
                    | INT_VAR '=' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s = %s", $<string>1, $<string>3); free($<string>1); free($<string>3);};

DOUBLE_ASSIGNATION  : DOUBLE_T NEW_ID '=' DOUBLE_STRING {addToDoubles($<string>2); $<string>$ = malloc(strlen($<string>2) + strlen($<string>4) + 4); sprintf($<string>$, "%s = %s", $<string>2, $<string>4); free($<string>1); free($<string>2); free($<string>4);}; 
                    | DOUBLE_VAR '=' DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s = %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}; 


NOTE_ASSIGNATION    : NOTE_T NEW_ID '=' NOTE_VAL {addToNotes($<string>2); $<string>$ = malloc(strlen($<string>2) + strlen($<string>4) + 4); sprintf($<string>$, "%s = %s", $<string>2, $<string>4); free($<string>1); free($<string>2); free($<string>4);}
                    | NOTE_VAR '=' NOTE_VAL {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s = %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}

INT_A_ASSIGNATION   : INT_T '[' ']' NEW_ID '=' INT_ARRAY {addToIntArrays($<string>4); $<string>$ = malloc(strlen($<string>4) + strlen($<string>6) + 4);sprintf($<string>$, "%s = %s", $<string>4, $<string>6); free($<string>1); free($<string>4); free($<string>6);}
                    | INT_ARRAY_VAR '=' INT_ARRAY {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s = %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}

DOUBLE_A_ASSIGNATION: DOUBLE_T '[' ']' NEW_ID '=' DOUBLE_ARRAY {addToDoubleArrays($<string>4); $<string>$ = malloc(strlen($<string>4) + strlen($<string>6) + 4);sprintf($<string>$, "%s = %s", $<string>4, $<string>6); free($<string>1); free($<string>4); free($<string>6);}
                    | DOUBLE_ARRAY_VAR '=' DOUBLE_ARRAY {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s = %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}

NOTE_A_ASSIGNATION  : NOTE_T '[' ']' NEW_ID '=' NOTE_ARRAY {addToNoteArrays($<string>4); $<string>$ = malloc(strlen($<string>4) + strlen($<string>6) + 4);sprintf($<string>$, "%s = %s", $<string>4, $<string>6); free($<string>1); free($<string>4); free($<string>6);}
                    | NOTE_ARRAY_VAR '=' NOTE_ARRAY {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s = %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}


ASSIGNATION         : INT_VAR '+' '+' {$<string>$ = malloc(2*strlen($<string>1) + 8);sprintf($<string>$, "%s = %s + 1", $<string>1, $<string>1); free($<string>1);}
                    | INT_VAR '-' '-' {$<string>$ = malloc(2*strlen($<string>1) + 8);sprintf($<string>$, "%s = %s - 1", $<string>1, $<string>1); free($<string>1);}
                    | INT_VAR '*' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | INT_VAR '/' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s / (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | INT_VAR '+' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s + (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | INT_VAR '-' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | DOUBLE_VAR'+' '+' {$<string>$ = malloc(2*strlen($<string>1) + 8);sprintf($<string>$, "%s = %s + 1", $<string>1, $<string>1); free($<string>1);}
                    | DOUBLE_VAR '-' '-' {$<string>$ = malloc(2*strlen($<string>1) + 8);sprintf($<string>$, "%s = %s - 1", $<string>1, $<string>1); free($<string>1);}
                    | DOUBLE_VAR '*' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | DOUBLE_VAR '/' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s / (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | DOUBLE_VAR '+' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s + (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | DOUBLE_VAR '-' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | DOUBLE_VAR '*' '=' DOUBLE_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | DOUBLE_VAR '/' '=' DOUBLE_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s / (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | DOUBLE_VAR '+' '=' DOUBLE_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s + (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | DOUBLE_VAR '-' '=' DOUBLE_STRING {$<string>$ = malloc(2*strlen($<string>1) + strlen($<string>4) + 9);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4);}
                    | NOTE_A_ASSIGNATION {$<string>$ = $<string>1;}
                    | INT_A_ASSIGNATION {$<string>$ = $<string>1;}
                    | DOUBLE_A_ASSIGNATION {$<string>$ = $<string>1;}
                    | NOTE_ASSIGNATION {$<string>$ = $<string>1;}
                    | INT_ASSIGNATION {$<string>$ = $<string>1;}
                    | DOUBLE_ASSIGNATION {$<string>$ = $<string>1;}

INT_VAL             : INTEGER {$<integer>$ = $<integer>1;}
                    | INT_VAL '+' INT_VAL {$<integer>$ = $<integer>1 + $<integer>3;}
                    | INT_VAL '-' INT_VAL {$<integer>$ = $<integer>1 - $<integer>3;}
                    | INT_VAL '*' INT_VAL {$<integer>$ = $<integer>1 * $<integer>3;}
                    | INT_VAL '/' INT_VAL {$<integer>$ = $<integer>1 / $<integer>3;}

INT_STRING          : INT_STRING '+' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | INT_STRING '-' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | INT_STRING '*' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s * %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | INT_STRING '/' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s / %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | INT_ARRAY_VAR '[' INT_STRING ']' {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3); sprintf($<string>$, "%s[%s]", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | INT_VAL {$<string>$ = malloc(20 + 1); sprintf($<string>$, "%d", $<integer>1);}
                    | LENGTH_FUNC {$<string>$ = $<string>1;}
                    | INT_VAR {$<string>$ = $<string>1;}
                    | '(' INT_STRING ')' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "(%s)", $<string>2); free($<string>2);}



DOUBLE_VAL          : DOUBLE {$<decimal>$ = $<decimal>1;}
                    | DOUBLE_VAL '+' DOUBLE_VAL {$<decimal>$ = $<decimal>1 + $<decimal>3;}
                    | DOUBLE_VAL '-' DOUBLE_VAL {$<decimal>$ = $<decimal>1 - $<decimal>3;}
                    | DOUBLE_VAL '*' DOUBLE_VAL {$<decimal>$ = $<decimal>1 * $<decimal>3;}
                    | DOUBLE_VAL '/' DOUBLE_VAL {$<decimal>$ = $<decimal>1 / $<decimal>3;}
                    | DOUBLE_VAL '+' INT_VAL {$<decimal>$ = $<decimal>1 + (double)$<integer>3;}
                    | DOUBLE_VAL '-' INT_VAL {$<decimal>$ = $<decimal>1 - (double)$<integer>3;}
                    | DOUBLE_VAL '*' INT_VAL {$<decimal>$ = $<decimal>1 * (double)$<integer>3;}
                    | DOUBLE_VAL '/' INT_VAL {$<decimal>$ = $<decimal>1 / (double)$<integer>3;}
                    | INT_VAL '+' DOUBLE_VAL {$<decimal>$ = (float)$<integer>1 + $<decimal>3;}
                    | INT_VAL '-' DOUBLE_VAL {$<decimal>$ = (float)$<integer>1 - $<decimal>3;}
                    | INT_VAL '*' DOUBLE_VAL {$<decimal>$ = (float)$<integer>1 * $<decimal>3;}
                    | INT_VAL '/' DOUBLE_VAL {$<decimal>$ = (float)$<integer>1 / $<decimal>3;}

DOUBLE_STRING       : DOUBLE_VAL {$<string>$ = malloc(20 + 1); sprintf($<string>$, "%f", $<decimal>1);}
                    | DOUBLE_VAR {$<string>$ = $<string>1;}
                    | DOUBLE_ARRAY_VAR '[' INT_STRING ']' {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3); sprintf($<string>$, "%s[%s]", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | DOUBLE_STRING '+' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | DOUBLE_STRING '-' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | DOUBLE_STRING '*' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s * %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | DOUBLE_STRING '/' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s / %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | INT_STRING '+' DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | INT_STRING '-' DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | INT_STRING '*' DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s * %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | INT_STRING '/' DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s / %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | '(' DOUBLE_STRING ')' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "(%s)", $<string>2); free($<string>2);}

NOTE_VAL            : NOTE {$<string>$ = malloc(20 + 3); sprintf($<string>$, "[%f]",$<decimal>1);}
                    | NOTE_ARRAY_VAR '[' INT_STRING ']' {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3);sprintf($<string>$, "%s[%s]", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | NOTE_ARRAY_VAR '[' INT_ARRAY_VAR ']' {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3); sprintf($<string>$, "%s[%s]", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | NOTE_VAL '+' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 30); sprintf($<string>$, "[A1 * semitones(%s) for A1 in %s]", $<string>3, $<string>1); free($<string>1); free($<string>3);}
                    | NOTE_VAL '+' NOTE_VAL {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | NOTE_VAL '-' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | NOTE_VAL '-' NOTE_VAL {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3);}
                    | NOTE_VAR {$<string>$ = $<string>1;}
                    | '(' NOTE_VAL ')' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "(%s)", $<string>2); free($<string>2);}


BOOLEAN_VAL         : INT_STRING BOOL_OP INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3);}
                    | DOUBLE_STRING BOOL_OP INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3);}
                    | INT_STRING BOOL_OP DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3);}
                    | DOUBLE_STRING BOOL_OP DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3);}
                    | '(' BOOLEAN_VAL ')' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "(%s)", $<string>2); free($<string>2);}

LINE                : LINE_P LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 1 + tab_qty);sprintf($<string>$, "%s%s", $<string>1, $<string>2); free($<string>1); free($<string>2);}
                    | LINE_P {$<string>$ = $<string>1;}

LINE_P              : EXPRESION ';' {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty); sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty); free($<string>1);}
                    | WHILE_LOOP {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty);sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty); free($<string>1);}
                    | IF_BLOCK {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty);sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty); free($<string>1);}
                    | PLAY_FUNC ';' {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty);sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty);free($<string>1);}
                    | SET_BPM   {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty);sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty);free($<string>1);}
                    | VOL  {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty);sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty);free($<string>1);}

%%


int yywrap()
{
    return 1;
}

int main() {
    yydebug=1;
    char * result; // esta bien que no este inicializada, se inicializa en yyparse
    vars_hashmap = sorted_hashmap_create();
    if (vars_hashmap == NULL) {
        return -1;
    }

    sorted_hashmap_set_hasher(vars_hashmap, vars_hasher_hasher);
    sorted_hashmap_set_cmp(vars_hashmap, vars_hasher_cmp);
    sorted_hashmap_set_freer(vars_hashmap, vars_hasher_freer);

    addThread("thread_0"); // Es el thread por default
    int error = yyparse(&result);
    if(error){
        freeThreads();
        return error;
    }
    FILE * outfile = fopen("out.py", "w");
    char * initThreads = init_threads();
    char * threadList = thread_list();
    char * closingParenthesisThreads = closing_parenthesis_threads();

    fprintf(outfile,"from operator import add\n"
                    "import numpy as np\n"
                    "import simpleaudio as sa\n"
                    "\n"
                    "def semitones(qty):\n"
                    "    return 2 ** (qty/12)\n"
                    "\n"
                    "sample_rate = 44100 # never change\n"
                    "\n"
                    "def karplus_strong(wavetable, n_samples, stretch_factor=2):\n"
                    "    samples = []\n"
                    "    current_sample = 0\n"
                    "    previous_value = 0\n"
                    "    while len(samples) < n_samples:\n"
                    "        r = np.random.binomial(1, 1 - 1/stretch_factor)\n"
                    "        if r == 0:\n"
                    "            wavetable[current_sample] = 0.5 * (wavetable[current_sample] + previous_value)\n"
                    "        samples.append(wavetable[current_sample])\n"
                    "        previous_value = samples[-1]\n"
                    "        current_sample += 1\n"
                    "        current_sample = current_sample %% wavetable.size\n"
                    "    return np.array(samples)\n"
                    "    \n"
                    "# generate sine wave notes\n"
                    "def play_note(freq, duration, guitar):\n"
                    "    if(guitar):\n"
                    "        wavetable_size = sample_rate // int(freq)\n"
                    "        wavetable = (2 * np.random.randint(0, 2, wavetable_size) - 1).astype(np.float)\n"
                    "        notes = karplus_strong(wavetable, int(duration*sample_rate))\n"
                    "    else:\n"
                    "        offset=0.188\n"
                    "        t = np.linspace(offset, offset+duration, int(duration * sample_rate) , False) # lista de T*sample_rate numeros en el intervalo [0 a T)\n"
                    "        notes = np.sin(2*np.pi*t*freq)\n"
                    "        notes **= 3\n"
                    "        t2 = np.linspace(offset+2/3, offset+duration+2/3, int(duration * sample_rate) , False) # lista de T*sample_rate numeros en el intervalo [0 a T)\n"
                    "        notes += np.sin(2*np.pi*t2)\n"
                    "        t3 = np.linspace(0, duration, int(duration * sample_rate) , False)\n"
                    "        notes *= 1.05 * np.e **(-0.0004 * 2 * np.pi * t3 * freq)\n"
                    "    return notes\n"
                    "\n"
                    "def sound(freqs, duration, volume, guitar=False):\n"
                    "    if(duration == 0):\n"
                    "        return np.zeros(1)\n"
                    "    # start playback\n"
                    "    t = np.linspace(0, duration, int(duration * sample_rate) , False)\n"
                    "    final_sound = np.zeros(len(t))\n"
                    "    for freq in freqs:\n"
                    "        sound = play_note(freq, duration, guitar)\n"
                    "        final_sound[0:len(sound)] += sound[0:len(sound)]\n"
                    "    final_sound *= 32767 / np.max(np.abs(final_sound))\n"
                    "    final_sound *= volume\n"
                    "    return final_sound\n"
                    "\n"
                    "def play(list):\n"
                    "    play_obj = sa.play_buffer(list.astype(np.int16), 1, 2, sample_rate)\n"
                    "    # wait for playback to finish before exiting\n"
                    "    play_obj.wait_done()\n"
                    "    return\n"
                    "\n"
                    "%s\n"
                    "%s\n"
                    "play(np.asarray(list(map(add, %s, np.zeros(len(thread_0))))%s\n", initThreads, result, threadList, closingParenthesisThreads);
    fclose(outfile);
    free(result);
    free(initThreads);
    free(threadList);
    free(closingParenthesisThreads);
    freeVars();
    freeThreads();
    yylex_destroy();
    return 0;
}

void yyerror (char ** result, const char *s){
    printf ("%s\n", s);
    exit(1);
}

/* Agrega n tabs al principio de s */
void indent(char* s, int n){ 
    for (int i = 0; i < n; i++){
        memmove(s + 1, s, strlen(s) + 1);
        memcpy(s, "\t", 1);
    }
}

void addToInts(char * s){
    sorted_hashmap_add(vars_hashmap, strdup(s), &variable_type_int);
}

void addToDoubles(char * s){
    sorted_hashmap_add(vars_hashmap, strdup(s), &variable_type_double);
}

void addToNotes(char * s){
    sorted_hashmap_add(vars_hashmap, strdup(s), &variable_type_note);
}

void addToIntArrays(char * s){
    sorted_hashmap_add(vars_hashmap, strdup(s), &variable_type_int_array);
}

void addToDoubleArrays(char * s){
    sorted_hashmap_add(vars_hashmap, strdup(s), &variable_type_double_array);
}

void addToNoteArrays(char * s){
    sorted_hashmap_add(vars_hashmap, strdup(s), &variable_type_note_array);
}

void freeVars(void){
    sorted_hashmap_free(vars_hashmap);
}

variable_type_t getVarType(char * s){
    sorted_hashmap_node node = sorted_hashmap_find(vars_hashmap, s);
    return node != NULL ? *((variable_type_t*) sorted_hashmap_get_element(node)) : variable_type_invalid_;
}

void addThread(char * s){
    if(isNewThread(s)){
        if(threads_length % CHUNK == 0){
            threads = realloc(threads, sizeof(*threads) * (threads_length + CHUNK));
        }
        threads[threads_length++] = strdup(s);
    }
}

int isNewThread(char * s){
    for(int i=0; i<threads_length; i++){
        if(strcmp(threads[i], s) == 0){
            return 0;
        }
    }
    return 1;
}

char * init_threads(){
    int threads_names_lengths = 0;
    for(int i=0; i<threads_length; i++){
        threads_names_lengths += strlen(threads[i]);
    }
    char * ans = malloc(sizeof(*ans) * (threads_names_lengths + threads_length * 6 + 1));
    int ans_current_length = 0;
    for(int i=0; i<threads_length; i++){
        sprintf(ans + ans_current_length, "%s = []\n", threads[i]);
        ans_current_length += strlen(threads[i]) + 6;
    }
    return ans;
}

char * thread_list(){
    int threads_names_lengths = 0;
    for(int i=0; i<threads_length; i++){
        threads_names_lengths += strlen(threads[i]);
    }
    char * ans = malloc(sizeof(*ans) * (threads_names_lengths + (threads_length - 1)* 16 + 1));
    int ans_current_length = 0;
    sprintf(ans, "%s", threads[0]);
    ans_current_length += strlen(threads[0]);
    for(int i=1; i<threads_length; i++){
        sprintf(ans + ans_current_length, ", list(map(add, %s", threads[i]);
        ans_current_length += strlen(threads[i]) + 17;
    }
    return ans;
}

void freeThreads(){
    for(int i=0; i<threads_length; i++){
        free(threads[i]);
    }
    free(threads);
}

char * closing_parenthesis_threads(){
    char * ans = malloc((2*threads_length + 1) * sizeof(*ans));
    for(int i=0; i<2*threads_length; i+=2){
        ans[i] = ')';
        ans[i+1] = ')';
    }
    ans[2*threads_length] = '\0';
    return ans;
}

hash_t vars_hasher_hasher(void *key) {
    const char *s = key;

    /** See https://stackoverflow.com/a/7666577 */
    hash_t hash = GENERIC_INITIAL_HASH_VALUE;
    uint8_t c;
    while ((c = *s++)) hash = ((hash << GENERIC_SHIFT_HASH_VALUE) + hash) + c; /* hash * 33 + c */

    return hash;
}

int8_t vars_hasher_cmp(void *k1, void *k2) {
    return strcmp((char *) k1, (char *) k2);
}

void vars_hasher_freer(void *key, void *value) {
    free(key);
}
