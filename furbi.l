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
"blank"                      	{ return VOID; }
"comeback"                    	{ return RETURN; }
"loop"                     		{ return FOR; }
"if"                      		{ return IF; }
"else"                      	{ return ELSE; }
^"#include"[ ]*<.+\.h>      	{ return INCLUDE; }
"true"                      	{ return TRUE; }
"false"                     	{ return FALSE; }
{digit}+                		{ return INTEGER; }
{digit}+\.{digit}  				{ return FLOAT_NUM; }
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


/*
C:\Users\binay\Desktop\Furbi>flex furbi.l

C:\Users\binay\Desktop\Furbi>bison -d furbi.y
furbi.y: çelişkiler: 21 öteleme/indirgeme, 5 indirgeme/indirgeme

C:\Users\binay\Desktop\Furbi>gcc -o furbi.exe furbi.tab.c

C:\Users\binay\Desktop\Furbi>furbi.exe
int main(){

if(5 < 10) {

print("five is less than ten");

}

comeback 0;

}

ACCEPTED
*/
