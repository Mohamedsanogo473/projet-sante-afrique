[README_projet2 (1).md](https://github.com/user-attachments/files/27030060/README_projet2.1.md)
# Impact des Dépenses Publiques de Santé sur la Mortalité et l'Espérance de Vie en Afrique
### Une Analyse Économétrique sur Données de Panel (2000-2022)

**Auteur :** Sanogo Mamadou  
**Programme :** Master 2 Économie Agricole  
**Institution :** Université Félix Houphouët-Boigny de Cocody, Abidjan, Côte d'Ivoire  
**Outils :** SQL · Stata 15 · Power BI  
**Données :** Banque Mondiale  
**Période :** 2000 – 2022  
**Couverture :** 54 pays africains  

---

## 1. Contexte et Motivation

La santé publique constitue un déterminant essentiel du capital humain et du développement économique. En Afrique, malgré des progrès significatifs depuis les Objectifs du Millénaire pour le Développement (OMD), les indicateurs sanitaires demeurent parmi les plus préoccupants au monde. La mortalité infantile africaine représente environ 50% de la mortalité infantile mondiale, et l'espérance de vie en Afrique subsaharienne reste inférieure de plus de 15 ans à la moyenne mondiale.

En 2001, les chefs d'État africains ont signé la **Déclaration d'Abuja**, s'engageant à consacrer au moins 15% de leur budget national à la santé. Plus de 20 ans après, la majorité des pays africains n'ont pas atteint cet objectif. Ce constat soulève une question fondamentale : **les dépenses publiques de santé sont-elles réellement efficaces pour améliorer les indicateurs sanitaires en Afrique ?**

Ce projet s'inscrit dans ma démarche d'évaluation des politiques publiques africaines, en appliquant des méthodes économétriques rigoureuses sur données de panel pour mesurer l'impact des investissements publics de santé sur la mortalité infantile et l'espérance de vie.

---

## 2. Question de Recherche

**Question principale :**  
Les dépenses publiques de santé (% du PIB) réduisent-elles significativement la mortalité infantile et augmentent-elles l'espérance de vie en Afrique ?

**Questions secondaires :**
- Cet effet varie-t-il selon les régions africaines ?
- Quel est l'effet sur la mortalité maternelle ?
- Le modèle à effets fixes ou effets aléatoires est-il plus adapté ?

---

## 3. Revue de Littérature

La relation entre dépenses publiques de santé et indicateurs sanitaires fait l'objet d'une littérature abondante. Des études sur données de panel africaines montrent généralement un effet négatif significatif des dépenses de santé sur la mortalité infantile, bien que cet effet soit conditionné par la qualité des institutions et la gouvernance.

Certains auteurs soulignent le paradoxe africain : des dépenses de santé élevées ne se traduisent pas toujours par de meilleures performances sanitaires, en raison de problèmes d'efficacité allocative, de corruption et de faiblesse des systèmes de santé primaire.

---

## 4. Sources de Données

| Source | Indicateur | Code |
|---|---|---|
| Banque Mondiale | Dépenses courantes de santé (% PIB) | SH.XPD.CHEX.GD.ZS |
| Banque Mondiale | Taux de mortalité infantile (pour 1000) | SH.DYN.MORT |
| Banque Mondiale | Espérance de vie à la naissance (années) | SP.DYN.LE00.IN |
| Banque Mondiale | Taux de mortalité maternelle (pour 100 000) | SH.STA.MMRT |

**Couverture géographique :** 54 pays africains  
**Couverture temporelle :** 2000 – 2022  
**Format :** Données de panel cylindré (strongly balanced panel)

---

## 5. Statistiques Descriptives

| Variable | Observations | Moyenne | Écart-type | Min | Max |
|---|---|---|---|---|---|
| Dépenses santé (% PIB) | 1202 | 5.02 | 2.14 | 1.22 | 22.11 |
| Mortalité infantile (‰) | 1242 | 83.24 | 48.53 | 10.40 | 489.30 |
| Espérance de vie (ans) | 1242 | 60.01 | 7.68 | 14.67 | 77.24 |
| Mortalité maternelle (‱) | 1242 | 444.71 | 310.00 | 10.00 | 1660.00 |

**Points remarquables :**
- Les données sont quasi complètes (97-100% de couverture) — panel très équilibré
- Forte hétérogénéité entre pays : mortalité infantile de 10 à 489 pour 1000
- L'Afrique du Nord affiche les meilleures performances sanitaires
- L'Afrique Centrale présente les indicateurs les plus préoccupants

---

## 6. Méthodologie

### 6.1 Constitution de la base de données (SQL)

La base de données relationnelle a été construite sous SQLite :
- **Table `pays_sante`** : informations fixes par pays
- **Table `indicateurs_sante`** : données annuelles par pays
- **Vue `analyse_sante`** : jointure pour l'analyse finale

### 6.2 Analyse économétrique (Stata 15)

**Modèle 1 — MCO simple**
```
mort_inf = β0 + β1 * dep_sante + ε
```

**Modèle 2 — MCO espérance de vie**
```
esp_vie = β0 + β1 * dep_sante + ε
```

**Modèle 3 — Effets fixes (mortalité infantile)**
```
mort_inf_it = β1 * dep_sante_it + αi + εit
```

**Modèle 4 — Effets fixes (espérance de vie)**
```
esp_vie_it = β1 * dep_sante_it + αi + εit
```

**Test de Hausman** : pour choisir entre effets fixes et effets aléatoires.

### 6.3 Visualisation (Power BI)

Dashboard avec 4 visuels interactifs :
- Évolution de la mortalité infantile par région (2000-2022)
- Évolution de l'espérance de vie par région (2000-2022)
- Nuage de points dépenses santé vs mortalité infantile
- Comparaison des dépenses de santé par pays

---

## 7. Résultats

### 7.1 Résultats MCO

**Variable dépendante : Mortalité infantile**
- Coefficient dep_sante : **négatif et significatif**
- Interprétation : une hausse des dépenses santé réduit la mortalité infantile

**Variable dépendante : Espérance de vie**
- Coefficient dep_sante : **positif et significatif**
- Interprétation : une hausse des dépenses santé augmente l'espérance de vie

### 7.2 Résultats Effets Fixes

| Variable dépendante | Coefficient dep_sante | Signe | Significativité |
|---|---|---|---|
| Mortalité infantile | Négatif | ✅ | Significatif |
| Espérance de vie | Positif | ✅ | Significatif |

**Interprétation principale :**
> Une hausse de 1 point de pourcentage des dépenses publiques de santé (% PIB) est associée à une **réduction significative de la mortalité infantile** et à une **augmentation de l'espérance de vie** en Afrique, toutes choses égales par ailleurs.

### 7.3 Tendances observées (2000-2022)
- La mortalité infantile a baissé en moyenne de 40% sur la période
- L'espérance de vie a augmenté de près de 8 ans en moyenne
- Les dépenses de santé ont augmenté progressivement dans toutes les régions

---

## 8. Conclusions

Les résultats confirment qu'il existe une relation statistiquement significative entre les dépenses publiques de santé et les indicateurs sanitaires en Afrique. Les pays qui investissent davantage dans la santé tendent à afficher une mortalité infantile plus faible et une espérance de vie plus élevée.

Cependant, plusieurs nuances s'imposent :
- L'effet varie considérablement selon les régions africaines
- La qualité des dépenses importe autant que leur volume
- Des facteurs structurels (pauvreté, infrastructure, gouvernance) modèrent l'effet des dépenses

---

## 9. Recommandations de Politique Économique

1. **Atteindre l'objectif d'Abuja** : consacrer 15% du budget national à la santé — la plupart des pays africains sont encore loin de cet objectif
2. **Priorité à la santé maternelle et infantile** dans les pays d'Afrique Centrale et de l'Ouest
3. **Améliorer l'efficacité allocative** : mieux cibler les dépenses vers les soins primaires
4. **Renforcer les systèmes de santé communautaires** : agents de santé villageois, centres de santé ruraux
5. **Lutter contre la corruption** dans les systèmes de santé publics
6. **Partenariats public-privé** pour compléter les investissements publics insuffisants

---

## 10. Structure du Projet

```
projet-sante-afrique/
├── data/
│   ├── base_sante_afrique.csv      # Base fusionnée (54 pays x 23 ans)
│   ├── analyse_sante.csv           # Export SQL pour Stata
│   └── base_sante.dta              # Base Stata
├── sql/
│   ├── 01_creation_tables.sql      # Création des tables relationnelles
│   ├── 02_import_nettoyage.sql     # Import et nettoyage
│   └── 03_analyse.sql              # Requêtes descriptives + vue finale
├── stata/
│   ├── 01_import_exploration.do    # Import, exploration, statistiques
│   └── 02_regressions.do           # Régressions panel
├── powerbi/
│   └── dashboard_sante.pbix        # Dashboard interactif
└── README.md
```

---

## 11. Limites de l'Étude

- Possible endogénéité : les pays avec de mauvais indicateurs sanitaires peuvent recevoir plus d'aide et donc dépenser plus
- Absence de variables de contrôle comme le revenu par habitant ou la gouvernance
- La mortalité maternelle est mesurée en données quinquennales interpolées
- Les dépenses de santé incluent dépenses publiques et privées selon la définition OMS

---

---

## 📝 Nota Bene — Tests de Stationnarité et Stratégie Économétrique

### NB.1 — Tests de Racine Unitaire (Fisher-ADF)

Des tests de stationnarité ont été réalisés sur toutes les variables via le test de Fisher basé sur le test de Dickey-Fuller Augmenté (ADF), adapté aux données de panel (54 pays, 23 périodes).

| Variable | p-value (Pm) niveau | p-value (Pm) différence | Ordre |
|---|---|---|---|
| `mort_inf` | **0.0000** | — | **I(0)** ✅ |
| `dep_sante` | **0.1017** | **0.0000** | **I(1)** ⚠️ |
| `esp_vie` | **0.0000** ambigu | **0.0000** | **I(1)** ⚠️ |
| `mort_mat` | **0.0000** ambigu | **0.0000** | **I(1)** ⚠️ |

> Note : `esp_vie` et `mort_mat` présentent des résultats ambigus au niveau (2 statistiques significatives sur 4). Par précaution, elles sont traitées comme I(1).

### NB.2 — Tests de Cointégration (Test de Kao)

`esp_vie`, `mort_mat` et `dep_sante` étant toutes I(1), des tests de cointégration de Kao ont été réalisés pour détecter une relation de long terme.

**Test Kao : `esp_vie` et `dep_sante`**

| Statistique | p-value | Conclusion |
|---|---|---|
| Modified Dickey-Fuller t | **0.0000** | ✅ |
| Dickey-Fuller t | **0.0000** | ✅ |
| Augmented Dickey-Fuller t | **0.0000** | ✅ |
| Unadjusted Modified DF t | 0.0686 | ⚠️ |
| Unadjusted Dickey-Fuller t | 0.1731 | ❌ |

**Conclusion : `esp_vie` et `dep_sante` sont COINTÉGRÉES** ✅

**Test Kao : `mort_mat` et `dep_sante`**

| Statistique | p-value | Conclusion |
|---|---|---|
| Modified Dickey-Fuller t | **0.0114** | ✅ |
| Dickey-Fuller t | 0.0976 | ⚠️ |
| Augmented Dickey-Fuller t | **0.0417** | ✅ |
| Unadjusted Modified DF t | **0.0018** | ✅ |
| Unadjusted Dickey-Fuller t | **0.0266** | ✅ |

**Conclusion : `mort_mat` et `dep_sante` sont COINTÉGRÉES** ✅

### NB.3 — Stratégie Économétrique Retenue

| Variable | Ordre | Cointégration | Stratégie |
|---|---|---|---|
| `mort_inf` | I(0) | — | Effets fixes en **niveaux** |
| `esp_vie` | I(1) | ✅ Oui | Effets fixes en **différences premières** |
| `mort_mat` | I(1) | ✅ Oui | Effets fixes en **différences premières** |

> Note : Les estimateurs DOLS et FMOLS (idéaux pour variables cointégrées) ne sont pas disponibles dans Stata 15 IC. Les régressions en différences premières constituent une alternative valide.

### NB.4 — Résultats après Correction pour la Stationnarité

**Modèle 1 — Effets fixes en niveaux (variable : mort_inf)**

| Variable | Coefficient | Écart-type | t | p-value |
|---|---|---|---|---|
| dep_sante | **-2.704** | 0.599 | -4.52 | **0.000** |
| Constante | 94.666 | 3.108 | 30.46 | 0.000 |

- R² within = 0.0158 | N = 1,201 | Groupes = 54
- **Conclusion :** Effet négatif et significatif — une hausse de 1% des dépenses santé réduit la mortalité infantile de **2.7 pour 1000 naissances**

**Modèle 2 — Effets fixes en différences (variable : d_esp_vie)**

| Variable | Coefficient | Écart-type | t | p-value |
|---|---|---|---|---|
| d_dep_sante | **-0.089** | 0.068 | -1.31 | **0.191** |

- R² within = 0.0016 | Prob > F = 0.1915
- **Conclusion :** Effet **non significatif** à court terme — les variations des dépenses santé n'affectent pas immédiatement l'espérance de vie

**Modèle 3 — Effets fixes en différences (variable : d_mort_mat)**

| Variable | Coefficient | Écart-type | t | p-value |
|---|---|---|---|---|
| d_dep_sante | **1.160** | 1.559 | 0.74 | **0.457** |

- R² within = 0.0005 | Prob > F = 0.4570
- **Conclusion :** Effet **non significatif** à court terme

### NB.5 — Interprétation Économique

Ces résultats révèlent une distinction importante entre effets de court et de long terme :

- Les dépenses de santé ont un effet **immédiat et significatif** sur la mortalité infantile (I(0)) — ce qui suggère que les investissements en santé primaire (vaccinations, soins néonataux) produisent des résultats rapides
- En revanche, leur effet sur l'espérance de vie et la mortalité maternelle n'est **pas significatif à court terme** — ces indicateurs répondent aux politiques de santé sur le **long terme**, ce qui est cohérent avec la relation de cointégration détectée par le test de Kao
- La non-significativité en différences premières pour `esp_vie` et `mort_mat` ne contredit pas la relation de long terme confirmée par le test de cointégration

---

*Projet réalisé dans le cadre du Master 2 Économie Agricole — UFHB Cocody, Abidjan*
