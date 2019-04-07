%{
	# define YYDEBUG 1		/* Pour avoir du code de mise au point */


	int yylex(void);
	int yyerror(char *);
	enum op {AND, OR, NAND, NOR, XOR};

	char compute(char, char, enum op);
	void print_bool(char);
	char flip(char);
%}



%union {
	char c;
	enum op o;
};



%token <c> BOOLEAN
%left <o> OP
%type <c> expr exprs 

%start exprs			/* le symbole de depart */

%%
exprs : /* rien */
		{ printf("? "); }
		| exprs expr '\n'
		{ print_bool($2);
			printf("\n? "); }
		;		

expr : 		BOOLEAN 		
				{$$ = $1;}
		| 	expr OP expr 	
				{$$ = compute($1, $3, $2);}
		|	'-' BOOLEAN
				{$$ = flip($2);}
		|	'(' expr ')'
				{$$ = $2;}
		;

%%

# include <stdio.h>
# include <assert.h>
# include <ctype.h>
# include <string.h>


int yydebug = 0;		/* different de 0 pour la mise au point */

int main(){
	yyparse();
	puts("Bye");
	return 0;
}


int yyerror(char * s){
	fprintf(stderr, "%s\n", s);
	return 0;
}


int yylex(){
	int c;
	char operation[16];

	re:
		switch(c = getchar()){

			default:
				ungetc(c, stdin);
				scanf("%16s", operation);
				char* i = operation;
				while(*i){ 
					*i = toupper(*i);
					i++;
				}
				if		(strcmp(operation, "AND") == 0)		yylval.o = AND;
				else if	(strcmp(operation, "OR") == 0) 		yylval.o = OR;
				else if	(strcmp(operation, "NOR") == 0) 	yylval.o = NOR;
				else if	(strcmp(operation, "NAND") == 0) 	yylval.o = NAND;
				else if	(strcmp(operation, "XOR") == 0)	 	yylval.o = XOR;
				else if	(strcmp(operation, "TRUE") == 0)  {	yylval.c = 1 ; return BOOLEAN ; }
				else if	(strcmp(operation, "FALSE") == 0) {	yylval.c = 0 ; return BOOLEAN ; }
				else{
					printf("Fatal Error: %s\n", operation);
				}
				fflush(stdout);
				return OP;

			case ' ': case '\t':
				goto re;

			case EOF:
				return 0;
		 
			case '1':
				yylval.c = 1;
				return BOOLEAN;
			case '0':
			 	yylval.c = 0;
				return BOOLEAN;

			case '(': case ')': case '-': case '\n': 
				return c;
		}
}

char flip(char c){
	if(c) return 0;
	return 1;
}

char compute(char f1, char f2, enum op operation){
	switch(operation){
		case OR: 	return f1+f2 > 0 ? 1 : 0;
		case AND:	return f1*f2;
		case NAND:	return flip(f1*f2);
		case NOR:	return flip(f1+f2 > 0 ? 1 : 0);
		case XOR:	return f1+f2 == 1 ? 1 : 0;
	}
	return yyerror("Fatal Error : pas d'operation");
}

void print_bool(char c){
	if(c){ printf("True\n"); return;}
	printf("False\n");
}
