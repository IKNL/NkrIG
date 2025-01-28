## Afwijkingen van zibs 2020

De meeste NKR-profielen zijn gebaseerd op de NLcore en zibs2020. Wanneer de NLcore niet voorziet in een geschikt profiel, wordt eerst gekeken naar bestaande profielen op basis van andere standaarden, voordat er een volledig nieuw profiel wordt ontwikkeld. Hieronder volgt een overzicht van de afwijkingen ten opzichte van de NLcore.

### Afwijking patient
De zib Patient is ontworpen voor gegevensuitwisseling op basis van het BSN. Aangezien IKNL geen wettelijke grondslag heeft om het BSN te verwerken, is hiervoor een alternatief gemodelleerd. Dit alternatief maakt gebruik van het patiëntnummer binnen de instelling, gecombineerd met de instelling die het patiëntnummer heeft uitgegeven.

### Afwijking voor episode of care 
In de NL-core is geen profiel opgenomen dat gebaseerd is op **episode of care**, terwijl dit wel noodzakelijk is om in het geval van metastasen een koppeling te kunnen maken met een primaire tumor. Daarom is een profiel gebaseerd op de resource **episode of care** uit FHIR R4 toegevoegd aan het package.

