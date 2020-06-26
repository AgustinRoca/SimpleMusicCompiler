%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define CHUNK 10

int yylex();
void yyerror(char ** result, const char *s);
double semitones(int qty);
void indent(char * s, int n);
void addToInts(char * s);
void addToDoubles(char * s);
void addToNotes(char * s);
void addToIntArrays(char * s);
void addToDoubleArrays(char * s);
void addToNoteArrays(char * s);
void freeVars(void);

int yydebug=1;
int tab_qty=0;

char ** int_vars = NULL;
size_t int_vars_length = 0;
char ** double_vars = NULL;
size_t double_vars_length = 0;
char ** note_vars = NULL;
size_t note_vars_length = 0;
char ** int_array_vars = NULL;
size_t int_array_vars_length = 0;
char ** double_array_vars = NULL;
size_t double_array_vars_length = 0;
char ** note_array_vars = NULL;
size_t note_array_vars_length = 0;
%}

%union
{
    int integer;
    float decimal;
    char *string;
}

%token BPM INTEGER DOUBLE BOOL_OP VOLUME NOTE_T NOTE INT_T DOUBLE_T NEW_ID WHILE PLAY DURING LENGTH INT_VAR DOUBLE_VAR NOTE_VAR INT_ARRAY_VAR DOUBLE_ARRAY_VAR NOTE_ARRAY_VAR
%parse-param {char **result}

%%
S                   : SET_BPM VOL LINE {*result = (char*)malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3)+ 3); sprintf(*result,"%s\n%s\n%s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}

SET_BPM             : BPM INT_STRING ';' {$<string>$ = malloc(21 + strlen($<string>2)); sprintf($<string>$, "length_of_beat = 60/%s", $<string>2); free($<string>1); free($<string>2)}

VOL                 : VOLUME NUMBER ';' {$<string>$ = malloc(10 + strlen($<string>2)); sprintf($<string>$, "volume = %s", $<string>2); free($<string>1); free($<string>2)}

NUMBER              : INT_STRING {$<string>$ = $<string>1}
                    | DOUBLE_STRING {$<string>$ = $<string>1}

PLAY_FUNC           : PLAY NOTE_VAL DURING NUMBER {$<string>$ = malloc(strlen($<string>2) + 48 + strlen($<string>4)); sprintf($<string>$, "B1 = add_sound(B1, %s, length_of_beat * %s, volume)", $<string>2, $<string>4);  free($<string>1); free($<string>2); free($<string>3); free($<string>4)}

LENGTH_FUNC         : LENGTH '(' ARRAY ')' {$<string>$ = malloc(strlen($<string>3) + 6);sprintf($<string>$, "len(%s)", $<string>3); free($<string>1); free($<string>3)}
                    | LENGTH '(' ARRAY_VAR ')' {$<string>$ = malloc(strlen($<string>3) + 6); sprintf($<string>$, "len(%s)", $<string>3);  free($<string>1); free($<string>3)}

ARRAY               : INT_ARRAY {$<string>$ = $<string>1}
                    | DOUBLE_ARRAY {$<string>$ = $<string>1}
                    | NOTE_ARRAY {$<string>$ = $<string>1}

ARRAY_VAR           : NUMBER_ARRAY_VAR {$<string>$ = $<string>1}
                    | NOTE_ARRAY_VAR {$<string>$ = $<string>1}

NUMBER_ARRAY_VAR    : INT_ARRAY_VAR {$<string>$ = $<string>1}
                    | DOUBLE_ARRAY_VAR {$<string>$ = $<string>1}

NUMBER_VAR          : INT_VAR {$<string>$ = $<string>1}
                    | DOUBLE_VAR {$<string>$ = $<string>1}

NOTE_ARRAY          : '[' NOTE_LIST ']' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "[%s]", $<string>2); free($<string>2)}

