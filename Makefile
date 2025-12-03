page := index.html
qa := qa.html

all: build open

build: sushi ig

sushi:
	sushi

ig:
	./_genonce.sh -no-sushi -fhir-settings fhir-settings.json

open:
	open output/$(page)

qa: 
	open output/$(qa)

install-dependencies:
	mkdir -p ~/.fhir/packages/nictiz.fhir.nl.r4.nl-core#0.12.0-beta.4
	mkdir -p ~/.fhir/packages/nictiz.fhir.nl.r4.zib2020#0.12.0-beta.4
	mkdir -p ~/.fhir/packages/nictiz.fhir.nl.r4.medicationprocess9#2.0.0-rc.3
	tar xzf vendor/nictiz.fhir.nl.r4.nl-core-0.12.0-beta.4-snapshots.tgz -C ~/.fhir/packages/nictiz.fhir.nl.r4.nl-core#0.12.0-beta.4
	tar xzf vendor/nictiz.fhir.nl.r4.zib2020-0.12.0-beta.4-snapshots.tgz -C ~/.fhir/packages/nictiz.fhir.nl.r4.zib2020#0.12.0-beta.4
	tar xzf vendor/nictiz.fhir.nl.r4.medicationprocess9-2.0.0-rc.3-snapshots.tgz -C ~/.fhir/packages/nictiz.fhir.nl.r4.medicationprocess9#2.0.0-rc.3


clean:
	rm -r fsh-generated
	rm -r temp
	# rm -r template