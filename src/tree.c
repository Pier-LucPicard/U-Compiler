
#include "tree.h"
#include <stdlib.h>

extern int yylineno;

EXP *makeEXPlist(EXP_KIND kind, EXP* current, EXP* next)
{
    EXP *e = malloc(sizeof(EXP));
    e->yylineno = yylineno;
    e->kind = kind;
    e->val.list.first = current;
    e->val.list.next = next;
    return e;
}

EXP *makeEXP_identifier(char *identifier)
{
	EXP *e = malloc(sizeof(EXP));
	e->yylineno = yylineno;
	e->kind = k_EXP_identifier;
	e->val.identifier.name = identifier;
	return e;
}

EXP *makeEXP_stringLiteral(char *stringLiteral)
{
	EXP *e = malloc(sizeof(EXP));
	e->yylineno = yylineno;
	e->kind = k_EXP_string_literal;
	e->val.stringLiteral = stringLiteral;
	return e;
}

EXP *makeEXP_intLiteral(int intLiteral){
    EXP *e = malloc(sizeof(EXP));
	e->yylineno = yylineno;
	e->kind = k_EXP_int_literal;
	e->val.intLiteral = intLiteral;
	return e;
}


STMT *makeSTMTList(STMT_KIND kind, STMT* current, STMT* next){
    STMT *s = malloc(sizeof(STMT));
    s->yylineno = yylineno;
    s->kind = kind;
    s->val.list.first = current;
    s->val.list.next = next;
    return s;
}

STMT *makeSTMTexp(STMT_KIND kind, EXP *exp){
    STMT *s = malloc(sizeof(STMT));
    s->yylineno = yylineno;
    s->kind = kind;
    s->val.exp = exp;
    return s;
}

PROG* makePROG(STMT *code){
    PROG *p = malloc(sizeof(PROG));
    p->yylineno = yylineno;
    p->sourceCode = code;
    return p;
}