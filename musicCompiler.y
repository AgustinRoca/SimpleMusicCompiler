%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CHUNK 10

int yylex();
void yyerror(char ** result, const char *s);
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

SET_BPM             : BPM INT_STRING {$<string>$ = malloc(120 + 20); sprintf($<string>$, "length_of_beat = %s/60", $<string>2); free($<string>2)}

VOL                 : VOLUME NUMBER {$<string>$ = malloc(10 + strlen($<string>2)); sprintf($<string>$, "volume = %s", $<string>2); free($<string>2)}

NUMBER              : INT_STRING {$<string>$ = $<string>1}
                    | DOUBLE_STRING {$<string>$ = $<string>1}

PLAY_FUNC           : PLAY NOTE_VAL DURING INT_STRING {$<string>$ = malloc(strlen($<string>2) + 26 + strlen($<string>4)); sprintf($<string>$, "play([%s], length_of_beat * %s)", $<string>2, $<string>4); free($<string>2); free($<string>4)}
                    | PLAY NOTE_ARRAY DURING INT_STRING {$<string>$ = malloc(strlen($<string>2) + 26 + strlen($<string>4)); sprintf($<string>$, "play(%s, length_of_beat * %s)", $<string>2, $<string>4); free($<string>2); free($<string>4)}

LENGTH_FUNC         : LENGTH '(' ARRAY ')' {$<string>$ = malloc(strlen($<string>3) + 6);sprintf($<string>$, "len(%s)", $<string>3); free($<string>3)}
                    | LENGTH '(' ARRAY_VAR ')' {$<string>$ = malloc(strlen($<string>3) + 6); sprintf($<string>$, "len(%s)", $<string>3); free($<string>3)}

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
                
WHILE_LOOP          : WHILE '(' BOOLEAN_VAL ')' OPEN_BRACKET LINE CLOSE_BRACKET {$<string>$ = malloc(strlen($<string>3) +  strlen($<string>6) + 15);sprintf($<string>$, "while %s:\n%s", $<string>3, $<string>6); free($<string>3); free($<string>6)}

OPEN_BRACKET        : '{' {tab_qty++}
CLOSE_BRACKET       : '}' {tab_qty--}

EXPRESION           : ASSIGNATION {$<string>$ = $<string>1}
                    | NOTE_VAL {$<string>$ = $<string>1}
                    | NUMBER {$<string>$ = $<string>1}

INT_ASSIGNATION     : INT_T NEW_ID '=' INT_STRING {addToInts($<string>2); $<string>$ = malloc(strlen($<string>2) + strlen($<string>4) + 7); sprintf($<string>$, "int %s = %s", $<string>2, $<string>4); free($<string>2); free($<string>4)}; 
                    | INT_T NEW_ID '=' INT_VAR {addToInts($<string>2); $<string>$ = malloc(strlen($<string>2) + 20 + strlen($<string>4)); sprintf($<string>$, "int %s = %s", $<string>2, $<string>4); free($<string>2); free($<string>4)};

DOUBLE_ASSIGNATION  : DOUBLE_T NEW_ID '=' DOUBLE_STRING {addToDoubles($<string>2); $<string>$ = malloc(strlen($<string>2) + strlen($<string>4) + 11); sprintf($<string>$, "double %s = %s", $<string>2, $<string>4); free($<string>2); free($<string>4)}; 
                    | DOUBLE_T NEW_ID '=' DOUBLE_VAR {addToDoubles($<string>2); $<string>$ = malloc(strlen($<string>2) + strlen($<string>4) + 11); sprintf($<string>$, "double %s = %s", $<string>2, $<string>4); free($<string>2); free($<string>4)};

NOTE_ASSIGNATION    : NOTE_T NEW_ID '=' NOTE_VAL {addToNotes($<string>2); $<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + 9); sprintf($<string>$, "note %s = %s", $<string>1, $<string>2); free($<string>1); free($<string>2)}
                    | NOTE_T NEW_ID '=' NOTE_VAR {addToNotes($<string>2); $<string>$ = malloc(strlen($<string>2) + strlen($<string>4) + 9); sprintf($<string>$, "note %s = %s", $<string>2, $<string>4); free($<string>2); free($<string>4)};

