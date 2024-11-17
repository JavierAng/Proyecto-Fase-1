`timescale 1ns/1ns

module U_control (
    input [5:0] Opcode,
    output reg BR_En,    // RegWrite - Habilita escritura en banco de registros
    output reg [2:0] AluC,    // AluOp - Código de operación para ALU
    output reg EnW,      // MemWrite - Habilita escritura en memoria
    output reg EnR,      // MemRead - Habilita lectura de memoria
    output reg Mux1,     // MemToReg - Selecciona entre ALU y memoria
    output reg regDest,  // RegDest - Selecciona registro destino
    output reg AluSRC,   // AluSrc - Selecciona entre registro y valor inmediato
    output reg Branch    // Branch - Habilita salto condicional
);

    // Parámetros para los opcodes
    localparam R_TYPE = 6'b000000;

    always @(*) begin
        // Valores por defecto para evitar latches
        BR_En = 1'b0;
        AluC = 3'b000;
        EnW = 1'b0;
        EnR = 1'b0;
        Mux1 = 1'b0;
        regDest = 1'b0;
        Branch = 1'b0;
        AluSRC = 1'b0;

        case(Opcode)
            R_TYPE: begin
                // Señales para instrucciones tipo R
                BR_En = 1'b1;     // Habilitar escritura en registro
                AluC = 3'b000;    // Operación ALU determinada por campo funct
                EnW = 1'b0;       // No escribir en memoria
                EnR = 1'b0;       // No leer de memoria
                Mux1 = 1'b0;      // Seleccionar resultado de ALU
                regDest = 1'b1;   // Seleccionar rd como registro destino
                Branch = 1'b0;    // No es instrucción de salto
                AluSRC = 1'b0;    // Usar registro como segundo operando
            end
            
            default: begin
                // Mantener valores por defecto
            end
        endcase
    end

endmodule