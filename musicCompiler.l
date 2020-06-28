%{
    #include <stdlib.h>
    #include <math.h>
    #include "musicCompiler.tab.h"

    uint8_t isInInts(char * s);
    uint8_t isInDoubles(char * s);
    uint8_t isInNotes(char * s);
    uint8_t isInIntArrays(char * s);
    uint8_t isInDoubleArrays(char * s);
    uint8_t isInNoteArrays(char * s);
    double freq(char * note_name);
%}

alpha [A-Za-z]
digit [0-9]
double -?[0-9]+\.[0-9]+
note  [A-G]#?[0-8]
bool_op (<|>)=?|== 

%%

[\t \n \r]
"bpm"                               {yylval.string=strdup(yytext); return BPM;}
"volume"                            {yylval.string=strdup(yytext); return VOLUME;}
"note"                              {yylval.string=strdup(yytext); return NOTE_T;}
"int"                               {yylval.string=strdup(yytext); return INT_T;}
"double"                            {yylval.string=strdup(yytext); return DOUBLE_T;}
"play"                              {yylval.string=strdup(yytext); return PLAY;}
"during"                            {yylval.string=strdup(yytext); return DURING;}
"while"                             {yylval.string=strdup(yytext); return WHILE;}
"length"                            {yylval.string=strdup("len"); return LENGTH;}
"as"                                {yylval.string=strdup(yytext); return AS;}
"guitar"                            {yylval.string=strdup(yytext); return GUITAR;}
"piano"                             {yylval.string=strdup(yytext); return PIANO;}
"in"                                {yylval.string=strdup(yytext); return IN;}
"thread_"{digit}+                    {yylval.string=strdup(yytext); return THREAD;}
{bool_op}                           {yylval.string=strdup(yytext); return BOOL_OP;}
{digit}+                            {yylval.integer=atoi(yytext); return INTEGER;}
{double}                            {yylval.decimal=atof(yytext); return DOUBLE;}
"S"                                 {yylval.decimal=0; return NOTE;} /* Importante que este arriba de los IDs! */
{note}                              {yylval.decimal=freq(yytext); return NOTE;} /* Importante que este arriba de los IDs! */
{alpha}({alpha}|{digit}|"_")*       {
                                        yylval.string=strdup(yytext);
                                        if(isInInts(yylval.string)){
                                            return INT_VAR;
                                        }
                                        if(isInDoubles(yylval.string)){
                                            return DOUBLE_VAR;
                                        }
                                        if(isInNotes(yylval.string)){
                                            return NOTE_VAR;
                                        }
                                        if(isInIntArrays(yylval.string)){
                                            return INT_ARRAY_VAR;
                                        }
                                        if(isInDoubleArrays(yylval.string)){
                                            return DOUBLE_ARRAY_VAR;
                                        }
                                        if(isInNoteArrays(yylval.string)){
                                            return NOTE_ARRAY_VAR;
                                        }
                                        return NEW_ID; // Si no tiene un tipo antes, falla en el yacc
                                    }
"//".*                              {/** Comment **/}
.                                   return yytext[0];

%%

double freq(char * note_name){
    int base;
    switch(note_name[0]){
        case 'A':
        base = 0;
        break;
        case 'B':
        base = 2;
        break;
        case 'C':
        base = -9;
        break;
        case 'D':
        base = -7;
        break;
        case 'E':
        base = -5;
        break;
        case 'F':
        base = -4;
        break;
        case 'G':
        base = -2;
        break;
    }
    int octet;
    if(note_name[1] == '#'){
        base++;
        octet = note_name[2] - '0';
    }
    else{
        octet = note_name[1] - '0';
    }

    return 440 * pow(2, base/12.0 + octet-4);
}