// %lexer_debuglevel HIGH.
%include {
	char * CAT[LX_NESTMAX] = {0};
// 	char * AAA = "AAA";
}

rModule ::= .
HEREDOC ::= "<<.*[\n ]". [CAT] {
	CAT[LX_NESTLEVEL] = $$.buf;
	int len = strlen(CAT[LX_NESTLEVEL]);
	if (CAT[LX_NESTLEVEL][len-1] == ' ' || CAT[LX_NESTLEVEL][len-1] == '\n') {
		CAT[LX_NESTLEVEL][len-1] = 0;
	}
	printf("S: \"%s\"\n", CAT[LX_NESTLEVEL]);
	CAT[LX_NESTLEVEL] += 2;
}
WS ::= ".*". { printf("OTHER: \"%s\"\n", $$.buf); }

%lexer_mode CAT.
HEREDOC ::= "<<.*[\n ]". [CAT] {											//			<--------------------- NESTING ENTER
	CAT[LX_NESTLEVEL+1] = $$.buf;
	int len = strlen(CAT[LX_NESTLEVEL+1]);
	if (CAT[LX_NESTLEVEL+1][len-1] == ' ' || CAT[LX_NESTLEVEL+1][len-1] == '\n') {
		CAT[LX_NESTLEVEL+1][len-1] = 0;
	}
	printf("S: \"%s\"\n", CAT[LX_NESTLEVEL+1]);
	CAT[LX_NESTLEVEL+1] += 2;
}
LEAVE_HEREDOC ::= $CAT[LX_NESTLEVEL]. [<] { printf("E: %s\n", $$.buf); }					//			<--------------------- NESTING EXIT
WS ::= ".*". { printf("CAT[LX_NESTLEVEL-1]_%s: %s\n", "CONTENTS", $$.buf); }

%code {
	int main()
	{
// 		LX_REPARSE("cat <<CAT <<EOF K EOF KK CAT");
// 		LX_REPARSE("cat <<CAT\n<<EOF\nK\nEOF\nKK\nCAT");
// 		LX_REPARSE("cat <<g\n ; kde\nf rg\nthdt\nAbc\ng\n");
		LX_REPARSE("cat fbrftd frtdb <<g err -n\n ; kde\nf rg\nthdt\nAbc\ng\n");
	}
}
