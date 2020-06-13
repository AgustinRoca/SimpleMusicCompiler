%{
    #include "example.tab.h"
%}

alpha [A-Za-z]
digit [0-9]
num   (-)?[0-9]+(.[0-9]+)?
note  [A-G][1-8]

%%

[\t \n] 
"bpm"                               {yylval.string=strdup(yytext); return BPM;}
"volume"                            {yylval.string=strdup(yytext); return VOLUME;}
"note"                              {yylval.string=strdup(yytext); return NOTE_T;}
"int"                               {yylval.string=strdup(yytext); return INT_T;}
"play"                              {yylval.string=strdup(yytext); return PLAY;}
"during"                            {yylval.string=strdup(yytext); return DURING;}
"while"                             {yylval.string=strdup(yytext); return WHILE;}
"length"                            {yylval.string=strdup("len"); return LENGTH;}
{num}+                              {yylval.decimal=atof(yytext); return NUM;}
{note}                              {yylval.string=strdup(yytext); return NOTE;}
{alpha}({alpha}|{digit}|"_")*       {yylval.string=strdup(yytext); return ID;}
"//".*                              {/** Comment **/}
.                                   return yytext[0];

%%