NOTE_LIST           : NOTE_VAL ',' NOTE_LIST {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 2); sprintf($<string>$, "%s,%s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_VAL {$<string>$ = $<string>1}

INT_ARRAY           : '[' INT_LIST ']' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "[%s]", $<string>2); free($<string>2)}

INT_LIST            : INT_STRING ',' INT_LIST {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 2); sprintf($<string>$, "%s, %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | INT_STRING {$<string>$ = $<string>1}

DOUBLE_ARRAY        : '[' DOUBLE_LIST ']' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "[%s]", $<string>2); free($<string>2)}

DOUBLE_LIST         : DOUBLE_STRING ',' DOUBLE_LIST {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 2); sprintf($<string>$, "%s, %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | DOUBLE_STRING {$<string>$ = $<string>1}
                
WHILE_LOOP          : WHILE '(' BOOLEAN_VAL ')' OPEN_BRACKET LINE CLOSE_BRACKET {$<string>$ = malloc(strlen($<string>3) +  strlen($<string>6) + 15);sprintf($<string>$, "while %s:\n%s", $<string>3, $<string>6); free($<string>1); free($<string>3); free($<string>6);}

OPEN_BRACKET        : '{' {tab_qty++}
CLOSE_BRACKET       : '}' {tab_qty--;}

EXPRESION           : ASSIGNATION {$<string>$ = $<string>1}
                    | NOTE_VAL {$<string>$ = $<string>1}
                    | NUMBER {$<string>$ = $<string>1}

INT_ASSIGNATION     : INT_T NEW_ID '=' INT_STRING {addToInts($<string>2); $<string>$ = malloc(strlen($<string>2) + strlen($<string>4) + 4); sprintf($<string>$, "%s = %s", $<string>2, $<string>4); free($<string>1); free($<string>2); free($<string>4)}; 
                    | INT_VAR '=' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s = %s", $<string>1, $<string>3); free($<string>1); free($<string>3)};

DOUBLE_ASSIGNATION  : DOUBLE_T NEW_ID '=' DOUBLE_STRING {addToDoubles($<string>2); $<string>$ = malloc(strlen($<string>2) + strlen($<string>4) + 4); sprintf($<string>$, "%s = %s", $<string>2, $<string>4); free($<string>1); free($<string>2); free($<string>4)}; 
                    | DOUBLE_VAR '=' DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s = %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}; 


NOTE_ASSIGNATION    : NOTE_T NEW_ID '=' NOTE_VAL {addToNotes($<string>2); $<string>$ = malloc(strlen($<string>2) + strlen($<string>4) + 4); sprintf($<string>$, "%s = %s", $<string>2, $<string>4); free($<string>1); free($<string>2); free($<string>4);}
                    | NOTE_VAR '=' NOTE_VAL {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s = %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}


