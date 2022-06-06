/* DECLARATIONS */
%{  
	#include"y.tab.h"
%}

%option yylineno

alpha [a-zA-Z]
digit [0-9]
unary "++"|"--"

/* RULES */
%%
"print"								{return PRINTFF; } 
"scan"								{retrun SCANFF; } 
"int"								{return INT; }
"dotnum"							{return FLOAT; }
"char"								{return CHAR; }
"blank"								{return VOID; } 
"comeback"							{return RETURN; } //
"loop"								{return FOR; }
"if"								{return IF; }
"else"								{return ELSE; }
"true"								{return TRUE; }
"false"								{return FALSE; }
{digit}+							{return INTEGER; }
{digit}+\.{digit}+					{return FLOAT_NUM; }
{alpha}({alpha} | [0-9])* 			{return VARIABLE; }
{unary}                     		{return UNARY; }
"<="                        		{ return LE; }
">="                        		{ return GE; }
"=="                        		{ return EQ; }
"!="                        		{ return NE; }
">"                     			{ return GT; }
"<"                     			{ return LT; }
"&&"                      			{ return AND; }
"||"                      			{ return OR; }
"+"                         		{ return ADD; }
"-"                         		{ return SUBTRACT; }
"/"                         		{ return DIVIDE; }
"*"                         		{ return MULTIPLY; }
["].*["]                    		{ return STR; }
['].[']                     		{ return CHARACTER; }
.                     				{ return *yytext; }
"#include"[ ]*<.+\.h>  				{ return INCLUDE; }
"(" 								{return OBR;}
")" 								{return CBR;}
";"									{return SEMIC;}
"{"									{return OCBR; }
"}"									{return CCBR; }
"&"									{return AMPERSANT; }
","									{return COMMA; }
"="									{return ASSIGN; }
%%

/* SUBROUTINES */
int yywrap() {
    return 1;
}