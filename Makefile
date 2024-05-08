all: build open

build: sushi ig

sushi:
	time sushi

ig:
	time ./_genonce.sh -no-sushi

open:
	open output/index.html


clean:
	rm -r fsh-generated
	rm -r temp
	# rm -r template