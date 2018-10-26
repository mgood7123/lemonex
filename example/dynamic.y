%lexer_debuglevel HIGH.
%include {
	char * CAT = "a";
}

rModule ::= .
HEREDOC ::= $CAT. { puts($$.buf); CAT = "b"; }
WS ::= ".*". { printf("OTHER: \"%s\"\n", $$.buf); }

%code {
	int main()
	{
		LX_REPARSE("ab");
	}
}
