In deze sectie wordt beschreven hoe vanuit een epd de relevante patiënten en van de relevante patiënten een set met voor de NKR relevante gegevens te komen.

### NKR
 De NKR omvat informatie over diagnostiek, diagnose, tumorkarakteristieken en initiële behandeling, ongeacht de behandellocatie. De logica is dat een initiële set van gegevens automatisch aangeleverd, die vervolgens door datamanagers van IKNL gevalideerd en verrijkt kan worden. IKNL matcht de patiënt eventueel met reeds bestaande gegevens en vult deze aan waar nodig. De patiëntselectie gebeurt op basis van ICD-10 diagnosecodes.

 ### Patient identificatie
#### Patientidentificatie en registratie
De NKR gebruikt het patiëntnummer van een instelling in combinatie met de AGB-code van die instelling voor patiëntidentificatie. Wanneer een patiënt bij meerdere instellingen bekend is, worden de verschillende patiëntnummers en bijbehorende instellingen geregistreerd. Op basis van de NAW-gegevens (naam, postcode), geboortedatum en tumorgegevens worden de gegevens uit de verschillende instellingen aan elkaar gekoppeld.

### Inclusie en exclusiecriteria
#### Patientselectie voor inclusie
Voor de patiëntselectie binnen de NKR wordt uitgegaan van ICD-10 diagnoses. Alleen patiënten met een diagnose uit een vooraf gedefinieerde subset worden opgenomen in de registratie.

Hiervoor is de volgende subset samengesteld: 
 ICDd-10 waardelijst
 | Gegeven    | Waardelijst | Waardes |
| -------- | ------- | ------- |
| primaire diagnose  | `ICD-10` | `C00-C97`, `DO1-DO9`, `D32-D33`, `D35.2`, `D42-D43`, `D45-D47`, `E85.4`, `E85.8` en `E85.9`, of alle waarden met `Mxxxx`   |
{: .grid }



#### Patient exclusie 
Patiënten hebben de mogelijkheid om expliciet aan te geven dat hun gegevens niet in de NKR worden opgenomen. Een voorbeeld hiervan is de expliciete opt-out voor het delen van gegevens ten behoeve van wetenschappelijk onderzoek en scholing. Wanneer patiënten deze opt-out hebben gekozen, mogen hun gegevens niet naar de NKR worden verstuurd, zelfs met terugwerkende kracht.

### Tumor selectie
Omdat een patiënt in zijn leven meerdere tumoren kan hebben. Verwachten we dat elke tumor een nieuwe episode vormt en dat dit onderscheid in het EPD wordt gemaakt. 

### Logica rond diagnoses
Een patiënt heeft volgens de NKR een primaire tumor. Dit is de primaire diagnose. Naast deze primaire tumor kan een patiënt nevendiagnoses hebben voor bijvoorbeeld comorbiditeiten en metastases. In het EPD moet hier onderscheid tussen kunnen gemaakt. 

### Triggers versturen berichten
De trigger voor het versturen van patiëntgegevens naar de NKR is een nieuwe diagnose uit de ICD-10 waardelijst <!--link naar deze waardelijst of waar deze te vinden is toevoegen -->, 28 dagen na de eerste vastlegging van de diagnose. We verwachten dat dagelijks berichten worden gestuurd die voldoen aan deze conditie. Na deze 28 dagen worden gegevens verstuurd als deze nieuw zijn. Per item gelden hier andere regels voor: 
- Operatieve verrichtingen: elke nieuwe operatieve verichting
- Diagnoses: 
- later toevoegen: Medicatie: eerste gift  of elke gift? radiotherapie: eerste gift en x tijd na laatste gift. 

#### operatieve verrichtingen
Voor operatieve verrichtingen geldt de logica dat elke verrichting wordt verstuurd wanneer deze deel uitmaakt van het behandeltraject voor een diagnose uit de ICD-10 waardelijst.

#### vertraging 
Hierbij is er een vertraging van 28 dagen ingebouwd. In deze periode worden enerzijds de eerste behandelgegevens verzameld en anderzijds kan een verdenking bevestigd worden. Dit voorkomt dat verdenkingen als vals-positieven in de NKR worden opgenomen.