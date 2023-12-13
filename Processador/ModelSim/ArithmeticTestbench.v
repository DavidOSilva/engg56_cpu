`timescale 1ns/1ns
module ArithmeticTestbench;

reg	clk;
reg	reset;
wire empty;
wire full;
wire carryOut;
wire [7:0] temp1;
wire [7:0] q_ram_values;
wire [12:0] q_rom_inst;

Processador DUV (.clk(clk), .reset(reset), .temp1(temp1), .q_ram_values(q_ram_values), 
    .q_rom_inst(q_rom_inst), .carryOut(carryOut), .empty(empty), .full(full));

always #100 clk = !clk;
reg [7:0] idx;
integer cenarios_sucesso;
integer total_cenarios;

initial
begin
    $display("*********************** Inicia testes de instrucoes de aritmetica ***********************");
    clk = 0;
    reset = 0;
    idx = 0;
    cenarios_sucesso = 0;
    total_cenarios = 8;
    $stop;
end

initial
begin
    #30000
    display_resultados;
    $stop;
    
end

parameter  add = 5'b00_100,
        mul = 5'b00_110,
        div = 5'b00_111,
        sub = 5'b00_101;

always @ (DUV.b2v_inst4.state) 
begin
    case (DUV.b2v_inst4.ir)
        add: testa_add;
        mul: testa_mul;
        div: testa_div;
        sub: testa_sub; 
    endcase
end

task testa_add;
begin
    if(DUV.b2v_inst4.state == 5'hA && DUV.b2v_inst2.in1 == 8'h2)
    begin
        $display("--------------Inicia teste ADD -------------------");
        $display("Soma os 2 ultimos valores da pilha e os retira da pilha");
        display_operandos;
        idx = DUV.b2v_inst3.index;
        
        if(DUV.b2v_inst3.stack[idx] === 5'h9)
        begin
            display_tos;
            display_esperado;
            $display("--------------Finaliza teste ADD -------------------");
            cenarios_sucesso = cenarios_sucesso + 1;
        end
        else    display_inesperado;
    end
    else if(DUV.b2v_inst4.state == 5'hA  && DUV.b2v_inst2.in1 == 8'h11)
    begin
        $display("--------------Inicia teste ADD com resultado negativo -------------------");
        $display("Soma os 2 ultimos valores da pilha e os retira da pilha");
        display_operandos;
        idx = DUV.b2v_inst3.index;
        
        if($signed(DUV.b2v_inst3.stack[idx]) === -1)
        begin
            display_tos_negativo;
            display_esperado;
            $display("--------------Finaliza teste MUL com resultado negativo ----------------");
            cenarios_sucesso = cenarios_sucesso + 1;
        end
        else    display_inesperado;
    end
end
endtask

task testa_mul;
begin
    if(DUV.b2v_inst4.state == 5'hA && DUV.b2v_inst2.in1 == 8'h3)
    begin
        $display("--------------Inicia teste MUL -------------------");
        $display("Multiplica os 2 ultimos valores da pilha e os retira da pilha");
        display_operandos;
        idx = DUV.b2v_inst3.index;
        
        if(DUV.b2v_inst3.stack[idx] === 5'h1b)
        begin
            display_tos;
            display_esperado;
            $display("--------------Finaliza teste MUL -------------------");
            cenarios_sucesso = cenarios_sucesso + 1;
        end
        else    display_inesperado;
    end
    else if(DUV.b2v_inst4.state == 5'hA  && DUV.b2v_inst2.in1 == 8'h12)
    begin
        $display("--------------Inicia teste MUL com resultado negativo -------------------");
        $display("Multiplica os 2 ultimos valores da pilha e os retira da pilha");
        display_operandos;
        idx = DUV.b2v_inst3.index;
        
        if($signed(DUV.b2v_inst3.stack[idx]) === -18)
        begin
            display_tos_negativo;
            display_esperado;
            $display("--------------Finaliza teste MUL com resultado negativo ----------------");
            cenarios_sucesso = cenarios_sucesso + 1;
        end
        else display_inesperado;
    end
end
endtask

task testa_div;
begin
    if(DUV.b2v_inst4.state == 5'hA && DUV.b2v_inst2.in1 == 8'h36)
    begin
        $display("--------------Inicia teste DIV -------------------");
        $display("Divide o primeiro da pilha pelo segundo e os retira da pilha");
        display_operandos;
        idx = DUV.b2v_inst3.index;
        
        if(DUV.b2v_inst3.stack[idx] === 5'h2)
        begin
            display_tos;
            display_esperado;
            $display("--------------Finaliza teste DIV -------------------");
            cenarios_sucesso = cenarios_sucesso + 1;
        end
        else 
        display_inesperado;
    end
    else if(DUV.b2v_inst4.state == 5'hA && DUV.b2v_inst2.in1 == 8'h2)
    begin
        $display("--------------Inicia teste DIV com resultado negativo -------------");
        $display("Divide o primeiro da pilha pelo segundo e os retira da pilha");
        display_operandos;
        idx = DUV.b2v_inst3.index;
        
        if($signed(DUV.b2v_inst3.stack[idx]) === -1)
        begin
            display_tos_negativo;
            display_esperado;
            $display("--------------Finaliza teste DIV com resultado negativo--------------");
            cenarios_sucesso = cenarios_sucesso + 1;
        end
        else display_inesperado;
    end
end
endtask

task testa_sub;
begin
    if(DUV.b2v_inst4.state == 5'hA && DUV.b2v_inst2.in1 == 8'h8)
    begin
        $display("--------------Inicia teste SUB -------------------");
        $display("Subtrai o primeiro da pilha pelo segundo e os retira da pilha");
        display_operandos;
        idx = DUV.b2v_inst3.index;
        
        if(DUV.b2v_inst3.stack[idx] === 5'h6)
        begin
            display_tos;
            display_esperado;
            $display("--------------Finaliza teste SUB -------------------");
            cenarios_sucesso = cenarios_sucesso + 1;
        end
        else    display_inesperado;
    end
    else if(DUV.b2v_inst4.state == 5'hA && DUV.b2v_inst2.in1 == 8'h4)
    begin
        $display("--------------Inicia teste SUB com resultado negativo -------------");
        $display("Subtrai o primeiro da pilha pelo segundo e os retira da pilha");
        display_operandos;
        idx = DUV.b2v_inst3.index;
        
        if($signed(DUV.b2v_inst3.stack[idx]) === -2)
        begin
            display_tos_negativo;
            display_esperado;
            $display("--------------Finaliza teste SUB com resultado negativo--------------");
            cenarios_sucesso = cenarios_sucesso + 1;
        end
        else display_inesperado;
    end
end
endtask

task display_tos;
begin
    #1 $display("Topo da pilha: %0d",
      DUV.b2v_inst3.stack[idx]);
end
endtask

task display_tos_negativo;
begin
    #1 $display("Topo da pilha: %0d",
      $signed(DUV.b2v_inst3.stack[idx]));
end
endtask

task display_operandos;
begin
    #1 $display("Operandos: %0d e %0d",
      DUV.b2v_inst2.in1, DUV.b2v_inst2.in2);
end
endtask

task display_esperado;
begin
    #1 $display("O topo da pilha foi carregado com o resultado corretamente");
end
endtask

task display_inesperado;
begin
    #1 $display("[ERRO] !!! O topo da pilha foi carregado com um resultado incorreto para a operacao !!!");
    $display("-------------------------------------------------------------------------------------");
end
endtask

task display_resultados;
begin
    #1 $display("-------------------Testes executados!! %0d de %0d passaram------------------",
      cenarios_sucesso, total_cenarios);
    #1 $display("*********************** Finaliza testes de instrucoes de aritmetica ***********************");
end
endtask

endmodule 