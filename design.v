module filter(
	input clock,
	input reset,
	input readButton,
	input applyFilterButton,
	input [1:0]filterType,
	output [31:0]out_data);

//assign finished = (ncount == 0);
integer filed, file2, pos, aux, i, j, lines, cols, activated;

wire clock, reset, readButton, applyFilterButton;
wire [1:0]filterType;

reg [31:0]in_data;

reg [31:0]out_data;

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
			aux = $fscanf(filed, "%d", lines);
			out_data = lines[11:0];
			$fwrite(file2, "%0d ", lines[11:0]);
			aux = $fscanf(filed, "%d", cols);
			out_data = cols[11:0];
			$fwrite(file2, "%0d\n", cols[11:0]);
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
		if(i<lines[11:0]*cols[11:0]+0) begin
			pos = $ftell(filed);
			aux = $fscanf(filed, "%d", in_data);
			if(filterType == 2'b00)
				out_data = 1.2*in_data + 25;
			else if(filterType == 2'b01)
				out_data = ($clog2(in_data))*$clog2(in_data)*3.14;
			else if(filterType == 2'b10)
				out_data = ($clog2(in_data))*$clog2(in_data)*1.2+20;
			else if(filterType == 2'b11)
				out_data = (($clog2(in_data))*$clog2(in_data)*2.44 + 18) * 0.8 + 15;
			if (out_data > 255)
					out_data = 255;
			$fwrite(file2, "%0d ", out_data);
				i = i + 1;
			$fwrite(filed, "\n");
		end
		else begin
				$finish;
		end
	end
end

endmodule