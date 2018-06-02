%{
#include <stdio.h>
#include <stdlib.h>
#include "tree.h"

extern int yylineno;
extern PROG *root;

int yylex();
void yyerror(const char *s) {fprintf(stderr, "Erreur: (ligne %d) %s\n", yylineno, s); exit(1);}

%}

%union {
    char *string_lit;
    int int_lit;
    struct PROG *prog;
    struct STMT *stmt;
    struct EXP *exp;
}

%locations
%error-verbose

%token tDEFINIR tCOMEUNE tQUANTITY tAVECVALEUR tCOMME tUN tUNE tFIN tDEBUT tVALEURDE tAFFICHER

%token <string_lit>  tIDENTIFIER
%token <int_lit> tINTLITERAL 
%type <prog> program
%type <stmt> statements nStatement statement definition printStatement
%type <exp> sentence


%start program
%%


program: statements  { root = makePROG($1); };


statements: nStatement {$$=$1;}
    | {$$=NULL;};

nStatement: statement {$$=$1;}
    |  statement nStatement{ $$=makeSTMTList(k_STMT_list, $1,$2);};

statement: definition '.' {$$=$1;}
    | printStatement '.' {$$=$1;};

definition: tDEFINIR tIDENTIFIER tCOMME tUN tQUANTITY tAVECVALEUR  tINTLITERAL {$$=NULL;};



printStatement: tAFFICHER sentence { $$=makeSTMTexp(k_STMT_print, $2);}
    | tAFFICHER tINTLITERAL{ $$=makeSTMTexp(k_STMT_print, makeEXP_intLiteral($2));}
    | tAFFICHER tVALEURDE tIDENTIFIER { $$=makeSTMTexp(k_STMT_print, makeEXP_identifier($3));};


sentence: tIDENTIFIER sentence {$$=makeEXPlist(k_EXP_list, makeEXP_identifier($1), $2);}
    | tIDENTIFIER {$$=makeEXP_identifier($1);};

%%