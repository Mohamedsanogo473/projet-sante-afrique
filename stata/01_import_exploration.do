* ============================================================
* PROJET 2 : Impact des dépenses de santé en Afrique
* SCRIPT   : 01 - Import et exploration
* AUTEUR   : Sanogo Mamadou
* ============================================================

clear all
set more off

* Importer le CSV
import delimited "C:/Users/Chiami/Desktop/analyse_sante.csv", ///
    clear varnames(1) encoding(UTF-8)

* Voir les variables
describe

* Renommer les variables
rename country_code       code_pays
rename country_name       pays
rename annee              annee
rename depenses_sante_pib dep_sante
rename mortalite_infantile mort_inf
rename esperance_vie       esp_vie
rename mortalite_maternelle mort_mat

* Déclarer le panel
encode code_pays, gen(id_pays)
xtset id_pays annee

* Statistiques descriptives
summarize dep_sante mort_inf esp_vie mort_mat

* Sauvegarder
save "C:/Users/Chiami/Desktop/base_sante.dta", replace
