%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(char ** result, const char *s);
void indent(char * s, int n);

int yydebug=1;
int tab_qty=0;
%}

%union
{
    int number;
    float decimal;
    char *string;
}

%token BPM NUM VOLUME NOTE_T NOTE INT_T ID WHILE PLAY DURING LENGTH
%parse-param {char **result}

%%
    
S           : SET_BPM VOL LINE {*result = (char*)malloc(strlen($<string>1) + strlen($<string>2) + strlen($<string>3)+ 3); sprintf(*result,"%s\n%s\n%s", $<string>1, $<string>2, $<string>3); free($<string>1); free($<string>2); free($<string>3)}

SET_BPM     : BPM NUM {$<string>$ = malloc(120 + 20); sprintf($<string>$, "length_of_beat = %f", $<decimal>2/60)}

VOL         : VOLUME NUM {$<string>$ = malloc(10 + 20); sprintf($<string>$, "volume = %f", $<decimal>2)}

OPEN_BRACKET    : '{' {tab_qty++}
CLOSE_BRACKET    : '}' {tab_qty--}

WHILE_LOOP  : WHILE '(' CONDITION ')' OPEN_BRACKET BODY CLOSE_BRACKET {$<string>$ = malloc(strlen($<string>3) +  strlen($<string>6) + 15);sprintf($<string>$, "while %s:\n%s", $<string>3, $<string>6); free($<string>3); free($<string>6)}

BODY        : BODY_LINE {$<string>$ = $<string>1}

PLAY_FUNC   : PLAY NOTE_VAL DURING NUM {$<string>$ = malloc(strlen($<string>2) + 11 + 20); sprintf($<string>$, "play([%s], %f)", $<string>2, $<decimal>4); free($<string>2)}

LENGTH_FUNC : LENGTH '(' NOTE_ARRAY ')' {$<string>$ = malloc(strlen($<string>3) + 6);sprintf($<string>$, "len(%s)", $<string>3); free($<string>3)}
            | LENGTH '(' ID ')' {$<string>$ = malloc(strlen($<string>3) + 6); sprintf($<string>$, "len(%s)", $<string>3); free($<string>3)}

EXPRESION   : ASSIGNATION {$<string>$ = $<string>1}
            | CONDITION {$<string>$ = $<string>1}
            | NOTE_VAL {$<string>$ = $<string>1}
            | NUM {$<string>$ = malloc(9);sprintf($<string>$, "%f", $<decimal>1)}
            | LENGTH_FUNC {$<string>$ = $<string>1}

CONDITION   : ID '>' NUM {$<string>$ = malloc(strlen($<string>1) + 20 + 4); sprintf($<string>$, "%s > %f", $<string>1, $<decimal>3); free($<string>1)}
            | NUM '>' ID {$<string>$ =malloc(strlen($<string>3) + 20 + 4); sprintf($<string>$, "%f > %s", $<decimal>1, $<string>3); free($<string>3)}
            | NUM '>' NUM {$<string>$ = malloc(4); sprintf($<string>$, "%d", $<decimal>1 > $<decimal>3)}

