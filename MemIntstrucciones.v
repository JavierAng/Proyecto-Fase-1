module InstructionMemory(
    input [31:0] address,         
    output reg [31:0] instruction 
);

    parameter MEM_SIZE = 1024;
    parameter WORD_SIZE = 32;
    parameter BYTE_SIZE = 8;

    reg [7:0] memory [0:MEM_SIZE-1]; 

    initial begin
        // add $t0, $s1, $s2    (R-type)
        // opcode=000000, rs=17($s1), rt=18($s2), rd=8($t0), shamt=0, funct=100000(add)
        memory[0] = 8'b00000000;  // opcode (000000)
        memory[1] = 8'b10010100;  // rs(17) = 10001, rt(18) = 10010
        memory[2] = 8'b01000000;  // rd(8) = 01000, shamt(0) = 00000
        memory[3] = 8'b10_0000;   // funct(add) = 100000

        // sub $t1, $s1, $s2    (R-type)
        // opcode=000000, rs=17($s1), rt=18($s2), rd=9($t1), shamt=0, funct=100010(sub)
        memory[4] = 8'b00000000;  // opcode (000000)
        memory[5] = 8'b10010100;  // rs(17) = 10001, rt(18) = 10010
        memory[6] = 8'b01001000;  // rd(9) = 01001, shamt(0) = 00000
        memory[7] = 8'b10_0010;   // funct(sub) = 100010

        // and $t2, $s1, $s2    (R-type)
        // opcode=000000, rs=17($s1), rt=18($s2), rd=10($t2), shamt=0, funct=100100(and)
        memory[8] = 8'b00000000;  // opcode (000000)
        memory[9] = 8'b10010100;  // rs(17) = 10001, rt(18) = 10010
        memory[10] = 8'b01010000; // rd(10) = 01010, shamt(0) = 00000
        memory[11] = 8'b10_0100;  // funct(and) = 100100

        // or $t3, $s1, $s2     (R-type)
        // opcode=000000, rs=17($s1), rt=18($s2), rd=11($t3), shamt=0, funct=100101(or)
        memory[12] = 8'b00000000; // opcode (000000)
        memory[13] = 8'b10010100; // rs(17) = 10001, rt(18) = 10010
        memory[14] = 8'b01011000; // rd(11) = 01011, shamt(0) = 00000
        memory[15] = 8'b10_0101;  // funct(or) = 100101

        // slt $t4, $s1, $s2    (R-type)
        // opcode=000000, rs=17($s1), rt=18($s2), rd=12($t4), shamt=0, funct=101010(slt)
        memory[16] = 8'b00000000; // opcode (000000)
        memory[17] = 8'b10010100; // rs(17) = 10001, rt(18) = 10010
        memory[18] = 8'b01100000; // rd(12) = 01100, shamt(0) = 00000
        memory[19] = 8'b10_1010;  // funct(slt) = 101010
    end

    // Lectura de instrucción con verificación de alineación
    always @(*) begin
        if (address % 4 != 0) begin
            $display("Warning: Unaligned memory access at address %h", address);
            instruction = 32'b0; // En caso de error, devuelve NOP
        end else begin
            instruction = {
                memory[address],     // Byte más significativo (31:24)
                memory[address + 1], // Bytes (23:16)
                memory[address + 2], // Bytes (15:8)
                memory[address + 3]  // Byte menos significativo (7:0)
            };
        end
    end

endmodule