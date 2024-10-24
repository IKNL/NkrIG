# Business logica

In deze sectie wordt beschreven hoe van een set van patiënten en dossierinformatie de relevante patiënten en van de relevante patiënten tot een set voor de NKR relevante gegevens te komen. Dit kan op basis van subsets uit waardelijsten of specifieke in- en exclusie criteria. Ten aanzien van de geautomatiseerde gegevensverzameling en -verstrekking bepaalt IKNL welke gegevens wanneer uit de Dataset op geautomatiseerde wijze door IKNL kunnen worden ontvangen met welke voorwaarden. Dit is noodzakelijk met het oog op haalbaarheid, betrouwbaarheid en veiligheid. 

### Disclaimer huidige status
De profielen en de bijbehorende valuesets voor in- en exclusie zijn momenteel nog in ontwikkeling. Daarom is ervoor gekozen om selectie en filtering bij de bron te laten plaatsvinden, in plaats van deze af te dwingen binnen de profielen. Hierdoor kunnen profielen, zoals het profiel voor procedures, in eerste instantie worden gebruikt voor operaties, maar ook worden hergebruikt voor andere toepassingen, zoals radiotherapie. In latere versies worden specifieke valuesets per item in de profielen toegevoegd, waarbij deze zullen aansluiten op de hier beschreven business logica.

### Gebruiksscenario 
Het gebruiksscenario voor de aanlevering aan de NKR vormt de eerste stap in het registreren van tumoren in de Nederlandse Kankerregistratie. . De NKR omvat informatie over diagnostiek, diagnose, tumorkarakteristieken en initiële behandeling, ongeacht de behandellocatie. In de eerste versie van  <!--nog niet helemaal mooi verwoord de berichten -->wordt een initiële set gegevens aangeleverd, die vervolgens door datamanagers van IKNL gevalideerd en verrijkt kan worden. IKNL matcht de patiënt eventueel met reeds bestaande gegevens en vult deze aan waar nodig. De patiëntselectie gebeurt op basis van ICD-10 diagnosecodes. Vervolgens wordt, 28 dagen na het vastleggen van de diagnose, een relevante set gegevens over de patiënt verzameld op basis van de gedefinieerde profielen. Deze gegevens worden in een bundel verstuurd naar de NKR.

### Patient identificatie
#### Patientidentificatie en registratie
De NKR gebruikt het patiëntnummer van een instelling in combinatie met de AGB-code van die instelling voor patiëntidentificatie. Wanneer een patiënt bij meerdere instellingen bekend is, worden de verschillende patiëntnummers en bijbehorende instellingen geregistreerd. Op basis van de NAW-gegevens (naam, postcode), geboortedatum en tumorgegevens worden de gegevens uit de verschillende instellingen aan elkaar gekoppeld.

### Inclusie en exclusie criteria
#### Patientselectie voor inclusie
Voor de patiëntselectie binnen de NKR wordt uitgegaan van ICD-10 diagnoses. Alleen patiënten met een diagnose uit een vooraf gedefinieerde subset worden opgenomen in de registratie. Hierbij is er een vertraging van 28 dagen ingebouwd. In deze periode worden enerzijds de eerste behandelgegevens verzameld en anderzijds kan een verdenking bevestigd worden. Dit voorkomt dat verdenkingen als vals-positieven in de NKR worden opgenomen.

#### Patient exclusie 
Patiënten hebben de mogelijkheid om expliciet aan te geven dat hun gegevens niet in de NKR worden opgenomen. Een voorbeeld hiervan is de expliciete opt-out voor het delen van gegevens ten behoeve van wetenschappelijk onderzoek en scholing. Wanneer patiënten deze opt-out hebben gekozen, mogen hun gegevens niet naar de NKR worden verstuurd, zelfs met terugwerkende kracht.

### Triggers versturen berichten
De trigger voor het versturen van patiëntgegevens naar de NKR is een nieuwe diagnose uit de ICD-10 waardelijst <!--link naar deze waardelijst of waar deze te vinden is toevoegen -->, 28 dagen na de eerste vastlegging van de diagnose.

