`define SEEK_SET 0
`define SEEK_CUR 1
`define SEEK_END 2

module main();

  // wire finished;
  // reg clk;
  // reg start;
  
  integer filed,file2, pos, aux, i,j, lines, cols;
  integer test;
  reg [31:0]num;
  reg [7:0]num2;
  reg [3:0]um;

  initial begin
        filed = $fopen("File.pgm","r");
        file2 = $fopen("File_Filter.pgm", "r+");
        if (!filed)  
            $display("Nao foi possivel abrir o arquivo.");
        else begin
            aux = $fseek(filed, 0, `SEEK_SET);
            aux = $fscanf(filed, "%s", num);
            $fwrite(file2, "%0s\n", num);
            aux = $fscanf(filed, "%d", lines[11:0]);
            $fwrite(file2, "%0d ", lines[11:0]);
            aux = $fscanf(filed, "%d", cols[11:0]);
            $fwrite(file2, "%0d\n", cols[11:0]);
            aux = $fscanf(filed, "%d", num);
            $fwrite(file2, "%0d\n", num);
            for (i=0;i<lines[11:0];i=i+1) begin
                for (j=0;j<cols[11:0];j=j+1) begin
                    pos = $ftell(filed);
                    aux = $fscanf(filed, "%d", num);
                    num = 1.2*num + 25;
                    //num = ($clog2(num))*$clog2(num)*3.14;
                    if (num > 255)
                        num = 255;
                    // pos = $ftell(filed);
                    $fwrite(file2, "%0d ", num);
                    // aux = $fseek(filed, pos+2, `SEEK_SET);
                end
                //aux = $fseek(filed, pos, `SEEK_SET);
                $fwrite(filed, "\n");
            end
        end
        #5  $finish;
    end
  
  
    //display;
    
    // always begin
    //   #5  clock = ~clock; // Clock troca estado a cada 5 nanosec
    // end
    
endmodule