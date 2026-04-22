[README.md](https://github.com/user-attachments/files/26989896/README.md)
# Impact des Dépenses Publiques en Éducation sur la Scolarisation en Afrique
### Une Analyse Économétrique sur Données de Panel (2000-2022)

**Auteur :** Sanogo Mamadou  
**Programme :** Master 2 Économie Agricole  
**Institution :** Université Félix Houphouët-Boigny de Cocody, Abidjan, Côte d'Ivoire  
**Outils :** SQL · Stata 15 · Power BI  
**Données :** Banque Mondiale · UNDP  
**Période :** 2000 – 2022  
**Couverture :** 54 pays africains  

---

## 1. Contexte et Motivation

L'éducation constitue l'un des piliers fondamentaux du développement économique et social. En Afrique subsaharienne, malgré des progrès notables depuis les années 2000, les taux de scolarisation demeurent insuffisants et inégalement répartis entre régions et pays. Selon la Banque Mondiale, près de 90 millions d'enfants africains en âge scolaire ne fréquentent pas l'école primaire, et les disparités entre zones urbaines et rurales restent considérables.

Face à ce constat, une question centrale émerge : **les dépenses publiques en éducation constituent-elles un levier efficace pour améliorer l'accès à la scolarisation en Afrique ?**

Ce projet s'inscrit dans le cadre de ma formation en économie agricole et de mon intérêt pour l'évaluation des politiques publiques en Afrique. Il vise à appliquer des méthodes économétriques rigoureuses pour mesurer l'effet causal des investissements publics en éducation sur les résultats scolaires, en tenant compte des spécificités des économies africaines.

---

## 2. Question de Recherche

**Question principale :**  
Une hausse des dépenses publiques en éducation (% du PIB) améliore-t-elle significativement les taux de scolarisation primaire et secondaire en Afrique ?

**Questions secondaires :**
- Cet effet varie-t-il selon les régions africaines ?
- Les effets sont-ils différents pour la scolarisation primaire et secondaire ?
- Quel modèle économétrique est le plus adapté à ces données (effets fixes vs effets aléatoires) ?

---

## 3. Revue de Littérature

De nombreux travaux ont exploré la relation entre dépenses publiques en éducation et résultats scolaires. Plusieurs études montrent qu'une augmentation des dépenses publiques en éducation est positivement associée aux taux de scolarisation, bien que l'efficacité de ces dépenses dépende fortement du contexte institutionnel et de la qualité de la gouvernance.

En Afrique, des études sur données de panel suggèrent que les dépenses en éducation ont un effet significatif sur la scolarisation primaire, mais cet effet est plus faible pour le secondaire en raison de contraintes structurelles (infrastructures, enseignants, revenus des ménages).

---

## 4. Sources de Données

| Source | Indicateur | Code |
|---|---|---|
| Banque Mondiale | Dépenses publiques en éducation (% PIB) | SE.XPD.TOTL.GD.ZS |
| Banque Mondiale | Taux brut de scolarisation primaire | SE.PRM.ENRR |
| Banque Mondiale | Taux brut de scolarisation secondaire | SE.SEC.ENRR |
| Banque Mondiale | Taux d'alphabétisation adultes | SE.ADT.LITR.ZS |
| UNDP | Indice de Développement Humain | HDI 2023 |

**Couverture géographique :** 54 pays africains (Afrique du Nord, Ouest, Est, Centrale, Australe)  
**Couverture temporelle :** 2000 – 2022  
**Format :** Données de panel non cylindré (unbalanced panel)

---

## 5. Statistiques Descriptives

| Variable | Observations | Moyenne | Écart-type | Min | Max |
|---|---|---|---|---|---|
| Dépenses éducation (% PIB) | 840 | 3.94 | 2.05 | 0.00 | 13.22 |
| Scolarisation primaire (%) | 946 | 99.27 | 21.66 | 22.79 | 163.17 |
| Scolarisation secondaire (%) | 701 | 48.50 | 25.42 | 5.94 | 112.31 |
| Taux d'alphabétisation (%) | 232 | 63.17 | 19.69 | 14.38 | 97.27 |

**Couverture des données par région :**
- Afrique de l'Ouest : 80% des données disponibles
- Afrique de l'Est : 63% des données disponibles
- Afrique Centrale : 67% des données disponibles
- Afrique du Nord : 43% des données disponibles
- Afrique Australe : 68% des données disponibles

---

## 6. Méthodologie

### 6.1 Constitution de la base de données (SQL)

La base de données a été construite sous SQLite (DB Browser) en suivant une approche relationnelle :
- **Table `pays`** : informations fixes par pays (code ISO, région, HDI)
- **Table `indicateurs`** : données annuelles par pays (format panel)
- **Vue `analyse_finale`** : jointure des deux tables pour l'analyse

### 6.2 Analyse économétrique (Stata 15)

Trois modèles ont été estimés de manière progressive :

**Modèle 1 — MCO simple (OLS)**
```
scol_prim = β0 + β1 * dep_edu + ε
```

**Modèle 2 — MCO avec variables de contrôle**
```
scol_prim = β0 + β1 * dep_edu + β2 * hdi + β3 * gni + ε
```

**Modèle 3 — Effets fixes (Within estimator)**
```
scol_prim_it = β1 * dep_edu_it + αi + εit
```
où αi capture les effets non observés propres à chaque pays (géographie, histoire, culture).

**Modèle 4 — Effets aléatoires**
```
scol_prim_it = β0 + β1 * dep_edu_it + ui + εit
```

**Test de Hausman** : utilisé pour choisir entre effets fixes et effets aléatoires.

### 6.3 Visualisation (Power BI)

Un dashboard interactif a été construit avec 4 visuels :
- Carte des dépenses éducation par pays
- Évolution temporelle par région
- Nuage de points dépenses vs scolarisation
- Comparaison régionale des dépenses

---

## 7. Résultats

### 7.1 Test de Hausman
- **chi2(1) = 0.07 | Prob > chi2 = 0.7910**
- **Conclusion :** Le modèle à effets aléatoires est retenu (p-value > 0.05)

### 7.2 Résultats des régressions

| Modèle | Coefficient dep_edu | p-value | R² |
|---|---|---|---|
| MCO Simple | Positif et significatif | < 0.05 | Faible |
| MCO Contrôlé | Positif et significatif | < 0.05 | Modéré |
| Effets Fixes | **3.279** | < 0.05 | — |
| Effets Aléatoires | **3.313** | < 0.05 | — |

**Interprétation principale :**
> Une hausse de 1 point de pourcentage des dépenses publiques en éducation (% PIB) est associée à une augmentation d'environ **3.3 points** du taux brut de scolarisation primaire en Afrique, toutes choses égales par ailleurs.

---

## 8. Conclusions

Les résultats confirment qu'il existe une relation positive et statistiquement significative entre les dépenses publiques en éducation et les taux de scolarisation primaire en Afrique. Cet effet est robuste aux différentes spécifications économétriques testées.

Cependant, plusieurs nuances méritent d'être soulignées :
- L'effet est plus fort pour la scolarisation primaire que secondaire
- Les données sur l'alphabétisation sont trop lacunaires pour des conclusions solides
- Des facteurs non observés propres à chaque pays jouent un rôle important

---

## 9. Recommandations de Politique Économique

1. **Augmenter les budgets éducation** vers le seuil recommandé par l'UNESCO de 6% du PIB — la moyenne africaine n'est que de 3.9%
2. **Cibler l'Afrique Centrale** qui combine faibles dépenses et faibles taux de scolarisation
3. **Améliorer l'efficacité** des dépenses pas uniquement leur volume (formation des enseignants, infrastructures)
4. **Renforcer les systèmes statistiques** africains pour combler les lacunes dans les données
5. **Politiques complémentaires** : bourses scolaires, cantines, réduction des coûts indirects

---

## 10. Structure du Projet

```
projet-education-afrique/
├── data/
│   ├── base_finale_complete.csv    # Base fusionnée (54 pays x 23 ans)
│   ├── analyse_finale.csv          # Export SQL pour Stata
│   └── base_education.dta          # Base Stata
├── sql/
│   ├── 01_creation_tables.sql      # Création des tables relationnelles
│   ├── 02_import_nettoyage.sql     # Import et nettoyage
│   └── 03_analyse.sql              # Requêtes descriptives + vue finale
├── stata/
│   ├── 01_import_exploration.do    # Import, exploration, graphiques
│   └── 02_regressions.do           # Régressions panel
├── powerbi/
│   └── dashboard_education.pbix   # Dashboard interactif
└── README.md
```

---

## 11. Limites de l'Étude

- Données manquantes importantes pour certains pays et certaines variables
- L'IDH utilisé est celui de 2023 (pas de série temporelle disponible)
- Possible problème d'endogénéité : les pays qui scolarisent plus peuvent aussi dépenser plus
- Hétérogénéité non observée entre pays non entièrement capturée

---

---

## 📝 Nota Bene — Tests de Stationnarité et Stratégie Économétrique

### NB.1 — Tests de Racine Unitaire (Fisher-ADF)

Avant d'estimer les régressions, des tests de stationnarité ont été réalisés sur toutes les variables via le test de Fisher basé sur le test de Dickey-Fuller Augmenté (ADF), adapté aux données de panel.

| Variable | p-value (Pm) | Ordre d'intégration | Décision |
|---|---|---|---|
| `scol_prim` | **0.0000** | **I(0)** | ✅ Stationnaire en niveaux |
| `scol_sec` | **0.8058** | **I(1)** | ⚠️ Non stationnaire → différenciée |
| `dep_edu` | **0.1745** | **I(1)** | ⚠️ Non stationnaire → différenciée |
| `alpha` | — | Non testable | ❌ Trop de valeurs manquantes (83%) |

**Règle de décision :** p-value < 0.05 → rejet de H0 (présence de racine unitaire) → variable stationnaire.

### NB.2 — Conséquences sur la Stratégie d'Estimation

Les variables `dep_edu` et `scol_sec` étant toutes deux intégrées d'ordre 1 — I(1) — un test de cointégration de Pedroni a été tenté. Cependant, le nombre insuffisant d'observations disponibles pour `scol_sec` (56% de données manquantes) n'a pas permis de conclure sur l'existence d'une relation de long terme.

En conséquence, la stratégie économétrique retenue est la suivante :

**Pour `scol_prim` [I(0)] :**
- Régression en **niveaux** avec effets fixes (within estimator)
- Valide car la variable est stationnaire

**Pour `scol_sec` [I(1)] :**
- Régression en **premières différences** avec `d_dep_edu`
- Permet d'éviter les régressions spurieuses

### NB.3 — Résultats après Correction pour la Stationnarité

**Modèle 1 — Effets fixes en niveaux (variable : scol_prim)**

| Variable | Coefficient | Écart-type | t | p-value |
|---|---|---|---|---|
| dep_edu | **3.279** | 0.414 | 7.93 | **0.000** |
| Constante | 87.005 | 1.718 | 50.64 | 0.000 |

- R² within = 0.0907 | R² overall = 0.1289
- Nombre d'observations : 681 | Nombre de pays : 50
- **Conclusion :** Effet positif et significatif — une hausse de 1% des dépenses éducation augmente la scolarisation primaire de **3.28 points**

**Modèle 2 — Effets fixes en différences premières (variable : d_scol_sec)**

| Variable | Coefficient | Écart-type | t | p-value |
|---|---|---|---|---|
| d_dep_edu | **-0.012** | 0.165 | -0.07 | **0.942** |

- R² within = 0.0000 | Prob > F = 0.9415
- Nombre d'observations : 364 | Nombre de pays : 43
- **Conclusion :** Effet **non significatif** — les variations des dépenses éducation n'ont pas d'effet détectable sur la scolarisation secondaire, probablement en raison des données lacunaires

### NB.4 — Interprétation Économique

Ces résultats suggèrent que les dépenses publiques en éducation ont un effet positif et robuste sur la scolarisation **primaire** en Afrique, mais pas sur le secondaire à court terme. Cela peut s'expliquer par :
- La scolarisation primaire est plus sensible aux politiques publiques car moins coûteuse
- La scolarisation secondaire dépend davantage des revenus des ménages et des infrastructures
- Les données lacunaires sur le secondaire limitent la puissance statistique des tests

---

*Projet réalisé dans le cadre du Master 2 Économie Agricole — UFHB Cocody, Abidjan*
