%{
    #include <stdlib.h>
    #include "musicCompiler.tab.h"

    uint8_t isInInts(char * s);
    uint8_t isInDoubles(char * s);
    uint8_t isInNotes(char * s);
    uint8_t isInIntArrays(char * s);
    uint8_t isInDoubleArrays(char * s);
    uint8_t isInNoteArrays(char * s);
%}

alpha [A-Za-z]
digit [0-9]
double -?[0-9]+\.[0-9]+
note  [A-G][1-8]

%%

[\t \n]
"bpm"                               {yylval.string=strdup(yytext); return BPM;}
"volume"                            {yylval.string=strdup(yytext); return VOLUME;}
"note"                              {yylval.string=strdup(yytext); return NOTE_T;}
"int"                               {yylval.string=strdup(yytext); return INT_T;}
"double"                            {yylval.string=strdup(yytext); return DOUBLE_T;}
"play"                              {yylval.string=strdup(yytext); return PLAY;}
"during"                            {yylval.string=strdup(yytext); return DURING;}
"while"                             {yylval.string=strdup(yytext); return WHILE;}
"length"                            {yylval.string=strdup("len"); return LENGTH;}
(<|>)=?|==                          {yylval.string=strdup(yytext); return BOOL_OP;}
{digit}+                            {yylval.integer=atoi(yytext); return INTEGER;}
{double}                            {yylval.decimal=atof(yytext); return DOUBLE;}
{note}                              {yylval.string=strdup(yytext); return NOTE;}
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
                                        return NEW_ID;
                                    }
"//".*                              {/** Comment **/}
.                                   return yytext[0];

%%