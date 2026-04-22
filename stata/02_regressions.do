* ============================================================
* PROJET 2 : Impact des dépenses de santé en Afrique
* SCRIPT   : 02 - Régressions
* ============================================================

clear all
set more off

use "C:/Users/Chiami/Desktop/base_sante.dta", clear
xtset id_pays annee

* RÉGRESSION 1 : MCO simple
* Dépenses santé → Mortalité infantile
regress mort_inf dep_sante

* RÉGRESSION 2 : MCO simple
* Dépenses santé → Espérance de vie
regress esp_vie dep_sante

* RÉGRESSION 3 : Effets fixes - Mortalité infantile
xtreg mort_inf dep_sante, fe

* RÉGRESSION 4 : Effets fixes - Espérance de vie
xtreg esp_vie dep_sante, fe

* RÉGRESSION 5 : Effets aléatoires
xtreg mort_inf dep_sante, re

* TEST DE HAUSMAN
quietly xtreg mort_inf dep_sante, fe
estimates store fe

quietly xtreg mort_inf dep_sante, re
estimates store re

hausman fe re

* Exporter pour Power BI
export delimited "C:/Users/Chiami/Desktop/data_powerbi_sante.csv", replace