ASSIGNATION         : NOTE_T '[' ']' NEW_ID '=' NOTE_ARRAY {addToNoteArrays($<string>4); $<string>$ = malloc(strlen($<string>4) + strlen($<string>6) + 4);sprintf($<string>$, "%s = %s", $<string>4, $<string>6); free($<string>4); free($<string>6)}
                    | INT_T '[' ']' NEW_ID '=' INT_ARRAY {addToIntArrays($<string>4); $<string>$ = malloc(strlen($<string>4) + strlen($<string>6) + 4);sprintf($<string>$, "%s = %s", $<string>4, $<string>6); free($<string>4); free($<string>6)}
                    | DOUBLE_T '[' ']' NEW_ID '=' DOUBLE_ARRAY {addToDoubleArrays($<string>4); $<string>$ = malloc(strlen($<string>4) + strlen($<string>6) + 4);sprintf($<string>$, "%s = %s", $<string>4, $<string>6); free($<string>4); free($<string>6)}
                    | NUMBER_VAR'+' '+' {$<string>$ = malloc(2*strlen($<string>1) + 8);sprintf($<string>$, "%s = %s + 1", $<string>1, $<string>1); free($<string>1)}
                    | NUMBER_VAR '-' '-' {$<string>$ = malloc(2*strlen($<string>1) + 8);sprintf($<string>$, "%s = %s - 1", $<string>1, $<string>1); free($<string>1)}
                    | NUMBER_VAR '*' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | NUMBER_VAR '/' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s / (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | NUMBER_VAR '+' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s + (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | NUMBER_VAR '-' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | DOUBLE_VAR '*' '=' DOUBLE_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | DOUBLE_VAR '/' '=' DOUBLE_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s / (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | DOUBLE_VAR '+' '=' DOUBLE_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s + (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | DOUBLE_VAR '-' '=' DOUBLE_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | NOTE_ASSIGNATION {$<string>$ = $<string>1}
                    | INT_ASSIGNATION {$<string>$ = $<string>1}
                    | DOUBLE_ASSIGNATION {$<string>$ = $<string>1}

INT_VAL             : INTEGER {$<integer>$ = $<integer>1}
                    | INT_VAL '+' INT_VAL {$<integer>$ = $<integer>1 + $<integer>3}
                    | INT_VAL '-' INT_VAL {$<integer>$ = $<integer>1 - $<integer>3}
                    | INT_VAL '*' INT_VAL {$<integer>$ = $<integer>1 * $<integer>3}
                    | INT_VAL '/' INT_VAL {$<integer>$ = $<integer>1 / $<integer>3}

INT_STRING          : INT_STRING '+' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | INT_STRING '-' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | INT_STRING '*' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s * %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | INT_STRING '/' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s / %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | INT_VAL {$<string>$ = malloc(20 + 1); sprintf($<string>$, "%d", $<integer>1)}
                    | LENGTH_FUNC {$<string>$ = $<string>1}
                    | INT_VAR {$<string>$ = $<string>1}


DOUBLE_VAL          : DOUBLE {$<decimal>$ = $<decimal>1}
                    | DOUBLE_VAL '+' DOUBLE_VAL {$<decimal>$ = $<decimal>1 + $<decimal>3}
                    | DOUBLE_VAL '-' DOUBLE_VAL {$<decimal>$ = $<decimal>1 - $<decimal>3}
                    | DOUBLE_VAL '*' DOUBLE_VAL {$<decimal>$ = $<decimal>1 * $<decimal>3}
                    | DOUBLE_VAL '/' DOUBLE_VAL {$<decimal>$ = $<decimal>1 / $<decimal>3}
                    | DOUBLE_VAL '+' INT_VAL {$<decimal>$ = $<decimal>1 + (double)$<integer>3}
                    | DOUBLE_VAL '-' INT_VAL {$<decimal>$ = $<decimal>1 - (double)$<integer>3}
                    | DOUBLE_VAL '*' INT_VAL {$<decimal>$ = $<decimal>1 * (double)$<integer>3}
                    | DOUBLE_VAL '/' INT_VAL {$<decimal>$ = $<decimal>1 / (double)$<integer>3}
                    | INT_VAL '+' DOUBLE_VAL {$<decimal>$ = (float)$<integer>1 + $<decimal>3}
                    | INT_VAL '-' DOUBLE_VAL {$<decimal>$ = (float)$<integer>1 - $<decimal>3}
                    | INT_VAL '*' DOUBLE_VAL {$<decimal>$ = (float)$<integer>1 * $<decimal>3}
                    | INT_VAL '/' DOUBLE_VAL {$<decimal>$ = (float)$<integer>1 / $<decimal>3}

DOUBLE_STRING       : DOUBLE_VAL {$<string>$ = malloc(20 + 1); sprintf($<string>$, "%f", $<decimal>1)}
                    | DOUBLE_VAR {$<string>$ = $<string>1}
                    | DOUBLE_STRING '+' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | DOUBLE_STRING '-' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | DOUBLE_STRING '*' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s * %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | DOUBLE_STRING '/' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s / %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | INT_STRING '+' DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | INT_STRING '-' DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | INT_STRING '*' DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s * %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | INT_STRING '/' DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s / %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}

NOTE_VAL            : NOTE {$<string>$ = malloc(20 + 3); sprintf($<string>$, "[%f]",$<decimal>1)}
                    | NOTE_ARRAY_VAR '[' INT_STRING ']' {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3);sprintf($<string>$, "%s[%s]", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_ARRAY_VAR '[' INT_ARRAY_VAR ']' {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3); sprintf($<string>$, "%s[%s]", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_VAL '+' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 30); sprintf($<string>$, "[A1 * semitones(%s) for A1 in %s]", $<string>3, $<string>1); free($<string>1); free($<string>3)}
                    | NOTE_VAL '+' INT_VAL {$<string>$ = malloc(strlen($<string>1) + 20 + 19); sprintf($<string>$, "[A1 * %f for A1 in %s]", semitones($<integer>3), $<string>1); free($<string>1)}
                    | NOTE_VAL '+' NOTE_VAL {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_VAL '-' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_VAL '-' NOTE_VAL {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_VAR {$<string>$ = $<string>1}

BOOLEAN_VAL         : NUMBER_VAR BOOL_OP INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}
                    | INT_STRING BOOL_OP NUMBER_VAR {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}
                    | INT_STRING BOOL_OP INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}
                    | NUMBER_VAR BOOL_OP DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}
                    | DOUBLE_STRING BOOL_OP NUMBER_VAR {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}
                    | DOUBLE_STRING BOOL_OP DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}

LINE                : EXPRESION ';' {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty); sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty); free($<string>1)}
                    | WHILE_LOOP {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty);sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty); free($<string>1)}
                    | PLAY_FUNC ';' {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty);sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty);free($<string>1)}
                    | SET_BPM   {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty);sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty);free($<string>1)}
                    | VOL  {$<string>$ = malloc(strlen($<string>1) + 2 + tab_qty);sprintf($<string>$, "%s\n", $<string>1); indent($<string>$, tab_qty);free($<string>1)}
                    | LINE LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 1 + tab_qty);sprintf($<string>$, "%s%s", $<string>1, $<string>2); free($<string>1); free($<string>2)}

