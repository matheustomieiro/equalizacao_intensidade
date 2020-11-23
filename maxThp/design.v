module filter(
	input clock,
	input reset,
	input readButton,
	input applyFilterButton,
	input [1:0]filterType,
	output [31:0]out_data);

//assign finished = (ncount == 0);
integer filed, file2, pos, aux, i, j, k, activated;

wire clock, reset, readButton, applyFilterButton;
wire [1:0]filterType;

reg [31:0]in_data;

reg [31:0]out_data;

reg [10239:0]vet;
reg [10239:0]aux_vet;

always@(readButton)
begin
	filed = $fopen("File.pgm","r");
	file2 = $fopen("File_Filter.pgm", "r+");
	if (!filed)  
			$display("Nao foi possivel abrir o arquivo.");
	else begin
		aux = $fseek(filed, 0, 0);
		aux = $fscanf(filed, "%s", in_data);
		out_data = in_data;
		$fwrite(file2, "%0s\n", out_data);
		aux = $fscanf(filed, "%d", in_data);
		out_data = in_data;
		$fwrite(file2, "%0d ", in_data);
		aux = $fscanf(filed, "%d", in_data);
		out_data = in_data;
		$fwrite(file2, "%0d\n", in_data);
		aux = $fscanf(filed, "%d", in_data);
		out_data = in_data;
		$fwrite(file2, "%0d\n", out_data);
	end
end

always@(posedge clock)
begin
	//Caso reset seja pressionado
	if(reset == 1'b1) begin
		i = 0;
		j = 0;
		k = 0;
		activated <= #1 1'b0;
		if(filed)
			$fclose(filed);
		if(file2)
			$fclose(file2);
	end

	//Se o botao de ativacao for pressionado
	else if(applyFilterButton == 1'b1) begin
		activated <= #1 1'b1;
	end

	//Caso o filtro tenha sido ativado
	if(activated == 1'b1) begin
		if(i<320+0) begin
			pos = $ftell(filed);
			aux_vet = vet;
			for(j=0; j<320; j++) begin
				aux_vet = aux_vet<<32;
				aux = $fscanf(filed, "%d", aux_vet[31:0]);
				if(filterType == 2'b00)
					aux_vet[31:0] = 1.2*aux_vet[31:0] + 25;
				else if(filterType == 2'b01)
					aux_vet[31:0] = ($clog2(aux_vet[31:0]))*$clog2(aux_vet[31:0])*3.14;
				else if(filterType == 2'b10)
					aux_vet[31:0] = ($clog2(aux_vet[31:0]))*$clog2(aux_vet[31:0])*1.2+20;
				else if(filterType == 2'b11)
					aux_vet[31:0] = (($clog2(aux_vet[31:0]))*$clog2(aux_vet[31:0])*2.44 + 18) * 0.8 + 15;
				if (aux_vet[31:0]+0 > 255)
					aux_vet[31:0] = 255;
			end
			for(k=0; k<320; k++) begin
				$fwrite(file2, "%0d ", aux_vet[10239:10208]+0);
				aux_vet = aux_vet<<32;
			end
			$fwrite(file2, "\n");
			i = i + 1;
		end
		else begin
			$finish;
		end
	end
end

endmodule