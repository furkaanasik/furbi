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
`fafa`


