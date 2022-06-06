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
codeflow: header maintype OBR CBR OCBR body return CCBR
;

header: header header
| INCLUDE
;

body: loop
| ifstatement
| condition
| assignment
| print
| scan
| body body
;

return: RETURN value SEMIC
;

loop: FOR OBR assignment SEMIC condition SEMIC assignment CBR OCBR body CCBR
;

ifstatement: IF OBR condition CBR OCBR body CCBR else
;

else: ELSE OCBR body CCBR
|
;

condition: value comparison value
| TRUE
| FALSE
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

assignment: datatype VARIABLE ASSIGN value
| VARIABLE ASSIGN arithmetic expression
| VARIABLE comparison expression
| VARIABLE UNARY
| UNARY VARIABLE
;

arithmetic: ADD 
| SUBTRACT 
| MULTIPLY
| DIVIDE
;

expression: expression arithmetic expression
| value
;


print: PRINTFF OBR STR CBR SEMIC
;

scan: SCANFF OBR STR COMMA AMPERSANT VARIABLE CBR SEMIC
;

maintype: datatype VARIABLE
;

datatype: INT
| FLOAT
| CHAR
| VOID
;

%%

int main() {
    yyparse();
}

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}