ASSIGNATION         : NOTE_T '[' ']' NEW_ID '=' NOTE_ARRAY {addToNoteArrays($<string>4); $<string>$ = malloc(strlen($<string>4) + strlen($<string>6) + 11);sprintf($<string>$, "note[] %s = %s", $<string>4, $<string>6); free($<string>4); free($<string>6)}
                    | INT_T '[' ']' NEW_ID '=' INT_ARRAY {addToIntArrays($<string>4); $<string>$ = malloc(strlen($<string>4) + strlen($<string>6) + 10);sprintf($<string>$, "int[] %s = %s", $<string>4, $<string>6); free($<string>4); free($<string>6)}
                    | DOUBLE_T '[' ']' NEW_ID '=' DOUBLE_ARRAY {addToDoubleArrays($<string>4); $<string>$ = malloc(strlen($<string>4) + strlen($<string>6) + 10);sprintf($<string>$, "double[] %s = %s", $<string>4, $<string>6); free($<string>4); free($<string>6)}
                    | NUMBER_VAR'+' '+' {$<string>$ = malloc(2*strlen($<string>1) + 8);sprintf($<string>$, "%s = %s + 1", $<string>1, $<string>1); free($<string>1)}
                    | NUMBER_VAR '-' '-' {$<string>$ = malloc(2*strlen($<string>1) + 8);sprintf($<string>$, "%s = %s - 1", $<string>1, $<string>1); free($<string>1)}
                    | NUMBER_VAR '*' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | NUMBER_VAR '/' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s / (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | NUMBER_VAR '+' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s + (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | NUMBER_VAR '-' '=' INT_STRING {$<string>$ = malloc(2*strlen($<string>1) + 20 + 7);sprintf($<string>$, "%s = %s * (%s)", $<string>1, $<string>1, $<string>4); free($<string>1); free($<string>4)}
                    | NOTE_ASSIGNATION {$<string>$ = $<string>1}
                    | INT_ASSIGNATION {$<string>$ = $<string>1}
                    | DOUBLE_ASSIGNATION {$<string>$ = $<string>1}

INT_VAL             : INTEGER {$<integer>$ = $<integer>1}
                    | INT_VAL '+' INT_VAL {$<integer>$ = $<integer>1 + $<integer>3}
                    | INT_VAL '-' INT_VAL {$<integer>$ = $<integer>1 - $<integer>3}
                    | INT_VAL '*' INT_VAL {$<integer>$ = $<integer>1 * $<integer>3}
                    | INT_VAL '/' INT_VAL {$<integer>$ = $<integer>1 / $<integer>3}

INT_STRING          : INT_VAL {$<string>$ = malloc(20 + 1); sprintf($<string>$, "%d", $<integer>1)}
                    | LENGTH_FUNC {$<string>$ = $<string>1}
                    | INT_VAR {$<string>$ = $<string>1}

DOUBLE_VAL          : DOUBLE {$<decimal>$ = $<decimal>1}
                    | DOUBLE_VAL '+' DOUBLE_VAL {$<decimal>$ = $<decimal>1 + $<decimal>3}
                    | DOUBLE_VAL '-' DOUBLE_VAL {$<decimal>$ = $<decimal>1 - $<decimal>3}
                    | DOUBLE_VAL '*' DOUBLE_VAL {$<decimal>$ = $<decimal>1 * $<decimal>3}
                    | DOUBLE_VAL '/' DOUBLE_VAL {$<decimal>$ = $<decimal>1 / $<decimal>3}

DOUBLE_STRING       : DOUBLE_VAL {$<string>$ = malloc(20 + 1); sprintf($<string>$, "%f", $<decimal>1)}
                    | DOUBLE_VAR {$<string>$ = $<string>1}

NOTE_VAL            : NOTE {$<string>$ = $<string>1}
                    | NOTE_ARRAY_VAR '[' INT_STRING ']' {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3);sprintf($<string>$, "%s[%s]", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_ARRAY_VAR '[' INT_ARRAY_VAR ']' {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3); sprintf($<string>$, "%s[%s]", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_VAL '+' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) +4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_VAL '+' NOTE_VAL {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_VAL '-' INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) +4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_VAL '-' NOTE_VAL {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s - %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
                    | NOTE_VAR {$<string>$ = $<string>1}

BOOLEAN_VAL         : NUMBER_VAR BOOL_OP INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}
                    | INT_STRING BOOL_OP NUMBER_VAR {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}
                    | INT_STRING BOOL_OP INT_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}
                    | NUMBER_VAR BOOL_OP DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}
                    | DOUBLE_STRING BOOL_OP NUMBER_VAR {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}
                    | DOUBLE_STRING BOOL_OP DOUBLE_STRING {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3) + 3); sprintf($<string>$, "%s %s %s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}

LINE                : EXPRESION LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2 + tab_qty); sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); indent($<string>$, tab_qty); free($<string>1); free($<string>2)}
                    | WHILE_LOOP LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2 + tab_qty);sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); indent($<string>$, tab_qty); free($<string>1); free($<string>2)}
                    | PLAY_FUNC LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2 + tab_qty);sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); indent($<string>$, tab_qty);free($<string>1); free($<string>2)}
                    | EMPTY_LINE LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 1 + tab_qty);sprintf($<string>$, "%s%s", $<string>1, $<string>2); indent($<string>$, tab_qty); free($<string>1); free($<string>2)}
                    | EMPTY_LINE {$<string>$ = $<string>1}

