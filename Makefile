page := index.html

all: build open

build: sushi ig

sushi:
	sushi

ig:
	./_genonce.sh -no-sushi -fhir-settings fhir-settings.json

open:
	open output/$(page)

install-dependencies:
	mkdir -p ~/.fhir/packages/nictiz.fhir.nl.r4.nl-core#0.10.0-beta.1
	mkdir -p ~/.fhir/packages/nictiz.fhir.nl.r4.zib2020#0.10.0-beta.1
	mkdir -p ~/.fhir/packages/nictiz.fhir.nl.r4.medicationprocess9#2.0.0-beta.5
	tar xvzf vendor/nictiz.fhir.nl.r4.nl-core-0.10.0-beta.1-snapshots.tgz -C ~/.fhir/packages/nictiz.fhir.nl.r4.nl-core#0.10.0-beta.1
	tar xvzf vendor/nictiz.fhir.nl.r4.zib2020-0.10.0-beta.1-snapshots.tgz -C ~/.fhir/packages/nictiz.fhir.nl.r4.zib2020#0.10.0-beta.1
	tar xvzf vendor/nictiz.fhir.nl.r4.medicationprocess9-2.0.0-beta.5-snapshots.tgz -C ~/.fhir/packages/nictiz.fhir.nl.r4.medicationprocess9#2.0.0-beta.5


clean:
	rm -r fsh-generated
	rm -r temp
	# rm -r template