%%

int yywrap()
{
    return 1;
} 

int main() {
    yydebug=1;
    char * result; // esta bien que no este inicializada, se inicializa en yyparse
    int error = yyparse(&result);
    if(error){
        return error;
    }
    FILE * outfile = fopen("out.py", "w");
    fprintf(outfile,"import numpy as np\n"
                    "import simpleaudio as sa\n"
                    "\n"
                    "def semitones(qty):\n"
                    "    return 2 ** (qty/12)\n"
                    "\n"
                    "sample_rate = 44100 # never change\n"
                    "\n"
                    "# generate sine wave notes\n"
                    "def play_note(freq, duration):\n"
                    "    t = np.linspace(0, duration, int(duration * sample_rate) , False) # lista de T*sample_rate numeros en el intervalo [0 a T)\n"
                    "    return np.sin(freq * t * 2 * np.pi)\n"
                    "\n"
                    "def add_sound(list, notes, duration, volume):\n"
                    "    return np.concatenate((list,sound(notes, duration, volume))) \n"
                    "\n"
                    "def sound(freqs, duration, volume):\n"
                    "    # start playback\n"
                    "    t = np.linspace(0, duration, int(duration * sample_rate) , False)\n"
                    "    final_sound = np.zeros(len(t))\n"
                    "    for freq in freqs:\n"
                    "        sound = play_note(freq, duration)\n"
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
                    "B1 = np.empty(0)\n"
                    "%s\n"
                    "play(B1)\n", result);
    fclose(outfile);
    free(result);
    freeVars();
    return 0;
}

void yyerror (char ** result, const char *s){
  printf ("%s\n", s);
  exit(1);
}

