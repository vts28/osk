/************************************************************************
** Example Table 2
**
*/

#include "example_tbldefs.h"
#include "cfe_tbl_filedef.h"

EXAMPLE_Tbl_2_t EXAMPLE_Tbl_2 = { 3, 2, 1 };

/*
** Table file header
**
** Macro parameters:
**   1. Table structure type
**   2. Name of table to be placed in the cFE Table File Header (App name must match name used in ES startup script)
**   3. A brief description of the table
**   4. Name of table created by the 'make' build process. Must match name used in call to CFE_TBL_Load() and the
**      base filename must match the C source base filename
*/

CFE_TBL_FILEDEF(EXAMPLE_Tbl_2, EXAMPLE.MySecondTbl, My Second Tbl, example_tbl_2.tbl)

/************************/
/*  End of File Comment */
/************************/
