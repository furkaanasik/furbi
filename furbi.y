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

%token PRINTFF SCANFF INT FLOAT CHAR VOID RETURN FOR IF ELSE TRUE FALSE INTEGER FLOAT_NUM VARIABLE UNARY LE GE EQ NE GT LT AND OR ADD SUBTRACT DIVIDE MULTIPLY STR CHARACTER INCLUDE OBR CBR SEMIC OCBR CCBR AMPERSANT COMMA ASSIGN

%%
codeflow: header maintype '(' ')' '{' body return '}'
;

header: header header
| INCLUDE
|
;

maintype: datatype VARIABLE
;

datatype: INT
| FLOAT
| CHAR
| VOID
;

body: loop
| ifstatement
| assignment
| print
| scan
| body body
;

loop: FOR OBR assignment SEMIC condition SEMIC assignment CBR OCBR body CCBR
;

ifstatement: IF OBR condition CBR OCBR body CCBR else
;

condition: value comparison value
| TRUE
| FALSE
;

else: ELSE OCBR body CCBR
|
;

assignment: datatype VARIABLE ASSIGN value
| VARIABLE ASSIGN arithmetic expression
| VARIABLE comparison expression
| VARIABLE UNARY
| UNARY VARIABLE
;

comparison : LT
| GT
| LE
| GE
| EQ
| NE
;

print: PRINTFF OBR STR CBR SEMIC
;

scan: SCANFF OBR STR COMMA AMPERSANT VARIABLE CBR SEMIC
;

return: RETURN value SEMIC

;

value: INTEGER
| FLOAT_NUM
| CHARACTER
| VARIABLE
;

expression: expression arithmetic expression
| value
;

arithmetic: ADD 
| SUBTRACT 
| MULTIPLY
| DIVIDE
;

%%

int main() {
    yyparse();
}

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}