/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     BPM = 258,
     NUM = 259,
     VOLUME = 260,
     NOTE_T = 261,
     NOTE = 262,
     INT_T = 263,
     ID = 264,
     WHILE = 265,
     PLAY = 266,
     DURING = 267,
     LENGTH = 268
   };
#endif
/* Tokens.  */
#define BPM 258
#define NUM 259
#define VOLUME 260
#define NOTE_T 261
#define NOTE 262
#define INT_T 263
#define ID 264
#define WHILE 265
#define PLAY 266
#define DURING 267
#define LENGTH 268




/* Copy the first part of user declarations.  */
#line 1 "example.y"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(char ** result, const char *s);
void indent(char * s, int n);

int yydebug=1;
int tab_qty=0;


/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 15 "example.y"
{
    int number;
    float decimal;
    char *string;
}
/* Line 193 of yacc.c.  */
#line 141 "example.tab.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 154 "example.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  5
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   136

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  25
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  21
/* YYNRULES -- Number of rules.  */
#define YYNRULES  51
/* YYNRULES -- Number of states.  */
#define YYNSTATES  104

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   268

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      16,    17,     2,    23,    24,    22,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    19,    18,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    20,     2,    21,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    14,     2,    15,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     7,    10,    13,    15,    17,    25,    27,
      32,    37,    42,    44,    46,    48,    50,    52,    56,    60,
      64,    66,    68,    72,    79,    83,    88,    93,    98,   102,
     106,   108,   113,   118,   123,   127,   131,   133,   136,   139,
     142,   145,   148,   151,   153,   156,   159,   162,   165,   168,
     171,   173
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      26,     0,    -1,    27,    28,    44,    -1,     3,     4,    -1,
       5,     4,    -1,    14,    -1,    15,    -1,    10,    16,    36,
      17,    29,    32,    30,    -1,    43,    -1,    11,    39,    12,
       4,    -1,    13,    16,    41,    17,    -1,    13,    16,     9,
      17,    -1,    37,    -1,    36,    -1,    39,    -1,     4,    -1,
      34,    -1,     9,    18,     4,    -1,     4,    18,     9,    -1,
       4,    18,     4,    -1,    38,    -1,    40,    -1,     9,    19,
      35,    -1,     6,    20,    21,     9,    19,    41,    -1,     9,
      22,    22,    -1,     6,     9,    19,     7,    -1,     9,    20,
       4,    21,    -1,     9,    20,     9,    21,    -1,    39,    23,
       4,    -1,    39,    23,    39,    -1,     7,    -1,     8,     9,
      19,     4,    -1,     8,     9,    19,     9,    -1,     8,     9,
      19,    34,    -1,    20,    42,    21,    -1,     7,    24,    42,
      -1,     7,    -1,    35,    43,    -1,    31,    43,    -1,    33,
      43,    -1,    34,    43,    -1,    36,    43,    -1,    45,    43,
      -1,    45,    -1,    35,    44,    -1,    31,    44,    -1,    33,
      44,    -1,    34,    44,    -1,    36,    44,    -1,    45,    44,
      -1,    45,    -1,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,    26,    26,    28,    30,    32,    33,    35,    37,    39,
      41,    42,    44,    45,    46,    47,    48,    50,    51,    52,
      54,    55,    56,    57,    58,    60,    62,    63,    64,    65,
      66,    68,    69,    70,    72,    74,    75,    77,    78,    79,
      80,    81,    82,    83,    85,    86,    87,    88,    89,    90,
      91,    93
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "BPM", "NUM", "VOLUME", "NOTE_T", "NOTE",
  "INT_T", "ID", "WHILE", "PLAY", "DURING", "LENGTH", "'{'", "'}'", "'('",
  "')'", "'>'", "'='", "'['", "']'", "'-'", "'+'", "','", "$accept", "S",
  "SET_BPM", "VOL", "OPEN_BRACKET", "CLOSE_BRACKET", "WHILE_LOOP", "BODY",
  "PLAY_FUNC", "LENGTH_FUNC", "EXPRESION", "CONDITION", "ASSIGNATION",
  "NOTE_ASSIGNATION", "NOTE_VAL", "INT_ASSIGNATION", "NOTE_ARRAY",
  "NOTE_LIST", "BODY_LINE", "LINE", "EMPTY_LINE", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   123,   125,    40,    41,    62,    61,
      91,    93,    45,    43,    44
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    25,    26,    27,    28,    29,    30,    31,    32,    33,
      34,    34,    35,    35,    35,    35,    35,    36,    36,    36,
      37,    37,    37,    37,    37,    38,    39,    39,    39,    39,
      39,    40,    40,    40,    41,    42,    42,    43,    43,    43,
      43,    43,    43,    43,    44,    44,    44,    44,    44,    44,
      44,    45
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     3,     2,     2,     1,     1,     7,     1,     4,
       4,     4,     1,     1,     1,     1,     1,     3,     3,     3,
       1,     1,     3,     6,     3,     4,     4,     4,     3,     3,
       1,     4,     4,     4,     3,     3,     1,     2,     2,     2,
       2,     2,     2,     1,     2,     2,     2,     2,     2,     2,
       1,     0
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     3,     1,     0,    51,     4,    15,
       0,    30,     0,     0,     0,     0,     0,    51,    51,    16,
      51,    13,    12,    20,    14,    21,     2,    50,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      45,    46,    47,    44,    48,     0,    49,    19,    18,     0,
       0,     0,    17,    16,    22,    13,     0,     0,    24,     0,
       0,     0,     0,     0,     0,     0,    28,    29,    25,     0,
      31,    32,    33,    26,    27,     0,     9,    11,    36,     0,
      10,     0,     5,    51,     0,    34,    23,    51,     0,    51,
      16,    51,    13,     8,    43,    35,    38,     6,     7,    39,
      40,    37,    41,    42
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     3,     7,    83,    98,    17,    88,    18,    19,
      20,    21,    22,    23,    24,    25,    65,    79,    93,    26,
      27
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -86
static const yytype_int8 yypact[] =
{
       0,    22,    36,    47,   -86,   -86,    58,    76,   -86,    45,
       2,   -86,    56,    86,    57,    44,    59,    76,    76,    76,
      76,    76,   -86,   -86,    49,   -86,   -86,    76,    34,    93,
      88,    94,   106,    84,    92,    89,    98,    95,    11,    15,
     -86,   -86,   -86,   -86,   -86,    91,   -86,   -86,   -86,   107,
     108,    90,   -86,   -86,   -86,   -86,    97,    99,   -86,    45,
     101,   104,   112,   105,   116,   109,   -86,    49,   -86,   110,
     -86,   -86,   -86,   -86,   -86,   111,   -86,   -86,   100,   113,
     -86,   115,   -86,    76,   116,   -86,   -86,    76,   117,    76,
      76,    76,    76,   -86,    76,   -86,   -86,   -86,   -86,   -86,
     -86,   -86,   -86,   -86
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -86,   -86,   -86,   -86,   -86,   -86,   -75,   -86,   -62,   -33,
     -13,   -23,   -86,   -86,   -14,   -86,    46,    52,   -85,    28,
     -50
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      53,    38,    96,     1,    99,   100,   101,   102,    87,   103,
      55,    29,    87,    61,    87,    87,    87,    87,    72,    87,
      54,    89,    30,    62,    63,    89,     4,    89,    89,    89,
      89,    67,    89,    94,    45,    64,     5,    94,    47,    94,
      94,    94,    94,    48,    94,    40,    41,    42,    43,    44,
      90,    11,     6,    37,    90,    46,    90,    90,    90,    90,
      92,    90,     8,    28,    92,    31,    92,    92,    92,    92,
      91,    92,    45,    36,    91,    39,    91,    91,    91,    91,
       9,    91,    10,    11,    12,    13,    14,    15,     9,    16,
      10,    11,    12,    13,    70,    66,    56,    16,    11,    71,
      37,    57,    59,    16,    32,    33,    34,    60,    35,    50,
      52,    58,    49,    51,    68,    34,    76,    69,    73,    32,
      74,    75,    77,    78,    84,    82,    80,    86,     0,    81,
       0,     0,    97,     0,    85,    64,    95
};

