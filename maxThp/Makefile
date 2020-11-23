MAIN	=	main.v
DESIGN	=	design.v

all:compile run convert_back

compile:
	iverilog	-ofilter.vvp	$(DESIGN)	$(MAIN)

usage:
	@printf "Para executar: make all ARGS=+filterType=TIPO_DE_FILTRO.\n"
	@printf "TIPO_DE_FILTRO pode assumir os valores: 00, 01, 10, 11.\n"

run:
	vvp filter.vvp $(ARGS)

clean:
	@rm	*.vvp
	@echo "" > File_Filter.pgm
	@rm Com_Filtro.png Sem_Filtro.png
convert:
	convert $(FILE) -compress none File.pgm

removeimg:
	rm File.pgm

convert_back:
	@convert File_Filter.pgm Com_Filtro.png
	@convert File.pgm Sem_Filtro.png