ASSIGNATION : NOTE_ASSIGNATION {$<string>$ = $<string>1}
            | INT_ASSIGNATION {$<string>$ = $<string>1}
            | ID '=' EXPRESION {$<string>$ =malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s = %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
            | NOTE_T '[' ']' ID '=' NOTE_ARRAY {$<string>$ =malloc(strlen($<string>4) + strlen($<string>6) + 11);sprintf($<string>$, "note[] %s = %s", $<string>4, $<string>6); free($<string>4); free($<string>6)}
            | ID '-' '-' {$<string>$ = malloc(2*strlen($<string>1) + 20);sprintf($<string>$, "%s = %s - 1", $<string>1, $<string>1); free($<string>1)}

NOTE_ASSIGNATION : NOTE_T ID '=' NOTE {$<string>$ = malloc(strlen($<string>1) + strlen($<string>2) + 9); sprintf($<string>$, "note %s = %s", $<string>1, $<string>2); free($<string>1); free($<string>2)}

NOTE_VAL    : ID '[' NUM ']' {$<string>$ = malloc(strlen($<string>1) + 3 + 20); sprintf($<string>$, "%s[%f]", $<string>1, $<decimal>3); free($<string>1)}
            | ID '[' ID ']' {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 3);sprintf($<string>$, "%s[%s]", $<string>1, $<string>3); free($<string>1); free($<string>3)}
            | NOTE_VAL '+' NUM {$<string>$ = malloc(strlen($<string>1) + +20+4); sprintf($<string>$, "%s + %f", $<string>1, $<decimal>3); free($<string>1)}
            | NOTE_VAL '+' NOTE_VAL {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 4); sprintf($<string>$, "%s + %s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
            | NOTE {$<string>$ = $<string>1}

INT_ASSIGNATION : INT_T ID '=' NUM {$<string>$ = malloc(strlen($<string>2) + 20 + 20); sprintf($<string>$, "int %s = %f", $<string>2, $<decimal>2); free($<string>2)}; 
                | INT_T ID '=' ID {$<string>$ = malloc(strlen($<string>2) + 20 + strlen($<string>4)); sprintf($<string>$, "int %s = %s", $<string>2, $<string>4); free($<string>2); free($<string>4)};
                | INT_T ID '=' LENGTH_FUNC {$<string>$ = malloc(strlen($<string>2) + 20 + strlen($<string>4)); sprintf($<string>$, "int %s = %s", $<string>2, $<string>4); free($<string>2); free($<string>4)}; 

NOTE_ARRAY  : '[' NOTE_LIST ']' {$<string>$ = malloc(strlen($<string>2) + 3); sprintf($<string>$, "[%s]", $<string>2); free($<string>2)}

NOTE_LIST   : NOTE ',' NOTE_LIST {$<string>$ = malloc(strlen($<string>1) + strlen($<string>3) + 2); sprintf($<string>$, "%s,%s", $<string>1, $<string>3); free($<string>1); free($<string>3)}
            | NOTE {$<string>$ = $<string>1}

BODY_LINE   : EXPRESION BODY_LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2 + tab_qty); sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); indent($<string>$, tab_qty); free($<string>1); free($<string>2)}
            | WHILE_LOOP BODY_LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2 + tab_qty);sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); indent($<string>$, tab_qty); free($<string>1); free($<string>2)}
            | PLAY_FUNC BODY_LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2 + tab_qty);sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); indent($<string>$, tab_qty);free($<string>1); free($<string>2)}
            | LENGTH_FUNC BODY_LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2 + tab_qty);sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); indent($<string>$, tab_qty); free($<string>1); free($<string>2)}
            | CONDITION BODY_LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2 + tab_qty);sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); indent($<string>$, tab_qty); free($<string>1); free($<string>2)}
            | EMPTY_LINE BODY_LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 1 + tab_qty);sprintf($<string>$, "%s%s", $<string>1, $<string>2); indent($<string>$, tab_qty); free($<string>1); free($<string>2)}
            | EMPTY_LINE {$<string>$ = $<string>1}

LINE        : EXPRESION LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2); sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); free($<string>1); free($<string>2)}
            | WHILE_LOOP LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2);sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); free($<string>1); free($<string>2)}
            | PLAY_FUNC LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2);sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); free($<string>1); free($<string>2)}
            | LENGTH_FUNC LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2);sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); free($<string>1); free($<string>2)}
            | CONDITION LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 2);sprintf($<string>$, "%s\n%s", $<string>1, $<string>2); free($<string>1); free($<string>2)}
            | EMPTY_LINE LINE {$<string>$ = malloc(strlen($<string>1) +  strlen($<string>2) + 1);sprintf($<string>$, "%s%s", $<string>1, $<string>2); free($<string>1); free($<string>2)}
            | EMPTY_LINE {$<string>$ = $<string>1}

EMPTY_LINE : /** lambda **/{$<string>$ = strdup("")}
%%

int yywrap()
{
    return 1;
} 

int main() {
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