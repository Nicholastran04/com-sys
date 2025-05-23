class VMTranslator:
    filename = ""
    label_counter = 0

    
    @staticmethod
    def set_filename(name):
        """Set the filename for static variable naming"""
        VMTranslator.filename = name

    @staticmethod
    def vm_push(segment, offset):
        '''Generate Hack Assembly code for a VM push operation'''
        assembly = []
        offset = int(offset)
        
        if segment == 'constant':
            assembly.extend([
                f"@{offset}",
                "D=A",
                "@SP",
                "A=M",
                "M=D",
                "@SP",
                "M=M+1"
            ])
            
        elif segment == 'local':
            assembly.extend([
                f"@{offset}",
                "D=A",
                "@LCL",
                "A=M+D",
                "D=M",
                "@SP",
                "A=M",
                "M=D",
                "@SP",
                "M=M+1"
            ])
            
        elif segment == 'argument':
            assembly.extend([
                f"@{offset}",
                "D=A",
                "@ARG",
                "A=M+D",
                "D=M",
                "@SP",
                "A=M",
                "M=D",
                "@SP",
                "M=M+1"
            ])
            
        elif segment == 'this':
            assembly.extend([
                f"@{offset}",
                "D=A",
                "@THIS",
                "A=M+D",
                "D=M",
                "@SP",
                "A=M",
                "M=D",
                "@SP",
                "M=M+1"
            ])
            
        elif segment == 'that':
            assembly.extend([
                f"@{offset}",
                "D=A",
                "@THAT",
                "A=M+D",
                "D=M",
                "@SP",
                "A=M",
                "M=D",
                "@SP",
                "M=M+1"
            ])
            
        elif segment == 'static':
            var_name = f"{VMTranslator.filename}.{offset}" if VMTranslator.filename else f"static.{offset}"
            assembly.extend([
                f"@{var_name}",
                "D=M",
                "@SP",
                "A=M",
                "M=D",
                "@SP",
                "M=M+1"
            ])
            
        elif segment == 'temp':
            address = 5 + offset
            if address > 12:
                raise ValueError(f"Temp offset {offset} out of range (0-7)")
            assembly.extend([
                f"@{address}",
                "D=M",
                "@SP",
                "A=M",
                "M=D",
                "@SP",
                "M=M+1"
            ])
            
        elif segment == 'pointer':
            if offset == 0:
                ptr_name = "THIS"
            elif offset == 1:
                ptr_name = "THAT"
            else:
                raise ValueError(f"Pointer offset {offset} out of range (0-1)")
            assembly.extend([
                f"@{ptr_name}",
                "D=M",
                "@SP",
                "A=M",
                "M=D",
                "@SP",
                "M=M+1"
            ])
        else:
            raise ValueError(f"Unknown segment: {segment}")
        
        return '\n'.join(assembly)

    @staticmethod 
    def vm_pop(segment, offset):
        '''Generate Hack Assembly code for a VM pop operation'''
        assembly = []
        offset = int(offset)
        
        if segment == 'constant':
            raise ValueError("Cannot pop to constant segment")
            
        elif segment == 'local':
            assembly.extend([
                f"@{offset}",
                "D=A",
                "@LCL",
                "D=M+D",
                "@R13",
                "M=D",
                "@SP",
                "M=M-1",
                "A=M",
                "D=M",
                "@R13",
                "A=M",
                "M=D"
            ])
            
        elif segment == 'argument':
            assembly.extend([
                f"@{offset}",
                "D=A",
                "@ARG",
                "D=M+D",
                "@R13",
                "M=D",
                "@SP",
                "M=M-1",
                "A=M",
                "D=M",
                "@R13",
                "A=M",
                "M=D"
            ])
            
        elif segment == 'this':
            assembly.extend([
                f"@{offset}",
                "D=A",
                "@THIS",
                "D=M+D",
                "@R13",
                "M=D",
                "@SP",
                "M=M-1",
                "A=M",
                "D=M",
                "@R13",
                "A=M",
                "M=D"
            ])
            
        elif segment == 'that':
            assembly.extend([
                f"@{offset}",
                "D=A",
                "@THAT",
                "D=M+D",
                "@R13",
                "M=D",
                "@SP",
                "M=M-1",
                "A=M",
                "D=M",
                "@R13",
                "A=M",
                "M=D"
            ])
            
        elif segment == 'static':
            var_name = f"{VMTranslator.filename}.{offset}" if VMTranslator.filename else f"static.{offset}"
            assembly.extend([
                "@SP",
                "M=M-1",
                "A=M",
                "D=M",
                f"@{var_name}",
                "M=D"
            ])
            
        elif segment == 'temp':
            address = 5 + offset
            if address > 12:
                raise ValueError(f"Temp offset {offset} out of range (0-7)")
            assembly.extend([
                "@SP",
                "M=M-1",
                "A=M",
                "D=M",
                f"@{address}",
                "M=D"
            ])
            
        elif segment == 'pointer':
            if offset == 0:
                ptr_name = "THIS"
            elif offset == 1:
                ptr_name = "THAT"
            else:
                raise ValueError(f"Pointer offset {offset} out of range (0-1)")
            assembly.extend([
                "@SP",
                "M=M-1",
                "A=M",
                "D=M",
                f"@{ptr_name}",
                "M=D"
            ])
        else:
            raise ValueError(f"Unknown segment: {segment}")
        
        return '\n'.join(assembly)

    @staticmethod
    def vm_add():
        '''Generate Hack Assembly code for a VM add operation'''
        return """@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M+D
@SP
M=M+1"""

    @staticmethod
    def vm_sub():
        '''Generate Hack Assembly code for a VM sub operation'''
        return """@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M-D
@SP
M=M+1"""

    @staticmethod
    def vm_neg():
        '''Generate Hack Assembly code for a VM neg operation'''
        return """@SP
M=M-1
A=M
M=-M
@SP
M=M+1"""

    @staticmethod
    def vm_eq():
        '''Generate Hack Assembly code for a VM eq operation'''
        VMTranslator.label_counter += 1
        label_id = VMTranslator.label_counter
        return f"""@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
@EQ_TRUE{label_id}
D;JEQ
@SP
A=M
M=0
@EQ_END{label_id}
0;JMP
(EQ_TRUE{label_id})
@SP
A=M
M=-1
(EQ_END{label_id})
@SP
M=M+1"""

    @staticmethod
    def vm_gt():
        '''Generate Hack Assembly code for a VM gt operation'''
        VMTranslator.label_counter += 1
        label_id = VMTranslator.label_counter
        return f"""@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
@GT_TRUE{label_id}
D;JGT
@SP
A=M
M=0
@GT_END{label_id}
0;JMP
(GT_TRUE{label_id})
@SP
A=M
M=-1
(GT_END{label_id})
@SP
M=M+1"""

    @staticmethod
    def vm_lt():
        '''Generate Hack Assembly code for a VM lt operation'''
        label_true = f"LT_TRUE_{VMTranslator.label_counter}"
        label_end = f"LT_END_{VMTranslator.label_counter}"
        VMTranslator.label_counter += 1
        return f"""@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
@{label_true}
D;JLT
@SP
A=M
M=0
@{label_end}
0;JMP
({label_true})
@SP
A=M
M=-1
({label_end})
@SP
M=M+1"""

    @staticmethod
    def vm_and():
        return """@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M&D
@SP
M=M+1"""

    def vm_or():
        '''Generate Hack Assembly code for a VM or operation'''
        return ""

    def vm_not():
        '''Generate Hack Assembly code for a VM not operation'''
        return ""

    def vm_label(label):
        '''Generate Hack Assembly code for a VM label operation'''
        return ""

    def vm_goto(label):
        '''Generate Hack Assembly code for a VM goto operation'''
        return ""

    def vm_if(label):
        '''Generate Hack Assembly code for a VM if-goto operation'''
        return ""

    def vm_function(function_name, n_vars):
        '''Generate Hack Assembly code for a VM function operation'''
        return ""

    def vm_call(function_name, n_args):
        '''Generate Hack Assembly code for a VM call operation'''
        return ""

    def vm_return():
        '''Generate Hack Assembly code for a VM return operation'''
        return ""

