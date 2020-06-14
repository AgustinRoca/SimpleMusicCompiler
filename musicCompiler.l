%{
    #include "musicCompiler.tab.h"
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
{alpha}({alpha}|{digit}|"_")*       {yylval.string=strdup(yytext); return ID;}
"//".*                              {/** Comment **/}
.                                   return yytext[0];

%%