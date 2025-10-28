*PASO 1: Definir las variables individuo y tiempo:
clear all
xtset id year

*PASO 2: Resumen y descripción de los datos:
xtsum pib inversión crédito tasa_mat e_vida t_act_fem t_act_mas t_informal_f t_informal_m t_subemp_f t_subemp_m

*PASO 3: gráficos //
xtline pib
xtline inversión
xtline crédito
xtline tasa_mat
xtline e_vida
xtline t_act_fem
xtline t_act_mas
xtline t_informal_f
xtline t_informal_m
xtline t_subemp_f
xtline t_subemp_m

*PASO 4:Histograma para saber si se usa logaritmo
hist pib, normal
gen lpib = log(pib)
hist lpib, normal

hist inversión, normal
gen linversión = log(inversión)
hist linversión, normal

hist crédito, normal
gen lcrédito = log(crédito)
hist lcrédito, normal

hist tasa_mat, normal
hist e_vida, normal
hist t_act_fem, normal
hist t_act_mas, normal
hist t_informal_f, normal
hist t_informal_m, normal
hist t_subemp_f, normal
hist t_subemp_m, normal

*PASO 5: uroot / test de raíz unitaria

xtunitroot llc lpib
xtunitroot ips lpib

xtunitroot llc linversión
xtunitroot ips linversión

xtunitroot llc lcrédito
xtunitroot ips lcrédito

xtunitroot llc tasa_mat
xtunitroot ips tasa_mat

xtunitroot llc e_vida
xtunitroot ips e_vida

xtunitroot llc t_act_fem
xtunitroot ips t_act_fem

xtunitroot llc t_act_mas
xtunitroot ips t_act_mas

xtunitroot llc t_informal_f
xtunitroot ips t_informal_f

xtunitroot llc t_informal_m
xtunitroot ips t_informal_m

xtunitroot llc t_subemp_f
xtunitroot ips t_subemp_f

xtunitroot llc t_subemp_m
xtunitroot ips t_subemp_m


*para hacer diferencias
xtunitroot llc d.gestion

*PASO 6: correlación
corr lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f
corr lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m


*PASO 7: *Creando la variable en logaritmos (dependiendo si sale el histograma anormal) según Edwuard(1985) - en función a 
// si la variable muestra una distribución no normal
gen lpib = log(pib)
gen linversión = log(inversión)
gen lcrédito = log(crédito)

*se vuelve a hacer la prueba de levin


*PASO 8: modelo panel data departamentos ricos vs pobres (M1 y M2)
***********************************************************************
*M1:mayores ingresos--------------------------
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, fe
estimate store fixed

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, re
estimate store random

hausman fixed random

hausman fixed random, sigmamore

*con menos variables
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem, fe
estimate store fixed

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem, re
estimate store random

hausman fixed random


*pruebas de heterocedasticidad y autocorrelación // xttest3 siempre debe ir después del
//"xtreg" o "xtgls"
xtserial lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, output
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, fe
xttest3


*modelo corregido
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, fe robust
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem, fe robust


*prueba multicolinealidad
reg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f
vif


*M2:menores ingresos-------------------------------------------------------
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem, fe
estimate store fixed

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem, re
estimate store random

hausman fixed random

*pruebas de heterocedasticidad y autocorrelación // xttest3 siempre debe ir después del
//"xtreg" o "xtgls"
xtserial lpib linversión crédito tasa_mat e_vida t_act_fem, output
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem, fe 
xttest3

*modelo corregido
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem, re robust

*modelo hombres corregido
xtreg lpib linversión lcrédito tasa_mat e_vida t_informal_m, re robust

*prueba de multicolinealidad
reg lpib linversión lcrédito tasa_mat e_vida t_act_fem
vif

*************************************************************************
* modelo usando las regiones del Perú (M3, M4 y M5)

*M3:costa-------------------------- el resultado es efectos aleatorios

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, fe
estimate store fixed

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, re
estimate store random

hausman fixed random


*pruebas de heterocedasticidad y autocorrelación // xttest3 siempre debe ir después del
//"xtreg" o "xtgls"
xtserial lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, output
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, fe 
xttest3

*prueba multicolinealidad
reg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f
vif

*modelo con efectos aleatorios corregido
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_subemp_f, re robust

*modelo 3 con tasa de actividad masculina - efectos fijos
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, fe
estimate store fixed

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, re
estimate store random

hausman fixed random, sigmamore

xtserial lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, output
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, fe 
xttest3

reg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m
vif

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, fe robust


*M4:sierra-------------------------- el resultado es efectos fijos

*test de hausman -resultado efectos fijos
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, fe
estimate store fixed

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, re
estimate store random

hausman fixed random, sigmamore

*pruebas de heterocedasticidad y autocorrelación: sí tiene ambas
xtserial lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, output
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, fe 
xttest3

*prueba multicolinealidad: no tiene
reg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f
vif

*modelo corregido
xtreg lpib d.linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f d.t_subemp_f, fe robust

*modelo 4 con tasa de actividad masculina - efectos fijos
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, fe
estimate store fixed

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, re
estimate store random

hausman fixed random

xtserial lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, output
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, fe 
xttest3

reg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m
vif

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, fe robust




*M5:selva--------------------------resultado efectos fijos

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, fe
estimate store fixed

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, re
estimate store random

hausman fixed random, sigmamore

*pruebas de heterocedasticidad y autocorrelación // xttest3 siempre debe ir después del
//"xtreg" o "xtgls"
xtserial lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, output
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f, fe 
xttest3


*prueba multicolinealidad
reg lpib linversión lcrédito tasa_mat e_vida t_act_fem t_informal_f t_subemp_f
vif

*nueva prueba de hausman 
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem, fe
estimate store fixed

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_fem, re
estimate store random

hausman fixed random, sigmamore


*modelo corregido
xtreg lpib linversión lcrédito tasa_mat e_vida d.t_act_fem, fe robust
xtreg lpib d.linversión lcrédito d.tasa_mat e_vida d.t_act_fem t_informal_f t_subemp_f, fe robust

*modelo 5 con tasa de actividad masculina - efectos fijos
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, fe
estimate store fixed

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, re
estimate store random

hausman fixed random, sigmamore

xtserial lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, output
xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m, fe 
xttest3

reg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m t_subemp_m
vif

xtreg lpib linversión lcrédito tasa_mat e_vida t_act_mas t_informal_m, fe robust