# A quick-and-dirty parser when run as a standalone script.
if __name__ == "__main__":
    import sys
    if(len(sys.argv) > 1):
        with open(sys.argv[1], "r") as a_file:
            for line in a_file:
                tokens = line.strip().lower().split()
                if(len(tokens)==1):
                    if(tokens[0]=='add'):
                        print(VMTranslator.vm_add())
                    elif(tokens[0]=='sub'):
                        print(VMTranslator.vm_sub())
                    elif(tokens[0]=='neg'):
                        print(VMTranslator.vm_neg())
                    elif(tokens[0]=='eq'):
                        print(VMTranslator.vm_eq())
                    elif(tokens[0]=='gt'):
                        print(VMTranslator.vm_gt())
                    elif(tokens[0]=='lt'):
                        print(VMTranslator.vm_lt())
                    elif(tokens[0]=='and'):
                        print(VMTranslator.vm_and())
                    elif(tokens[0]=='or'):
                        print(VMTranslator.vm_or())
                    elif(tokens[0]=='not'):
                        print(VMTranslator.vm_not())
                    elif(tokens[0]=='return'):
                        print(VMTranslator.vm_return())
                elif(len(tokens)==2):
                    if(tokens[0]=='label'):
                        print(VMTranslator.vm_label(tokens[1]))
                    elif(tokens[0]=='goto'):
                        print(VMTranslator.vm_goto(tokens[1]))
                    elif(tokens[0]=='if-goto'):
                        print(VMTranslator.vm_if(tokens[1]))
                elif(len(tokens)==3):
                    if(tokens[0]=='push'):
                        print(VMTranslator.vm_push(tokens[1],int(tokens[2])))
                    elif(tokens[0]=='pop'):
                        print(VMTranslator.vm_pop(tokens[1],int(tokens[2])))
                    elif(tokens[0]=='function'):
                        print(VMTranslator.vm_function(tokens[1],int(tokens[2])))
                    elif(tokens[0]=='call'):
                        print(VMTranslator.vm_call(tokens[1],int(tokens[2])))