static const yytype_int8 yycheck[] =
{
      33,    15,    87,     3,    89,    90,    91,    92,    83,    94,
      33,     9,    87,    36,    89,    90,    91,    92,    51,    94,
      33,    83,    20,    12,     9,    87,     4,    89,    90,    91,
      92,    45,    94,    83,    23,    20,     0,    87,     4,    89,
      90,    91,    92,     9,    94,    17,    18,    19,    20,    21,
      83,     7,     5,     9,    87,    27,    89,    90,    91,    92,
      83,    94,     4,    18,    87,     9,    89,    90,    91,    92,
      83,    94,    23,    16,    87,    16,    89,    90,    91,    92,
       4,    94,     6,     7,     8,     9,    10,    11,     4,    13,
       6,     7,     8,     9,     4,     4,     4,    13,     7,     9,
       9,     9,     4,    13,    18,    19,    20,     9,    22,    21,
       4,    22,    19,    19,     7,    20,     4,     9,    21,    18,
      21,    17,    17,     7,    24,    14,    17,    81,    -1,    19,
      -1,    -1,    15,    -1,    21,    20,    84
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    26,    27,     4,     0,     5,    28,     4,     4,
       6,     7,     8,     9,    10,    11,    13,    31,    33,    34,
      35,    36,    37,    38,    39,    40,    44,    45,    18,     9,
      20,     9,    18,    19,    20,    22,    16,     9,    39,    16,
      44,    44,    44,    44,    44,    23,    44,     4,     9,    19,
      21,    19,     4,    34,    35,    36,     4,     9,    22,     4,
       9,    36,    12,     9,    20,    41,     4,    39,     7,     9,
       4,     9,    34,    21,    21,    17,     4,    17,     7,    42,
      17,    19,    14,    29,    24,    21,    41,    31,    32,    33,
      34,    35,    36,    43,    45,    42,    43,    15,    30,    43,
      43,    43,    43,    43
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (result, YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value, result); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, char **result)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep, result)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
    char **result;
