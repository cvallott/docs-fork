#import "/template/template.typ": documento,team

#show: documento.with(
  title: "Analisi dei requisiti",
  sommario: "Documento di Analisi dei requisiti.",
  changelog: (
    "0.1.0", "12/11/2024", "Prima versione", team.G, team.A
  )
)

#include "include/introduzione.typ"
#include "include/descrizione.typ"
#include "include/use_cases.typ"
#include "include/requisiti.typ"