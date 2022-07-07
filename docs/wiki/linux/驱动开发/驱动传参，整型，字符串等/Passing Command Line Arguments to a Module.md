---
title: Passing_Command_Line_Arguments_to_a_Module
---

# Passing Command Line Arguments to a Module

[https://tldp.org/LDP/lkmpg/2.6/html/x323.html](https://tldp.org/LDP/lkmpg/2.6/html/x323.html)

Modules can take command line arguments, but not with the argc/argv you might be used to.

To allow arguments to be passed to your module, declare the variables that will take the values of the command line arguments as global and then use the module_param() macro, (defined in linux/moduleparam.h) to set the mechanism up. At runtime, insmod will fill the variables with any command line arguments that are given, like **./insmod mymodule.ko myvariable=5**. The variable declarations and macros should be placed at the beginning of the module for clarity. The example code should clear up my admittedly lousy explanation.

The module_param() macro takes 3 arguments: the name of the variable, its type and permissions for the corresponding file in sysfs. Integer types can be signed as usual or unsigned. If you'd like to use arrays of integers or strings see module_param_array() and module_param_string().

[Untitled](assets/Untitled%20Database%20b3695e0655a24092b008dfac4f16ff21.csv)

Arrays are supported too, but things are a bit different now than they were in the 2.4. days. To keep track of the number of parameters you need to pass a pointer to a count variable as third parameter. At your option, you could also ignore the count and pass NULL instead. We show both possibilities here:

[Untitled](assets/Untitled%20Database%2003ce2a7082ca492fbd424dea35b518eb.csv)

A good use for this is to have the module variable's default values set, like an port or IO address. If the variables contain the default values, then perform autodetection (explained elsewhere). Otherwise, keep the current value. This will be made clear later on.

Lastly, there's a macro function, MODULE_PARM_DESC(), that is used to document arguments that the module can take. It takes two parameters: a variable name and a free form string describing that variable.

**Example 2-7. hello-5.c**

[Untitled](assets/Untitled%20Database%207bcd9810c8b94385b6ae031a972166b4.csv)

I would recommend playing around with this code:

[Untitled](assets/Untitled%20Database%20a736708e02994dedb336b3e46afcaa0d.csv)