### Logica in opstellen berichten
#### operatieve verrichtingen
Voor operatieve verrichtingen geldt de logica dat elke verrichting wordt verstuurd wanneer deze deel uitmaakt van het behandeltraject voor een diagnose uit de ICD-10 waardelijst. Dit is als volgt gemodelleerd in FHIR-resources: de operatie wordt vastgelegd in een procedure. De procedure bevat een reason reference, wat verwijst naar de conditie waarvoor de operatie is uitgevoerd. Deze conditie moet vallen binnen de vastgestelde ICD-10 diagnoselijst.

Op dit moment wordt deze logica alleen toegepast voor long- en colorectale kankers. <!-- besluiten of dit er in moet blijven staan>

#### Waarde condition category
In het profiel `NcrEhrCondition` wordt verwacht dat er een **category** wordt meegestuurd. Voor elke tumor is het van belang om vast te stellen of het om een primaire diagnose gaat of om een bijkomende diagnose. Primaire diagnoses worden verstuurd met de category: `encounter diagnosis`, terwijl bijkomende diagnoses, zoals metastasen, worden verstuurd met de category: `problem list item`.

#### Organisatiegegevens
De zorginstelling wordt vastgelegd met een code uit de AGB-code waardelijst. IKNL verwacht binnen deze set op dit moment alleen AGB-codes van ziekenhuizen. Codes van individuele zorgverleners worden door IKNL niet verwacht.


#### Episode of care
Elke **episode of care** omvat een verzameling diagnoses, waarbij elke diagnosegroep één **encounter diagnosis** bevat en geen tot meerdere **problem list items**. Dit is van toepassing wanneer een patiënt meer dan één primaire tumor heeft, die niet gerelateerd zijn en afzonderlijk worden geregistreerd in de NKR. De eerste primaire tumor vormt **diagnosegroep 1** en de tweede tumor wordt geregistreerd als **diagnosegroep 2**.

Dit model is bedoeld om bij binnenkomende **problem list items** voor de NKR te bepalen bij welke primaire diagnose deze horen. Zo kan nauwkeurig worden vastgesteld welke problematiek verbonden is aan welke tumor.


#### Overzicht gebruikte subvaluesets


| Gegeven    | Waardelijst | Waardes |
| -------- | ------- | ------- |
| `NcrEhrCondition.code.coding.icd10coding.code`  | `ICD-10` | `C00-C97`, `DO1-DO9`, `D32-D33`, `D35.2`, `D42-D43`, `D45-D47`, `E85.4`, `E85.8` en `E85.9`, of alle waarden met `Mxxxx`   |
| `NcrEhrProcedureEvent.code`| `NZA codelijst`     | NNB |
|`NcrEhrHealthcareProvider.identifier.agb`|  `AGB`|  Ziekenhuizen |
|`NcrEhrcondition.clinical.Status` | [Status diagnose](http://terminology.hl7.org/CodeSystem/condition-clinical) | `Active` |
{: .grid }



<!--- functionele eisen document doornemen voor meer beslissingen en afspraken https://iknlonline.sharepoint.com/:w:/r/sites/104_RHONDA_ext/Gedeelde%20documenten/General/R(H)ONDA%20Teampagina/Functioneel%20ontwerp%20datapijplijn/20230220%20Functionele%20eisen%20datapijplijn%20EPD_v0.2%20IKNL.docx?d=w089d7c049a524f84b0170ad73479c2f7&csf=1&web=1&e=3cm6xg 

Voor welke versie is deze implementatiegids bedoelt. In hoeverre al voorsorteren op fase 2? 


-->




### Toekomstige uitbreidingen
In toekomstige versies van deze implementatiegids zullen specifieke valuesets voor elk profielitem worden toegevoegd, gebaseerd op de hierboven beschreven businesslogica. Dit zal bijdragen aan verdere standaardisatie en verbetering van de dataverzameling en -verwerking. Daarnaast zullen er stapsgewijs steeds meer profielen met bijbehorende logica worden toegevoegd. Met elke nieuwe versie zal deze implementatiegids verder worden uitgebreid en verfijnd om de processen optimaal te ondersteunen.