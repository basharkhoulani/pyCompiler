import os
import compiler
import compiler_register_allocator as ra_compiler
import compiler_conditionals as cond_compiler
import interp_Lvar
import interp_Lif
import interp_Cif
import type_check_Lvar
import type_check_Lif
import type_check_Cif
from utils import run_tests, run_one_test
from interp_x86.eval_x86 import interp_x86

compiler = compiler.Compiler()
ra_compiler = ra_compiler.Compiler()
cond_compiler = cond_compiler.Compiler()

typecheck_Lvar = type_check_Lvar.TypeCheckLvar().type_check

typecheck_dict = {
    'source': typecheck_Lvar,
    'remove_complex_operands': typecheck_Lvar,
}

interpLvar = interp_Lvar.InterpLvar().interp
interp_dict = {
    'remove_complex_operands': interpLvar,
    'select_instructions': interp_x86,
    'assign_homes': interp_x86,
    'patch_instructions': interp_x86,
}

run_tests('var', compiler, 'var', typecheck_dict, interp_dict)
run_tests('regalloc', ra_compiler, 'regalloc', typecheck_dict, interp_dict)

###########################################################################

typecheck_Lif = type_check_Lif.TypeCheckLif().type_check
typecheck_Cif = type_check_Cif.TypeCheckCif().type_check

typecheck_dict = {
    'source': typecheck_Lif,
    'remove_complex_operands': typecheck_Lif,
    'explicate_control': typecheck_Cif,
}

interpLif = interp_Lif.InterpLif().interp
interpCif = interp_Cif.InterpCif().interp
interp_dict = {
    'shrink': interpLif,
    'remove_complex_operands': interpLif,
    'explicate_control': interpCif,
    'select_instructions': interp_x86,
    'assign_homes': interp_x86,
    'patch_instructions': interp_x86,
}

run_tests('lif', cond_compiler, 'lif', typecheck_dict, interp_dict)
