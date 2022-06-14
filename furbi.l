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