#import "@preview/fletcher:0.5.2" as fletcher: diagram, node, edge
#import fletcher.shapes: ellipse, rect
#import "@preview/cetz:0.3.0"
#import cetz.draw

#let empty-dash = (
    inherit: "}>",
    size: 10,
    fill: none,
    stealth: 0
)

= Casi d'uso

== Obiettivi

== Attori

== Definizione casi d'uso

#set heading(numbering: (..numbers) => {
  let level = numbers.pos().len()
  if (level == 3) {
    return numbering("UC1", numbers.pos().at(level - 1))
  }
  else if (level == 4) {
    return numbering("UC1.1", numbers.pos().at(level - 2), numbers.pos().at(level - 1))
  }
})
#set heading(supplement: none)

=== Login <login>
#figure(
    diagram(
    debug: false,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    label-size: 8pt,

    node((0,0.5), [#image("../assets/actor.jpg") Utente], stroke: 0pt, name: <a>),
    edge(<a>, <b>),
    node((4,0.5), [#image("../assets/actor.jpg") Database], stroke: 0pt, name: <db>),
    edge(<db>, <b>),

    node((2,0), align(center)[
            @login Login
    ], shape: ellipse, name: <b>),

    node((2,1), align(center)[
            @credenziali-errate Credenziali errate
    ], shape: ellipse, name: <c>),

    edge(<c>, <b>, "--straight", [\<\<extend\>\>]),

    node((3,1), align(center)[
             @login-google Login Google
    ], shape: ellipse, name: <d>),

    edge(<d>, <b>, marks: (none,empty-dash)),

    node(enclose: (<b>,<c>,<d>),
        align(top + right)[Sistema],
        width: 200pt,
        height: 200pt,
        snap: -1,
        name: <group>)
    ),

    caption: [Login UC diagram.]
) <login-diagram>

- *Attori principali*:
  - Utente.
- *Attori secondari*:
  - Database.
- *Scenario principale*:
 - Utente:
   - inserisce lo username (@inserimento-username);
   - inserisce la password (@inserimento-password).
 - Sistema:
   1. verifica che le credenziali dell'utente siano corrette;
   2. se la verifica ha successo viene assegnata una sessione all'utente;
   3. se le credenziali sono sbagliate si mostra un messaggio d'errore (@credenziali-errate).
- *Pre-condizioni*:
   - L'utente possiede un account;
   - L'utente non è già autenticato.
- *Post-condizioni*:
   - L'utente viene autenticato ed ottiene una sessione.
- *Estensioni*:
  - Credenziali errate (@credenziali-errate)
- *Generalizzazioni*:
  - Login Google (@login-google).

==== Inserimento username <inserimento-username>
- *Attori principali*:
  - Utente.
- *Scenario principale*:
 - Utente:
   - inserisce il proprio username.
 - Sistema:
   1. verifica la correttezza dello username;
   2. continua la procedura di login.
- *Pre-condizioni*:
   - L'utente possiede un account;
   - L'utente non è già autenticato.
- *Post-condizioni*:
   - L'utente ha inserito lo username correttamente.

==== Inserimento password <inserimento-password>
- *Attori principali*:
  - Utente.
- *Scenario principale*:
 - Utente:
   - inserisce la propria password.
 - Sistema:
   1. verifica la correttezza della password;
   2. continua la procedura di login.
- *Pre-condizioni*:
   - L'utente possiede un account;
   - L'utente non è già autenticato.
- *Post-condizioni*:
   - L'utente ha inserito la password correttamente.

=== Credenziali errate <credenziali-errate>

- *Attori principali*:
  - Utente.
- *Scenario principale*:
 - Utente:
   - inserisce lo username;
   - inserisce la password;
 - Sistema:
   1. verifica che le credenziali dell'utente siano corrette;
   2. la verifica non ha successo;
   3. viene visualizzato un messaggio d'errore.
- *Pre-condizioni*:
   - L'utente possiede un account;
   - L'utente non è già autenticato.
- *Post-condizioni*:
   - Viene segnalato all'utente che le credenziali inserite sono errate;
   - L'utente può riprovare ad eseguire il login.

=== Login Google <login-google>

#figure(
    diagram(
    debug: false,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    label-size: 8pt,

    node((0,0.5), [#image("../assets/actor.jpg") Utente], stroke: 0pt, name: <a>),
    edge(<a>, <b>),

    node((4,0.5), [#image("../assets/actor.jpg") Google], stroke: 0pt, name: <google>),
    edge(<google>, <b>),

    node((2,0.5), align(center)[
             @login-google Login Google
    ], shape: ellipse, name: <b>),


    node(enclose: (<b>,),
        align(top + right)[Sistema],
        width: 150pt,
        height: 150pt,
        snap: -1,
        name: <group>)
    ),
    caption: [Login Google UC diagram.]
) <login-google-diagram>

- *Attori principali*:
  - Utente.
- *Attori secondari*:
  - Google.
- *Scenario principale*:
 - Utente:
   - richiede di accedere con il proprio account Google.
 - Sistema:
   1. redirige l'utente ai servizi di Google;
   2. controlla che il login con i servizi di Google sia avvenuto correttamente.
- *Pre-condizioni*:
   - L'utente possiede un account Google.
   - L'utente non è già autenticato.
- *Post-condizioni*:
   - L'utente viene autenticato ed ottiene una sessione.

=== Gestione servizi Google <gestione-servizi-google>
#figure(
    diagram(
    debug: false,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    label-size: 8pt,

    node((0.5,0.1), [#image("../assets/actor.jpg") Utente], stroke: 0pt, name: <a>),
    edge(<a>, <b>),

    node((3.35,0.1), [#image("../assets/actor.jpg") Google], stroke: 0pt, name: <google>),
    edge(<google>, <b>),

    node((1.5,0.65), align(center)[
        @rimozione-account-google-associato Rimozione account \ Google associato
    ], shape: ellipse, name: <e>, inset: 10pt),

    node((2,0), align(center)[
            @gestione-servizi-google Gestione servizi Google
    ], shape: ellipse, name: <b>, inset: 10pt),

    node((2,1.25), align(center)[
            @inserimento-credenziali-google Inserimento\ credenziali Google
    ], shape: ellipse, name: <c>, inset: 10pt),

    node((2.5,0.8), align(center)[
            @errore-comunicazione-google Errore comunicazione \ Google
    ], shape: ellipse, name: <d>, inset: 10pt),

    edge(<c>, <b>, "--straight", [\<\<extend\>\>], label-side: right),

    edge(<d>, <b>, "--straight", [\<\<extend\>\>], label-side: right),

    edge(<e>, <b>, "--straight", [\<\<extend\>\>], label-side: left),

    node(enclose: (<b>,<c>, <d>, <e>),
        align(top + right)[Sistema],
        width: 200pt,
        height: 200pt,
        snap: -1,
        name: <group>)
    ),
    caption: [Associazione servizi Google UC diagram.]
) <associazione-servizi-google-diagram>

- *Attori principali*:
  - Utente.
- *Attori secondari*:
  - Google.
- *Scenario principale*:
 - Utente:
   - apre la configurazione dei servizi Google (@gestione-servizi-google);
   - inserisce delle credenziali Google (@inserimento-credenziali-google).
 - Sistema:
   1. verifica se un account Google è già collegato;
   2. se è collegato, permette all'utente di rimuoverlo (@rimozione-account-google-associato);
   3. se non è collegato, chiede all'utente di accedere a Google (@inserimento-credenziali-google);
   4. se si verifica un errore nella comunicazione mostra un messaggio d'errore (@errore-comunicazione-google);

- *Pre-condizioni*:
   - L'utente è autenticato;
- *Post-condizioni*:
   - L'utente ha associato o rimosso un account Google.
- *Estensioni*:
  - Inserimento credenziali Google (@inserimento-credenziali-google);
  - Errore comunicazione Google (@errore-comunicazione-google);

=== Rimozione account Google associato <rimozione-account-google-associato>
- *Attori principali*:
  - Utente.
- *Attori secondari*:
  - Google.
- *Scenario principale*:
 - Utente:
   - avvia la procedura di rimozione dell'account Google associato.
 - Sistema:
   1. rimuove l'account Google associato all'esecuzione dei blocchi nei workflow (@rimozione-account-google-associato);
   2. notifica il completamento dell'operazione;
   3. se si verifica un errore nella comunicazione con Google mostra un messaggio d'errore (@errore-comunicazione-google);

- *Pre-condizioni*:
   - L'utente è autenticato;
   - L'utente ha associato un account Google.
- *Post-condizioni*:
   - L'utente non ha associato un account Google.

=== Inserimento credenziali Google <inserimento-credenziali-google>
- *Attori principali*:
  - Utente.
- *Attori secondari*:
  - Google.
- *Scenario principale*:
 - Utente:
   - avvia la procedura di associazione di un account Google;
   - inserisce le credenziali dell'account Google che vuole collegare.
 - Sistema:
   1. mostra la finestra di Google per la configurazione dell'account;
   2. notifica il completamento dell'operazione;
   3. se si verifica un errore nella comunicazione con Google mostra un messaggio d'errore (@errore-comunicazione-google).

- *Pre-condizioni*:
   - L'utente è autenticato;
   - L'utente non ha associato un account Google.
- *Post-condizioni*:
   - L'utente ha associato l'account Google di cui ha inserito le credenziali.

=== Errore comunicazione con Google <errore-comunicazione-google>
- *Attori principali*:
  - Utente.
- *Attori secondari*:
  - Google.
- *Scenario principale*:
 - Utente:
   - compie un'azione per la gestione dell'account Google associato (@gestione-servizi-google).
 - Sistema:
   1. notifica all'utente l'errore di comunicazione con Google e il mancato completamento dell'operazione corrente.

- *Pre-condizioni*:
   - Si verifica un errore di comunicazione con i sistemi di Google.
- *Post-condizioni*:
   - Il sistema notifica l'errore all'utente.