EMPTY_LINE          : /** lambda **/{$<string>$ = strdup("")}
%%

int yywrap()
{
    return 1;
} 

int main() {
    yydebug=1;
    FILE * outfile = fopen("out.py", "w");
    char * result; // esta bien que no este inicializada, se inicializa en yyparse
    int error = yyparse(&result);
    if(error){
        return error;
    }
    fprintf(outfile,"import numpy as np\n"
                    "import simpleaudio as sa\n"
                    "import threading\n"
                    "import time\n"
                    "\n"
                    "# calculate note frequencies\n"
                    "A_freq = 440 # A4 (Hz)\n"
                    "\n"
                    "def freq(distance_from_a4):\n"
                    "    return A_freq * 2 ** (distance_from_a4/12)\n"
                    "\n"
                    "A4_freq = freq(0)\n"
                    "Ash4_freq = freq(1)\n"
                    "B4_freq = freq(2)\n"
                    "C4_freq = freq(-9)\n"
                    "Csh4_freq = freq(-20)\n"
                    "D4_freq = freq(-7)\n"
                    "Dsh4_freq = freq(-6)\n"
                    "E4_freq = freq(-5)\n"
                    "F4_freq = freq(-4)\n"
                    "Fsh4_freq = freq(-3)\n"
                    "G4_freq = freq(-2)\n"
                    "Gsh4_freq = freq(-1)\n"
                    "\n"
                    "sample_rate = 44100 # never change\n"
                    "\n"
                    "# generate sine wave notes\n"
                    "def note(freq, duration):\n"
                    "\tt = np.linspace(0, duration, int(duration * sample_rate) , False) # lista de T*sample_rate numeros en el intervalo [0 a T)\n"
                    "\treturn np.sin(freq * t * 2 * np.pi)\n"
                    "\n"
                    "def addnote(audio, from_index, freq, duration):\n"
                    "\tn = int(sample_rate * duration)\n"
                    "\taudio[from_index: from_index + n] += note(freq, duration)[from_index: from_index + n]\n"
                    "\n"
                    "def chord(freq1, freq2, freq3, duration, freq4=0):\n"
                    "\t# mix audio together\n"
                    "\taudio = np.zeros(int(sample_rate * duration))\n"
                    "\taddnote(audio, 0, freq1, duration)\n"
                    "\taddnote(audio, 0, freq2, duration)\n"
                    "\taddnote(audio, 0, freq3, duration)\n"
                    "\taddnote(audio, 0, freq4, duration)\n"
                    "\n"
                    "\t# normalize to 16-bit range\n"
                    "\taudio *= 32767 / np.max(np.abs(audio))\n"
                    "\treturn audio\n"
                    "\n"
                    "def play(chords, volume):\n"
                    "\t# start playback\n"
                    "\tn = 0\n"
                    "\tfor chord in chords:\n"
                    "\t\tn+= len(chord)\n"
                    "\tfinal_sound = np.zeros(n)\n"
                    "\toffset = 0\n"
                    "\tfor chord in chords:\n"
                    "\t\tchord_with_volume = chord*volume[offset: offset + len(chord)]\n"
                    "\t\tfinal_sound[offset : offset + len(chord_with_volume)] = chord_with_volume[0:len(chord_with_volume)]\n"
                    "\t\toffset += len(chord)\n"
                    "\tplay_obj = sa.play_buffer(final_sound.astype(np.int16), 2, 2, sample_rate)\n"
                    "\n"
                    "\t# wait for playback to finish before exiting\n"
                    "\tplay_obj.wait_done()\n"
                    "\treturn\n\n%s\n", result);
    free(result);
    fclose(outfile);
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
        int_vars = realloc(int_vars, sizeof(*int_vars) * int_vars_length);
    }
    int_vars[int_vars_length++] = strdup(s);
}

