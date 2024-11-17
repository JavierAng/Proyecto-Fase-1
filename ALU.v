`timescale 1ns/1ns

module ALU (
    input [31:0] Ope1,
    input [31:0] Ope2,
    input [2:0] AluOp,
    output reg [31:0] Resultado,
    output reg zero
);

    always @* begin
        case(AluOp)
            3'b000: Resultado = Ope1 & Ope2;    // AND
            3'b001: Resultado = Ope1 | Ope2;    // OR
            3'b010: Resultado = Ope1 + Ope2;    // ADD
            3'b011: Resultado = Ope1 ^ Ope2;    // XOR
            3'b100: Resultado = ~(Ope1 | Ope2); // NOR
            3'b110: Resultado = Ope1 - Ope2;    // SUB
            3'b111: Resultado = (Ope1 < Ope2) ? 32'd1 : 32'd0; // SLT
            default: Resultado = 32'b0;         // Caso por defecto
        endcase
        
        // Actualizar flag zero
        zero = (Resultado == 32'b0);
    end

endmodule