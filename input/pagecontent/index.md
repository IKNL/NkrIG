## FHIR Implementatiegids voor de Nederlandse Kankerregistratie

### Achtergrond
Als ziekenhuizen en (EPD-)leveranciers automatisch gegevens aanleveren aan IKNL, dragen zij bij aan de doelstellingen van IKNL om meer inzicht te krijgen in oncologische zorg en de registratielast te verminderen.  IKNL probeert dit te bereiken via geautomatiseerde koppelingen met EPD’s, waarbij data zoveel mogelijk aan de bron blijft en alleen relevante gegevens worde gedeeld. Door meer actuele gegevens te gebruiken, kunnen IKNL en onderzoekers de effectiviteit van oncologische zorg beter monitoren en evalueren.Het doel van de geautomatiseerde aanlevering aan de NKR is tweeledig: enerzijds het automatisch registreren van gestructureerde gegevens om de registratielast te verminderen, en anderzijds het versnellen van het aanleverproces.

 <!-- hier moet nog wat mee of RONDA uitleggen of niet noemen --> Projecten zoals RONDA spelen een belangrijke rol door ziekenhuizen te ondersteunen bij deze transitie.

### Doel implementatiegids:  

Deze implementatiegids beschrijft hoe ziekenhuizen, epd-leveranciers en andere partijen die bevoegd zijn om data uit elektronische patiëntendossiers (epd's) of andere relevante databronnen te halen, automatisch gegevens aan kunnen leveren aan de Nederlandse Kankerregistratie (NKR). 


De gids specificeert de standaarden en vereisten voor het aanleveren van NKR-gegevens en biedt technische en inhoudelijke richtlijnen voor het verzamelen en aanleveren van gegevens aan de NKR. Met als doel: ondersteuning bij een correcte en efficiënte implementatie.


De basis van deze implementatiegids is **FHIR R4**, met profielen gebaseerd op de **Nederlandse Core (NL-core)** en de **Zorginformatiebouwstenen (zibs) versie 2020**.

### Scope  

Deze implementatiegids beschrijft de technische en inhoudelijke vereisten voor het verzamelen en versturen van patiëntgegevens. Het doel is om dit proces op een haalbare, betrouwbare en veilige manier te laten plaatsvinden. De richtlijnen in deze gids zijn van toepassing op de elektronische aanlevering van registratiegegevens door ziekenhuizen in Nederland. De aan te leveren gegevens omvatten patiëntgerelateerde informatie en zijn uitgewerkt in [itemssets]https://iknl.nl/nkr/registratie/itemsets. Uit de itemssets zijn gegevens die vaak gestructureerd geregistreerd worden en zo veel mogelijk onderdeel zijn van de BGZ geïdentificeerd. Dit is de basis voor de profielen in deze implementatiegids.

### principes en toegepaste guidelines in implementatiegids:

### Leeswijzer 
De implementatiegids is bedoeld voor zorginstellingen en leveranciers met basiskennis over de NKR en zibs-2020 en de NL-core.

### Taal 

De implementatiegids beschrijft de technische en inhoudelijke vereisten voor het verzamelen en versturen van patiëntgegevens binnen Nederland, en is niet bedoeld voor buitenlandse partijen. Wij verwachten geen aansluiting van internationale partijen op onze FHIR-server. Mocht er desondanks behoefte zijn om deze informatie in het Engels beschikbaar te hebben, dan vernemen wij dit graag. 

### Must Support

De **Must Support**-markering in deze gids geeft aan welke elementen in de NKR kunnen worden verwerkt. Elementen zonder deze markering kunnen niet in de  verwerking worden meegenomen.


### Principes
-  We maken gebruik van de Nederlandse FHIR-profielen van HL7 NL en Nictiz
-  We sluiten, waar mogelijk, aan bij (inter)nationale ontwikkelingen, zoals de IGs van PALGA en mCode, informatiestandaard oncologie algemeen
 - 

 

### Overzicht profielen
Op dit moment zijn de volgende profielen ontwikkeld:
- `NcrEhrEpisodeOfCare`
- `NcrEhrPatient` 
- `NcrEhrProcedureEvent`
- `NcrEhrHealthcareProvider`
- `NcrEhrCondition`

### Proces na Binnenkomend Bericht

Gegevens die via geautomatiseerde berichten bij de NKR worden aangeleverd, worden eerst gevalideerd en, indien nodig, gemapt op NKR-specifieke waardenlijsten. Na de validatie verrijken datamanagers de gegevens door missende gestructureerde en ongestructureerde data toe te voegen, waarmee het NKR dossier compleet wordt gemaakt.


### Support 

Voor meldingen over fouten bij het geautomatiseerd aanleveren van FHIR berichten op de IKNL FHIR server kan contact opgenomen worden met: meldingen.fhir@iknl.nl	 

Voor inhoudelijke opmerkingen en vragen over de profielen kan contact opgenomen worden met: FHIR@IKNL.nl 

### Referenties

- [HL7 FHIR documentatie](https://hl7.org/fhir/r4/)
- [ZIBs 2020 documentatie](https://zibs.nl/wiki/ZIB_Publicatie_2020(NL))
- [IKNL](https://iknl.nl/)


 
 





