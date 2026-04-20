* Configurar el entorno
clear all
set more off

**# Bookmark #1: PBI X DEPARTAMENTO
**********************************************************************************
* Pbi a precios constantes 2007 en miles de soles
import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\pbi_xdepar.xlsx", sheet("Cuadro1") cellrange(A7:S35) firstrow clear

drop if B==.
drop if Departamentos=="Prov. Const. del Callao" | Departamentos=="Región Lima" | Departamentos=="Provincia de Lima"
drop B
format C-S %15.0f

local anio = 2008
foreach var of varlist C-S {
    rename `var' pbi`anio'
    local anio = `anio' + 1
}
rename Departamentos departamento
reshape long pbi, i(departamento) j(anio)

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\pbi_total.dta", replace

**# Bookmark #2: Población X DEPARTAMENTO
**********************************************************************************
* Población estimada x departamento
import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\pob_estimada.xlsx", sheet("Total") cellrange(A1:S29) firstrow clear

drop if C==.
drop if Departamento=="Prov. Const. del Callao " | Departamento=="Perú"

local anio = 2008
foreach var of varlist C-S {
    rename `var' pob`anio'
    local anio = `anio' + 1
}

rename Departamento departamento
reshape long pob, i(departamento) j(anio)
sort departamento

replace departamento="Piura" if departamento=="Piura "
replace departamento="Cajamarca" if departamento=="Cajamarca "
replace departamento="Huánuco" if departamento=="Huánuco "

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\pob_estimada.dta", replace

**# Bookmark #3: Inversión X DEPARTAMENTO
**********************************************************************************
* Inversión bruta fija del gobierno nacional por departamentos (millones S/)
import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\inversion_update.xlsx", sheet("Anuales2") cellrange(A1:R26) firstrow clear

drop if departamento=="Callao"

local anio = 2008
foreach var of varlist B-R {
    rename `var' inv`anio'
    local anio = `anio' + 1
}

reshape long inv, i(departamento) j(anio)
sort departamento
rename inv inversion

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\inversion.dta", replace

**# Bookmark #4: Crédito X DEPARTAMENTO
**********************************************************************************
* Crédito directo del sistema financiero al sector privado por departamentos - fin de periodo (millones S/)

import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\credito_update.xlsx", sheet("Anuales2") cellrange(A1:R25) firstrow clear


local anio = 2008
foreach var of varlist B-R {
    rename `var' cred`anio'
    local anio = `anio' + 1
}

reshape long cred, i(departamento) j(anio)
sort departamento
rename cred credito

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\credito.dta", replace

**# Bookmark #5: Tasa de matrícula X DEPARTAMENTO
**********************************************************************************
* PERÚ: TASA NETA DE MATRÍCULA DE LA POBLACIÓN DE 12 A 16 AÑOS DE EDAD, A EDUCACIÓN SECUNDARIA, SEGÚN ÁMBITO GEOGRÁFICO, 2008-2024

import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\tasa_matricula_12-16.xlsx", sheet("cd1_final") cellrange(A4:R31) firstrow clear

drop if B==.
drop if Departamento=="Prov. Const. Callao"

local anio = 2008
foreach var of varlist B-R {
    rename `var' matric`anio'
    local anio = `anio' + 1
}

rename Departamento departamento
reshape long matric, i(departamento) j(anio)
sort departamento
rename matric tasa_mat

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\tasa_mat.dta", replace


**# Bookmark #6: Esperanza de vida mujeres X DEPARTAMENTO
**********************************************************************************
* PERÚ: Esperanza de vida al nacer de mujeres, según departamento	(en años quinquenales)	

import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\esperanza_vida.xlsx", sheet("e_vida_fem") cellrange(A2:S27) firstrow clear

drop if Departamento=="Prov. Const. del Callao"
drop B

local anio = 2008
foreach var of varlist C-S {
    rename `var' e_vida`anio'
    local anio = `anio' + 1
}

rename Departamento departamento
reshape long e_vida, i(departamento) j(anio)
sort departamento
rename e_vida e_vida_fem

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\e_vida_fem.dta", replace


**# Bookmark #7: Esperanza de vida hombres X DEPARTAMENTO
**********************************************************************************
* PERÚ: Esperanza de vida al nacer de hombres, según departamento	(en años quinquenales)	

import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\esperanza_vida.xlsx", sheet("e_vida_mas") cellrange(A2:S27) firstrow clear

drop if Departamento=="Prov. Const. del Callao"
drop B

local anio = 2008
foreach var of varlist C-S {
    rename `var' e_vida`anio'
    local anio = `anio' + 1
}

rename Departamento departamento
reshape long e_vida, i(departamento) j(anio)
sort departamento
rename e_vida e_vida_mas

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\e_vida_mas.dta", replace


**# Bookmark #8: Tasa de actividad X DEPARTAMENTO
**********************************************************************************
* TASA DE ACTIVIDAD, SEGÚN ÁMBITO GEOGRÁFICO,  2007 - 2021	

import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\tasa_actividad.xlsx", sheet("tasa_actividad") cellrange(A2:S27) firstrow clear

drop if Departamento=="Callao"
drop B

local anio = 2008
foreach var of varlist C-S {
    rename `var' t_act`anio'
    local anio = `anio' + 1
}

rename Departamento departamento
destring t_act2022 t_act2023 t_act2024, replace
reshape long t_act, i(departamento) j(anio)
sort departamento

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_act.dta", replace


**# Bookmark #9: Tasa de actividad femenina X DEPARTAMENTO
**********************************************************************************
* TASA DE ACTIVIDAD FEMENINA, SEGÚN ÁMBITO GEOGRÁFICO,  2007 - 2021	

import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\tasa_actividad_genero.xlsx", sheet("t_act_fem") cellrange(A2:S27) firstrow clear

drop if Departamento=="Callao"
drop B

local anio = 2008
foreach var of varlist C-S {
    rename `var' t_act`anio'
    local anio = `anio' + 1
}

rename Departamento departamento
destring t_act2022 t_act2023 t_act2024, replace
reshape long t_act, i(departamento) j(anio)
sort departamento
rename t_act t_act_fem

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_act_fem.dta", replace


**# Bookmark #10: Tasa de actividad masculina X DEPARTAMENTO
**********************************************************************************
* TASA DE ACTIVIDAD MASCULINA, SEGÚN ÁMBITO GEOGRÁFICO,  2007 - 2021	

import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\tasa_actividad_genero.xlsx", sheet("t_act_mas") cellrange(A2:S27) firstrow clear

drop if Departamento=="Callao"
drop B

local anio = 2008
foreach var of varlist C-S {
    rename `var' t_act`anio'
    local anio = `anio' + 1
}

rename Departamento departamento
destring t_act2022 t_act2023 t_act2024, replace
reshape long t_act, i(departamento) j(anio)
sort departamento
rename t_act t_act_mas

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_act_mas.dta", replace



**# Bookmark #11: Tasa de informalidad X DEPARTAMENTO
**********************************************************************************
* TASA DE EMPLEO INFORMAL, SEGÚN ÁMBITO GEOGRÁFICO,  2008 - 2021	

import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\tasa_informalidad.xlsx", sheet("t_informalidad") cellrange(A2:S27) firstrow clear

drop if Departamento=="Callao"
drop B

local anio = 2008
foreach var of varlist C-S {
    rename `var' t_inf`anio'
    local anio = `anio' + 1
}

rename Departamento departamento
destring t_inf2022 t_inf2023 t_inf2024, replace
reshape long t_inf, i(departamento) j(anio)
sort departamento
rename t_inf t_informal

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_informal.dta", replace

**# Bookmark #12: Tasa de informalidad mujeres X DEPARTAMENTO
**********************************************************************************
* TASA DE INFORMALIDAD EN MUJERES, SEGÚN ÁMBITO GEOGRÁFICO,  2008 - 2021	

import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\tasa_informalidad_genero.xlsx", sheet("t_informal_fem") cellrange(A2:S27) firstrow clear

drop if Departamento=="Callao"
drop B

local anio = 2008
foreach var of varlist C-S {
    rename `var' t_inf`anio'
    local anio = `anio' + 1
}

rename Departamento departamento
destring t_inf2022 t_inf2023 t_inf2024, replace
reshape long t_inf, i(departamento) j(anio)
sort departamento
rename t_inf t_informal_fem

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_informal_fem.dta", replace


**# Bookmark #13: Tasa de informalidad hombres X DEPARTAMENTO
**********************************************************************************
* TASA DE INFORMALIDAD EN HOMBRES, SEGÚN ÁMBITO GEOGRÁFICO,  2008 - 2021	

import excel "C:\Users\Lenovo\Downloads\tesis_ul\xls\tasa_informalidad_genero.xlsx", sheet("t_informal_mas") cellrange(A2:S27) firstrow clear

drop if Departamento=="Callao"
drop B

local anio = 2008
foreach var of varlist C-S {
    rename `var' t_inf`anio'
    local anio = `anio' + 1
}

rename Departamento departamento
destring t_inf2022 t_inf2023 t_inf2024, replace
reshape long t_inf, i(departamento) j(anio)
sort departamento
rename t_inf t_informal_mas

save "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_informal_mas.dta", replace



**# Bookmark #14: Unión de bases
**********************************************************************************

use "C:\Users\Lenovo\Downloads\tesis_ul\dta\pbi_total.dta", clear
merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\pob_estimada.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\inversion.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\credito.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\tasa_mat.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\e_vida_fem.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\e_vida_mas.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_act.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_act_fem.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_act_mas.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_informal.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_informal_fem.dta"
drop _merge

merge 1:1 departamento anio using "C:\Users\Lenovo\Downloads\tesis_ul\dta\t_informal_mas.dta"
drop _merge

order departamento Ubigeo anio


save "C:\Users\Lenovo\Downloads\tesis_ul\dta\panel_data.dta", replace




