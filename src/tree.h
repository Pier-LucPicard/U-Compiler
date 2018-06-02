#ifndef __tree_h
#define __tree_h

typedef struct STMT STMT;
typedef struct EXP EXP;
typedef struct PROG PROG;

typedef enum
{
    k_STMT_list,
    k_STMT_print,
    k_STMT_definition,
} STMT_KIND;

typedef enum
{
    k_EXP_variable,
    k_EXP_int,
    k_EXP_string,
    k_EXP_list,
    k_EXP_binary,
    k_EXP_unary,
    k_EXP_string_literal,
    k_EXP_identifier,
    k_EXP_int_literal,
} EXP_KIND;

struct PROG
{
    int yylineno;
    STMT* sourceCode;
};

struct STMT
{
    int yylineno;
    STMT_KIND kind;
    union {
        EXP *exp;
        struct
        {
            STMT *first;
            STMT *next;
        } list;
    } val;
};

struct EXP
{
    int yylineno;
    EXP_KIND kind;
    union {
        struct
        {
            EXP *first;
            EXP *next;
        } list;
        struct
        {
            EXP *lhs;
            EXP *rhs;
        } binary;
        struct
        {
            EXP *lhs;
        } unary;
        struct
        {
            char *name;
        } identifier;
        char *stringLiteral;
        int intLiteral;
    } val;
};



STMT* makeSTMTList(STMT_KIND, STMT *, STMT *);
STMT* makeSTMTexp(STMT_KIND, EXP*);


EXP* makeEXP_stringLiteral(char *stringLiteral);
EXP* makeEXP_identifier(char *identifier);
EXP* makeEXP_intLiteral(int);
EXP* makeEXPlist(EXP_KIND, EXP *, EXP *);

PROG* makePROG(STMT *);

#endif