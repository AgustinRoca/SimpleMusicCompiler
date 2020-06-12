%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}
%token ID NUM FOR LE GE EQ NE OR AND
%right "="
%left OR AND
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'

%%
    
S         : ST {printf("Input accepted\n"); exit(0);}
ST       : FOR '(' E ';' E2 ';' E ')' DEF
            { printf("La expresion es: (%d; %d; %d)\n", $1,$2,$3);}
           ;
DEF    : '{' BODY '}'
           | E';' 
           | ST
           |
           ;
BODY  : BODY BODY
           | E ';'        
           | ST
           |             
           ;
        
E        : ID '=' E 
            { $$ = $3;}
          | E '+' E 
          | E '-' E
          | E '*' E
          | E '/' E
          | E '<' E
          | E '>' E
          | E LE E
          | E GE E
          | E EQ E
          | E NE E
          | E OR E
          | E AND E
          | E '+' '+' 
          | E '-' '-'
          | ID  
          | NUM
          { $$ = $1; printf("Found %d\n", $1);   }
          ;

    
E2     : E'<'E
         | E'>'E
         | E LE E
         | E GE E
         | E EQ E
         | E NE E
         | E OR E
         | E AND E
         ;    
%%

int yywrap()
{
        return 1;
} 

int main() {
    printf("Enter the expression:\n");
    yyparse();
    return 0;
} 