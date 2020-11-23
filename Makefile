MAIN	=	main.v
DESIGN	=	design.v

all:
	iverilog	$(DESIGN)	$(MAIN)
	@mv	a.out	main.out

run: removeimg restore all
	vvp main.out

clean:
	rm	*.out

convert:
	convert $(FILE) -compress none File.pgm

restore:
	cp Comparacao.pgm File.pgm

removeimg:
	rm File.pgm