%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<ctype.h>
    #include"lex.yy.c"

    void yyerror(const char *s);
    int yylex();
    int yywrap();
%}

%token PRINTFF SCANFF INT FLOAT CHAR VOID RETURN FOR IF ELSE TRUE FALSE INTEGER FLOAT_NUM VARIABLE UNARY LE GE EQ NE GT LT AND OR ADD SUBTRACT DIVIDE MULTIPLY STR CHARACTER INCLUDE

%%

result: codeflow { printf("\nACCEPTED\n"); exit(0); }

codeflow: header datatype VARIABLE '(' ')' '{' body return '}'
;

header: header header
| INCLUDE
|
;

datatype: INT
| FLOAT
| CHAR
| VOID
;

body: loop
| ifstatement
| assignment ';'
| print
| scan
| body body
;

loop: FOR '(' assignment ';' condition ';' assignment ')' '{' body '}'
;

ifstatement: IF '(' condition ')' '{' body '}' else
;

else: ELSE '{' body '}'
|
;

print: PRINTFF '(' STR ')' ';'
| PRINTFF '(' expression ')' ';'
;

scan: SCANFF '(' STR ',' '&' VARIABLE ')' ';'
;

condition: value comparison value
| TRUE
| FALSE
;

assignment: datatype VARIABLE
| datatype VARIABLE '=' value
| VARIABLE '=' arithmetic expression
| VARIABLE comparison expression
| VARIABLE UNARY
| UNARY VARIABLE
;

expression: expression arithmetic expression
| value
;

arithmetic: ADD
| SUBTRACT
| MULTIPLY
| DIVIDE
;

comparison : LT
| GT
| LE
| GE
| EQ
| NE
;

value: INTEGER
| FLOAT_NUM
| CHARACTER
| VARIABLE
;

return: RETURN value ';'
|
;


%%

int main() {
    yyparse();
    return yylex();
}

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}