#endif
{
  if (!yyvaluep)
    return;
  YYUSE (result);
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, char **result)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep, result)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
    char **result;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep, result);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule, char **result)
#else
static void
yy_reduce_print (yyvsp, yyrule, result)
    YYSTYPE *yyvsp;
    int yyrule;
    char **result;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       , result);
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule, result); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, char **result)
#else
static void
yydestruct (yymsg, yytype, yyvaluep, result)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
    char **result;
#endif
{
  YYUSE (yyvaluep);
  YYUSE (result);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (char **result);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (char **result)
#else
int
yyparse (result)
    char **result;
#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 26 "example.y"
    {*result = (char*)malloc(strlen((yyvsp[(1) - (3)].string)) + strlen((yyvsp[(2) - (3)].string)) + strlen((yyvsp[(3) - (3)].string))+ 3); sprintf(*result,"%s\n%s\n%s", (yyvsp[(1) - (3)].string), (yyvsp[(2) - (3)].string), (yyvsp[(3) - (3)].string)); free((yyvsp[(1) - (3)].string)); free((yyvsp[(2) - (3)].string)); free((yyvsp[(3) - (3)].string));}
    break;

  case 3:
#line 28 "example.y"
    {(yyval.string) = malloc(120 + 20); sprintf((yyval.string), "length_of_beat = %f", (yyvsp[(2) - (2)].decimal)/60);}
    break;

  case 4:
#line 30 "example.y"
    {(yyval.string) = malloc(10 + 20); sprintf((yyval.string), "volume = %f", (yyvsp[(2) - (2)].decimal));}
    break;

  case 5:
#line 32 "example.y"
    {tab_qty++;}
    break;

  case 6:
#line 33 "example.y"
    {tab_qty--;}
    break;

  case 7:
#line 35 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(3) - (7)].string)) +  strlen((yyvsp[(6) - (7)].string)) + 15);sprintf((yyval.string), "while %s:\n%s", (yyvsp[(3) - (7)].string), (yyvsp[(6) - (7)].string)); free((yyvsp[(3) - (7)].string)); free((yyvsp[(6) - (7)].string));}
    break;

  case 8:
#line 37 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 9:
#line 39 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(2) - (4)].string)) + 11 + 20); sprintf((yyval.string), "play([%s], %f)", (yyvsp[(2) - (4)].string), (yyvsp[(4) - (4)].decimal)); free((yyvsp[(2) - (4)].string));}
    break;

  case 10:
#line 41 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(3) - (4)].string)) + 6);sprintf((yyval.string), "len(%s)", (yyvsp[(3) - (4)].string)); free((yyvsp[(3) - (4)].string));}
    break;

  case 11:
#line 42 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(3) - (4)].string)) + 6); sprintf((yyval.string), "len(%s)", (yyvsp[(3) - (4)].string)); free((yyvsp[(3) - (4)].string));}
    break;

  case 12:
#line 44 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 13:
#line 45 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 14:
#line 46 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 15:
#line 47 "example.y"
    {(yyval.string) = malloc(9);sprintf((yyval.string), "%f", (yyvsp[(1) - (1)].decimal));}
    break;

  case 16:
#line 48 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 17:
#line 50 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (3)].string)) + 20 + 4); sprintf((yyval.string), "%s > %f", (yyvsp[(1) - (3)].string), (yyvsp[(3) - (3)].decimal)); free((yyvsp[(1) - (3)].string));}
    break;

  case 18:
#line 51 "example.y"
    {(yyval.string) =malloc(strlen((yyvsp[(3) - (3)].string)) + 20 + 4); sprintf((yyval.string), "%f > %s", (yyvsp[(1) - (3)].decimal), (yyvsp[(3) - (3)].string)); free((yyvsp[(3) - (3)].string));}
    break;

  case 19:
#line 52 "example.y"
    {(yyval.string) = malloc(4); sprintf((yyval.string), "%d", (yyvsp[(1) - (3)].decimal) > (yyvsp[(3) - (3)].decimal));}
    break;

  case 20:
#line 54 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 21:
#line 55 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 22:
#line 56 "example.y"
    {(yyval.string) =malloc(strlen((yyvsp[(1) - (3)].string)) + strlen((yyvsp[(3) - (3)].string)) + 4); sprintf((yyval.string), "%s = %s", (yyvsp[(1) - (3)].string), (yyvsp[(3) - (3)].string)); free((yyvsp[(1) - (3)].string)); free((yyvsp[(3) - (3)].string));}
    break;

  case 23:
#line 57 "example.y"
    {(yyval.string) =malloc(strlen((yyvsp[(4) - (6)].string)) + strlen((yyvsp[(6) - (6)].string)) + 11);sprintf((yyval.string), "note[] %s = %s", (yyvsp[(4) - (6)].string), (yyvsp[(6) - (6)].string)); free((yyvsp[(4) - (6)].string)); free((yyvsp[(6) - (6)].string));}
    break;

  case 24:
#line 58 "example.y"
    {(yyval.string) = malloc(2*strlen((yyvsp[(1) - (3)].string)) + 20);sprintf((yyval.string), "%s = %s - 1", (yyvsp[(1) - (3)].string), (yyvsp[(1) - (3)].string)); free((yyvsp[(1) - (3)].string));}
    break;

  case 25:
#line 60 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (4)].string)) + strlen((yyvsp[(2) - (4)].string)) + 9); sprintf((yyval.string), "note %s = %s", (yyvsp[(1) - (4)].string), (yyvsp[(2) - (4)].string)); free((yyvsp[(1) - (4)].string)); free((yyvsp[(2) - (4)].string));}
    break;

  case 26:
#line 62 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (4)].string)) + 3 + 20); sprintf((yyval.string), "%s[%f]", (yyvsp[(1) - (4)].string), (yyvsp[(3) - (4)].decimal)); free((yyvsp[(1) - (4)].string));}
    break;

  case 27:
#line 63 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (4)].string)) + strlen((yyvsp[(3) - (4)].string)) + 3);sprintf((yyval.string), "%s[%s]", (yyvsp[(1) - (4)].string), (yyvsp[(3) - (4)].string)); free((yyvsp[(1) - (4)].string)); free((yyvsp[(3) - (4)].string));}
    break;

  case 28:
#line 64 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (3)].string)) + +20+4); sprintf((yyval.string), "%s + %f", (yyvsp[(1) - (3)].string), (yyvsp[(3) - (3)].decimal)); free((yyvsp[(1) - (3)].string));}
    break;

  case 29:
#line 65 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (3)].string)) + strlen((yyvsp[(3) - (3)].string)) + 4); sprintf((yyval.string), "%s + %s", (yyvsp[(1) - (3)].string), (yyvsp[(3) - (3)].string)); free((yyvsp[(1) - (3)].string)); free((yyvsp[(3) - (3)].string));}
    break;

  case 30:
#line 66 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 31:
#line 68 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(2) - (4)].string)) + 20 + 20); sprintf((yyval.string), "int %s = %f", (yyvsp[(2) - (4)].string), (yyvsp[(2) - (4)].decimal)); free((yyvsp[(2) - (4)].string));}
    break;

  case 32:
#line 69 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(2) - (4)].string)) + 20 + strlen((yyvsp[(4) - (4)].string))); sprintf((yyval.string), "int %s = %s", (yyvsp[(2) - (4)].string), (yyvsp[(4) - (4)].string)); free((yyvsp[(2) - (4)].string)); free((yyvsp[(4) - (4)].string));}
    break;

  case 33:
#line 70 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(2) - (4)].string)) + 20 + strlen((yyvsp[(4) - (4)].string))); sprintf((yyval.string), "int %s = %s", (yyvsp[(2) - (4)].string), (yyvsp[(4) - (4)].string)); free((yyvsp[(2) - (4)].string)); free((yyvsp[(4) - (4)].string));}
    break;

  case 34:
#line 72 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(2) - (3)].string)) + 3); sprintf((yyval.string), "[%s]", (yyvsp[(2) - (3)].string)); free((yyvsp[(2) - (3)].string));}
    break;

  case 35:
#line 74 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (3)].string)) + strlen((yyvsp[(3) - (3)].string)) + 2); sprintf((yyval.string), "%s,%s", (yyvsp[(1) - (3)].string), (yyvsp[(3) - (3)].string)); free((yyvsp[(1) - (3)].string)); free((yyvsp[(3) - (3)].string));}
    break;

  case 36:
#line 75 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 37:
#line 77 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 2 + tab_qty); sprintf((yyval.string), "%s\n%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); indent((yyval.string), tab_qty); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 38:
#line 78 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 2 + tab_qty);sprintf((yyval.string), "%s\n%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); indent((yyval.string), tab_qty); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 39:
#line 79 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 2 + tab_qty);sprintf((yyval.string), "%s\n%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); indent((yyval.string), tab_qty);free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 40:
#line 80 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 2 + tab_qty);sprintf((yyval.string), "%s\n%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); indent((yyval.string), tab_qty); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 41:
#line 81 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 2 + tab_qty);sprintf((yyval.string), "%s\n%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); indent((yyval.string), tab_qty); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 42:
#line 82 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 1 + tab_qty);sprintf((yyval.string), "%s%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); indent((yyval.string), tab_qty); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 43:
#line 83 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 44:
#line 85 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 2); sprintf((yyval.string), "%s\n%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 45:
#line 86 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 2);sprintf((yyval.string), "%s\n%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 46:
#line 87 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 2);sprintf((yyval.string), "%s\n%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 47:
#line 88 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 2);sprintf((yyval.string), "%s\n%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 48:
#line 89 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 2);sprintf((yyval.string), "%s\n%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 49:
#line 90 "example.y"
    {(yyval.string) = malloc(strlen((yyvsp[(1) - (2)].string)) +  strlen((yyvsp[(2) - (2)].string)) + 1);sprintf((yyval.string), "%s%s", (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].string)); free((yyvsp[(1) - (2)].string)); free((yyvsp[(2) - (2)].string));}
    break;

  case 50:
