# FURBI

It was built with the furbi flex and bison programming languages.

## FURBI FUNDAMENTALS

### Data Types
-  ***int*** e.g. 234, 3445, 1, 2
-  ***dotnum*** e.g. 1.3, 2.5, 3.6
-  ***text*** e.g. “a”, “dsf”, “furbi”
-  ***char*** e.g. ‘f’, ‘u’, ‘r’, ‘b’, ‘i’
- ***blank***

### Binary Operations
- **‘-’  Subtract**
- **‘+’ Add**
- **‘*’  Multiply**
- **‘/’ Divide**

### Binary Condition
- **‘<=’ Less equal**
- **‘>=’ Grand equal**
- **‘==’ Equal**
- **‘!=’ Not equal**
- **‘>’  Greater than**
- **‘<’  Less than**
- **‘&&’ And**
- **‘||’ Or**

### Include
- ***'#include <STR.h>’*  e.g**
	- `#include <stdio.h>`
	- #include <stdlib.h>

### Condition
- ***‘if’* e.g.**
	- `if(a < b) { print("furbi");}`
- ***'else'* e.g.**
	- `else {print("furbi");}`

### Return
- ***‘comeback’*  e.g.**
	- `comeback 0;`

### Unary
- **‘++’  e.g.**
	- `a++;`
- **'--' e.g.**
	- `a--;`

## Compile Process
- `‘flex furbi.l’`
- `‘bison -d furbi.y’`
- `‘gcc -o sample furbi.tab.c’`
- `‘sample < furbi.fb’`

## Sample Program - furbi.fb
```
#include <stdio.h>
#include <stdlib.h>

int main()
{
	int a = 0;
	int b = 3;
	dotnum c = 3.4;
	char d = 'f';
	text e = "furbi";
	blank f;

	if(a > b)
	{
		print("a bigger than b.");
	}

	else
	{
		print("b bigger than a.");
	}

	loop(int i = 0; i < b; i++)
	{
		print("furbi");
	}

	comeback 0;
}

```

## Lexical Analyzer Code - furbi.l
```
/* DECLARATIONS */
%{
	#include"furbi.tab.h"
%}

%option yylineno

alpha [a-zA-Z]
digit [0-9]
unary "++"|"--"

/* RULES */
%%
"print"                    		{ return PRINTFF; }
"scan"                      	{ return SCANFF; }
"int"                      		{ return INT; }
"dotnum"                     	{ return FLOAT; }
"char"                      	{ return CHAR; }
"text"							{ return TEXT;}
"blank"                      	{ return VOID; }
"comeback"                    	{ return RETURN; }
"loop"                     		{ return FOR; }
"if"                      		{ return IF; }
"else"                      	{ return ELSE; }
^"#include"[ ]*<.+\.h>      	{ return INCLUDE; }
"true"                      	{ return TRUE; }
"false"                     	{ return FALSE; }
{digit}+                		{ return INTEGER; }
{digit}+\.{digit}+  			{ return FLOAT_NUM; }
{alpha}({alpha}|{digit})*   	{ return VARIABLE; }
{unary}                     	{ return UNARY; }
"<="                        	{ return LE; }
">="                        	{ return GE; }
"=="                        	{ return EQ; }
"!="                        	{ return NE; }
">"                     		{ return GT; }
"<"                     		{ return LT; }
"&&"                      		{ return AND; }
"||"                      		{ return OR; }
"+"                         	{ return ADD; }
"-"                         	{ return SUBTRACT; }
"/"                         	{ return DIVIDE; }
"*"                         	{ return MULTIPLY; }
\/\/.*                      	{ ; }
\/\*(.*\n)*.*\*\/           	{ ; }
[ \t]*                      	{ ; }
.                     			{ return *yytext; }
["].*["]                    	{ return STR; }
['].[']                     	{ return CHARACTER; }
%%

/* SUBROUTINES */
int yywrap() {
    return 1;
}
```

## Parser Code - furbi.y
```
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

%token PRINTFF SCANFF INT FLOAT CHAR VOID RETURN FOR IF ELSE TRUE FALSE INTEGER FLOAT_NUM VARIABLE UNARY LE GE EQ NE GT LT AND OR ADD SUBTRACT DIVIDE MULTIPLY STR CHARACTER INCLUDE TEXT

%start result

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
| TEXT
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
| VARIABLE comparison VARIABLE
| VARIABLE comparison value
| value comparison VARIABLE
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
| STR
;

return: RETURN value ';'
|
;


%%

int main() {
    yyparse();
}

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}

```
