#include <stdlib.h>
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .C calls */
extern void CWrapper_encoding_isbig5(char **, int *);
extern void CWrapper_encoding_isgbk(char **, int *);
extern void CWrapper_encoding_isgb18030(char **, int *);
extern void CWrapper_encoding_isgb2312(char **, int *);
extern void CWrapper_encoding_isutf8(char **, int *);

static const R_CMethodDef CEntries[] = {
    {"CWrapper_encoding_isbig5", (DL_FUNC) &CWrapper_encoding_isbig5, 2},
    {"CWrapper_encoding_isgbk", (DL_FUNC) &CWrapper_encoding_isgbk, 2},
    {"CWrapper_encoding_isgb18030", (DL_FUNC) &CWrapper_encoding_isgb18030, 2},
    {"CWrapper_encoding_isgb2312", (DL_FUNC) &CWrapper_encoding_isgb2312, 2},
    {"CWrapper_encoding_isutf8", (DL_FUNC) &CWrapper_encoding_isutf8, 2},
    {NULL, NULL, 0}
};

void R_init_rLTP(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, NULL, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
