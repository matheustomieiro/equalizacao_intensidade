module main();  

    reg clock, reset, readButton, applyFilterButton;
    reg [1:0]filterType;
    wire [31:0]out_data;

    initial begin

        if (!$value$plusargs("filterType=%b", filterType)) begin
            $display("Erro. Filtro nao definido!\n");
            $finish;
        end

        clock = 1; //Setando clock inicial para HIGH
        reset = 0; //Setando reset para LOW
        readButton = 0; //Setando botao de leitura para LOW
        applyFilterButton = 0; //Setando botao de filtro para LOW

        //Criando roteiro de execucao, ja que nao estamos testando em uma placa
        #5  reset = 1;
        #10 reset = 0;
        #15 readButton = 1;
        #20 readButton = 0;
        #25 applyFilterButton = 1;
        #30 applyFilterButton = 0;
    end

    always begin
        #5  clock = ~clock; // Clock troca estado a cada 5 nanosec
    end
    
    //Conectando design
    filter f(clock, reset, readButton, applyFilterButton, filterType, out_data);

endmodule