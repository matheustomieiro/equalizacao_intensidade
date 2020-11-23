`define SEEK_SET 0
`define SEEK_CUR 1
`define SEEK_END 2

module main();

  // //wire [7:0]XPower;
  // wire finished;
  // reg [7:0]X;
  // reg clk;
  // reg start;
  
  // // Instantiate design under test
  // XPowerIterative inst_1(.clk(clk), .start(start), .X(X), .XPower(XPower), .finished(finished));
          
  integer filed, pos, aux, i,j, lines, cols;
  integer test;
  reg [31:0]num;
  reg [7:0]num2;
  reg [3:0]um;

  initial begin
        filed = $fopen("File.pgm","r+");
        //um = 8'b00000001;
        cols = 130;
        lines = 130;
        if (!filed)
            $display("Nao foi possivel abrir o arquivo.");
        else begin
            aux = $fseek(filed, 14, `SEEK_SET);
            $fwrite(filed, "\n");
            for (i=0;i<lines;i=i+1) begin
                for (j=0;j<cols;j=j+1) begin
                    pos = $ftell(filed);
                    aux = $fscanf(filed, "%h", num);
                    //num2[7:0] = num[7:0];
                   // num = (num + 20);
                    if (num2 > 255)
                        num2 = 255;
                    test = num[7:0];
                    aux = $fseek(filed, pos, `SEEK_SET);
                    // pos = $ftell(filed);
                    $fwrite(filed, "%0d ", test);
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