#line 91 "example.y"
    {(yyval.string) = (yyvsp[(1) - (1)].string);}
    break;

  case 51:
#line 93 "example.y"
    {(yyval.string) = strdup("");}
    break;


/* Line 1267 of yacc.c.  */
#line 1694 "example.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (result, YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (result, yymsg);
	  }
	else
	  {
	    yyerror (result, YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval, result);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp, result);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (result, YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval, result);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp, result);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 94 "example.y"


int yywrap()
{
    return 1;
} 

int main() {
    FILE * outfile = fopen("out.py", "w");
    char * result; // esta bien que no este inicializada, se inicializa en yyparse
    int error = yyparse(&result);
    if(error){
        return error;
    }
    fprintf(outfile,"import numpy as np\n"
                    "import simpleaudio as sa\n"
                    "import threading\n"
                    "import time\n"
                    "\n"
                    "# calculate note frequencies\n"
                    "A_freq = 440 # A4 (Hz)\n"
                    "\n"
                    "def freq(distance_from_a4):\n"
                    "    return A_freq * 2 ** (distance_from_a4/12)\n"
                    "\n"
                    "A4_freq = freq(0)\n"
                    "Ash4_freq = freq(1)\n"
                    "B4_freq = freq(2)\n"
                    "C4_freq = freq(-9)\n"
                    "Csh4_freq = freq(-20)\n"
                    "D4_freq = freq(-7)\n"
                    "Dsh4_freq = freq(-6)\n"
                    "E4_freq = freq(-5)\n"
                    "F4_freq = freq(-4)\n"
                    "Fsh4_freq = freq(-3)\n"
                    "G4_freq = freq(-2)\n"
                    "Gsh4_freq = freq(-1)\n"
                    "\n"
                    "sample_rate = 44100 # never change\n"
                    "\n"
                    "# generate sine wave notes\n"
                    "def note(freq, duration):\n"
                    "\tt = np.linspace(0, duration, int(duration * sample_rate) , False) # lista de T*sample_rate numeros en el intervalo [0 a T)\n"
                    "\treturn np.sin(freq * t * 2 * np.pi)\n"
                    "\n"
                    "def addnote(audio, from_index, freq, duration):\n"
                    "\tn = int(sample_rate * duration)\n"
                    "\taudio[from_index: from_index + n] += note(freq, duration)[from_index: from_index + n]\n"
                    "\n"
                    "def chord(freq1, freq2, freq3, duration, freq4=0):\n"
                    "\t# mix audio together\n"
                    "\taudio = np.zeros(int(sample_rate * duration))\n"
                    "\taddnote(audio, 0, freq1, duration)\n"
                    "\taddnote(audio, 0, freq2, duration)\n"
                    "\taddnote(audio, 0, freq3, duration)\n"
                    "\taddnote(audio, 0, freq4, duration)\n"
                    "\n"
                    "\t# normalize to 16-bit range\n"
                    "\taudio *= 32767 / np.max(np.abs(audio))\n"
                    "\treturn audio\n"
                    "\n"
                    "def play(chords, volume):\n"
                    "\t# start playback\n"
                    "\tn = 0\n"
                    "\tfor chord in chords:\n"
                    "\t\tn+= len(chord)\n"
                    "\tfinal_sound = np.zeros(n)\n"
                    "\toffset = 0\n"
                    "\tfor chord in chords:\n"
                    "\t\tchord_with_volume = chord*volume[offset: offset + len(chord)]\n"
                    "\t\tfinal_sound[offset : offset + len(chord_with_volume)] = chord_with_volume[0:len(chord_with_volume)]\n"
                    "\t\toffset += len(chord)\n"
                    "\tplay_obj = sa.play_buffer(final_sound.astype(np.int16), 2, 2, sample_rate)\n"
                    "\n"
                    "\t# wait for playback to finish before exiting\n"
                    "\tplay_obj.wait_done()\n"
                    "\treturn\n\n%s\n", result);
    free(result);
    fclose(outfile);
    return 0;
}

void yyerror (char ** result, const char *s){
  printf ("%s\n", s);
  exit(1);
}

void indent(char* s, int n){
    for (int i = 0; i < n; i++){
        memmove(s + 1, s, strlen(s) + 1);
        memcpy(s, "\t", 1);
    }
}
