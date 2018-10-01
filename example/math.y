
%token_type {int}

// %nonassoc makes it do in order found
%nonassoc DIVIDE TIMES MINUS PLUS     INTEGER.

// %token makes it do in unpredictable order as if it attempts to apply precedence to it
// %token DIVIDE TIMES MINUS PLUS     INTEGER.

// %left PLUS MINUS.
// %left DIVIDE TIMES.

%syntax_error {
  puts("Syntax error!");
}

%start_symbol program

program ::= expr(A).   { printf("Result=%d\n", A); }
expr(A) ::= expr(B) MINUS  expr(C).   { A = B - C; }
expr(A) ::= expr(B) PLUS  expr(C).   { A = B + C; }
expr(A) ::= expr(B) TIMES  expr(C).   { A = B * C; }
expr(A) ::= expr(B) DIVIDE expr(C).  {

         if(C != 0){
           A = B / C;
          }else{
           puts("divide by zero");
           }
}  /* end of DIVIDE */

expr(A) ::= INTEGER(B). { A = B; }

%code {
	int main()
	{
	void* pParser = ParseAlloc (malloc);

	/* First input:
		15 / 5
									*/
	Parse (pParser, INTEGER, 15);
	Parse (pParser, TIMES, 0);
	Parse (pParser, INTEGER, 5);
	Parse (pParser, 0, 0);

	/*  Second input:
			50 + 125
								*/


	Parse (pParser, INTEGER, 50);
	Parse (pParser, PLUS, 0);
	Parse (pParser, INTEGER, 125);
	Parse (pParser, 0, 0);


	/*  Third input:
			50 * 125 + 125
								*/


	Parse (pParser, INTEGER, 2);//	2	(2)			2	(2)		5	(5)
	Parse (pParser, TIMES, 0);//	x				x			+
	Parse (pParser, INTEGER, 5);//	5	(10)		5	(7)		15	(20)
	Parse (pParser, PLUS, 0);//		+				+			x
	Parse (pParser, INTEGER, 15);//	15	(10+15)		15	(7x15)	2	(20x2)
	Parse (pParser, 0, 0);//		=	25			=	105		=	40


	ParseFree(pParser, free );
// 	puts("parsing 5+5");
// 	if(ParseReadString("5+5", "<string>", "DEBUG: ") != 0) {
// 		printf("Error\n");
// 	} else printf("Success\n");


	}
}

// %lexer_code {
// 	"+"           {  return PLUS; }
// }
