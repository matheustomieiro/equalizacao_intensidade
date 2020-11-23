MAIN	=	main.v
DESIGN	=	design.v

all:
	iverilog	$(DESIGN)	$(MAIN)
	@mv	a.out	main.out

run: temp_run convert_back

temp_run:
	@vvp main.out

clean:
	rm	*.out

convert:
	convert $(FILE) -compress none File.pgm

removeimg:
	rm File.pgm

convert_back:
	@convert File_Filter.pgm Com_Normalizacao.png
	@convert File.pgm Sem_Normalizacao.png