void indent(char* s, int n){
    for (int i = 0; i < n; i++){
        memmove(s + 1, s, strlen(s) + 1);
        memcpy(s, "\t", 1);
    }
}

void addToInts(char * s){
    if(int_vars_length % CHUNK == 0){
        int_vars = realloc(int_vars, sizeof(*int_vars) * (int_vars_length + CHUNK));
    }
    int_vars[int_vars_length++] = strdup(s);
}

void addToDoubles(char * s){
    if(double_vars_length % CHUNK == 0){
        double_vars = realloc(double_vars, sizeof(*double_vars) * (double_vars_length + CHUNK));
    }
    double_vars[double_vars_length++] = strdup(s);
}

void addToNotes(char * s){
    if(note_vars_length % CHUNK == 0){
        note_vars = realloc(note_vars, sizeof(*note_vars) * (note_vars_length + CHUNK));
    }
    note_vars[note_vars_length++] = strdup(s);
}

void addToIntArrays(char * s){
    if(int_array_vars_length % CHUNK == 0){
        int_array_vars = realloc(int_array_vars, sizeof(*int_array_vars) * (int_array_vars_length + CHUNK));
    }
    int_array_vars[int_array_vars_length++] = strdup(s);
}

void addToDoubleArrays(char * s){
    if(double_array_vars_length % CHUNK == 0){
        double_array_vars = realloc(double_array_vars, sizeof(*double_array_vars) * (double_array_vars_length + CHUNK));
    }
    double_array_vars[double_array_vars_length++] = strdup(s);
}

void addToNoteArrays(char * s){
    if(note_array_vars_length % CHUNK == 0){
        note_array_vars = realloc(note_array_vars, sizeof(*note_array_vars) * (note_array_vars_length + CHUNK));
    }
    note_array_vars[note_array_vars_length++] = strdup(s);
}

void freeVars(void){
    for(int i=0; i<int_vars_length; i++){
        free(int_vars[i]);
    }
    free(int_vars);
    for(int i=0; i<double_vars_length; i++){
        free(double_vars[i]);
    }
    free(double_vars);
    for(int i=0; i<note_vars_length; i++){
        free(note_vars[i]);
    }
    free(note_vars);
    for(int i=0; i<int_array_vars_length; i++){
        free(int_array_vars[i]);
    }
    free(int_array_vars);
    for(int i=0; i<double_array_vars_length; i++){
        free(double_array_vars[i]);
    }
    free(double_array_vars);
    for(int i=0; i<note_array_vars_length; i++){
        free(note_array_vars[i]);
    }
    free(note_array_vars);
}

uint8_t isInInts(char * s){
    for(int i=0; i<int_vars_length; i++){
        if(strcmp(int_vars[i], s) == 0){
            return 1;
        }
    }
    return 0;
}

uint8_t isInDoubles(char * s){
    for(int i=0; i<double_vars_length; i++){
        if(strcmp(double_vars[i], s) == 0){
            return 1;
        }
    }
    return 0;
}

uint8_t isInNotes(char * s){
    for(int i=0; i<note_vars_length; i++){
        if(strcmp(note_vars[i], s) == 0){
            return 1;
        }
    }
    return 0;
}

uint8_t isInIntArrays(char * s){
    for(int i=0; i<int_array_vars_length; i++){
        if(strcmp(int_array_vars[i], s) == 0){
            return 1;
        }
    }
    return 0;
}

uint8_t isInDoubleArrays(char * s){
    for(int i=0; i<double_array_vars_length; i++){
        if(strcmp(double_array_vars[i], s) == 0){
            return 1;
        }
    }
    return 0;
}

uint8_t isInNoteArrays(char * s){
    for(int i=0; i<note_array_vars_length; i++){
        if(strcmp(note_array_vars[i], s) == 0){
            return 1;
        }
    }
    return 0;
}

double semitones(int qty){
    return pow(2, qty/12.0);
}