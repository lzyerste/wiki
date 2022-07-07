---
title: int_myintarray[2];_module_param_array_myintarray,__5b05629fbea342fe86c125ccd0f78140
---

# int myintarray[2];
module_param_array(myintarray, int, NULL, 0); /* not interested in count */

int myshortarray[4];
int count;
module_parm_array(myshortarray, short, , 0); /* put count into "count" variable */