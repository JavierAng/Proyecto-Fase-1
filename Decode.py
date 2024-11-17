import tkinter as tk

# Función decodificadora
def decode_instruction():
    asm_code = asm_entry.get("1.0", tk.END).strip()
    decoded_text = ""

    lines = asm_code.split('\n')
    for line in lines:
        if 'MOV' in line:
            parts = line.split(',')
            reg = parts[0].split()[1]
            value = parts[1].strip()
            decoded_text += f'Move {value} to {reg}\n'
        elif 'ADD' in line:
            parts = line.split(',')
            reg_dest = parts[0].split()[1]
            reg_src1 = parts[1].strip()
            reg_src2 = parts[2].strip()
            decoded_text += f'Add {reg_src1} and {reg_src2}, store in {reg_dest}\n'
        elif 'SUB' in line:
            parts = line.split(',')
            reg_dest = parts[0].split()[1]
            reg_src1 = parts[1].strip()
            reg_src2 = parts[2].strip()
            decoded_text += f'Subtract {reg_src2} from {reg_src1}, store in {reg_dest}\n'
        elif 'AND' in line:
            parts = line.split(',')
            reg_dest = parts[0].split()[1]
            reg_src1 = parts[1].strip()
            reg_src2 = parts[2].strip()
            decoded_text += f'AND {reg_src1} and {reg_src2}, store in {reg_dest}\n'
    
    output_label.config(text=decoded_text)

# Configuración de la GUI
root = tk.Tk()
root.title("Decodificador ASM")

# Crear widgets
asm_label = tk.Label(root, text="Ingresa el código ASM:")
asm_entry = tk.Text(root, height=10, width=50)
decode_button = tk.Button(root, text="Decodificar", command=decode_instruction)
output_label = tk.Label(root, text="", justify='left')

# Colocar widgets en la ventana
asm_label.pack(pady=5)
asm_entry.pack(pady=5)
decode_button.pack(pady=5)
output_label.pack(pady=10)

# Ejecutar el loop de la GUI
root.mainloop()
