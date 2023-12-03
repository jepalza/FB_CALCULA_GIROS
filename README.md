# FB_CALCULA_GIROS
FreeBasic para calcular GIROS AC en máquinas CNC a partir de cosenos directores del plano inclinado

Rutinas matemáticas para obtener los giros necesarios en cabezales de máquinas CNC tipa AC y BC.

Este ejemplo se desarrollo específicamente para su uso en máquina CORREA CNC FP30/40 y el uso de los cosenos directores que se obtienen en el programa de CAD TEBIS,Ag. 

Pero es aplicable a cientos de modelos, dado que es universal.
El programa tiene integrados 4 ejemplos de giros, que con solo escribir 1,2,3 o 4 y pulsar la tecla "Enter" podemos verlos.
Los cosenos directores son un grupo de 3*3 valores que indican los 3 giros del eje del plano inclinado respecto al eje plano principal

Por ejemplo, para un giro muy comun de A45 C45
 X1= 0.707: Y1= 0.707: Z1= 0.000
 X2=-0.500: Y2= 0.500: Z2= 0.707
 X3= 0.500: Y3=-0.500: Z3= 0.707
 
Ademas, el programa, da el eje redondeado a 2.5 grados, para maquinas con cabezales que solo giran de 2.5 en 2.5 