void addToDoubles(char * s){
    if(double_vars_length % CHUNK == 0){
        double_vars = realloc(double_vars, sizeof(*double_vars) * double_vars_length);
    }
    double_vars[double_vars_length++] = strdup(s);
}

void addToNotes(char * s){
    if(note_vars_length % CHUNK == 0){
        note_vars = realloc(note_vars, sizeof(*note_vars) * note_vars_length);
    }
    note_vars[note_vars_length++] = strdup(s);
}

void addToIntArrays(char * s){
    if(int_array_vars_length % CHUNK == 0){
        int_array_vars = realloc(int_array_vars, sizeof(*int_array_vars) * int_array_vars_length);
    }
    int_array_vars[int_array_vars_length++] = strdup(s);
}

void addToDoubleArrays(char * s){
    if(double_array_vars_length % CHUNK == 0){
        double_array_vars = realloc(double_array_vars, sizeof(*double_array_vars) * double_array_vars_length);
    }
    double_array_vars[double_array_vars_length++] = strdup(s);
}

void addToNoteArrays(char * s){
    if(note_array_vars_length % CHUNK == 0){
        note_array_vars = realloc(note_array_vars, sizeof(*note_array_vars) * note_array_vars_length);
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
        if(strcmp(int_vars[i], yylval.string) == 0){
            return 1;
        }
    }
    return 0;
}

uint8_t isInDoubles(char * s){
    for(int i=0; i<double_vars_length; i++){
        if(strcmp(double_vars[i], yylval.string) == 0){
            return 1;
        }
    }
    return 0;
}

uint8_t isInNotes(char * s){
    for(int i=0; i<note_vars_length; i++){
        if(strcmp(note_vars[i], yylval.string) == 0){
            return 1;
        }
    }
    return 0;
}

uint8_t isInIntArrays(char * s){
    for(int i=0; i<int_array_vars_length; i++){
        if(strcmp(int_array_vars[i], yylval.string) == 0){
            return 1;
        }
    }
    return 0;
}

uint8_t isInDoubleArrays(char * s){
    for(int i=0; i<double_array_vars_length; i++){
        if(strcmp(double_array_vars[i], yylval.string) == 0){
            return 1;
        }
    }
    return 0;
}

uint8_t isInNoteArrays(char * s){
    for(int i=0; i<note_array_vars_length; i++){
        if(strcmp(note_array_vars[i], yylval.string) == 0){
            return 1;
        }
    }
    return 0;
}