import os
import compiler_tup as compiler
import interp_Ltup
import interp_Ctup
import type_check_Ctup
import type_check_Ltup
from utils import run_tests, run_one_test
from interp_x86.eval_x86 import interp_x86

compiler = compiler.Compiler()

###########################################################################

typecheck_Lif = type_check_Ltup.TypeCheckLtup().type_check
typecheck_Cif = type_check_Ctup.TypeCheckCtup().type_check

typecheck_dict = {
    'source': typecheck_Lif,
    'remove_complex_operands': typecheck_Lif,
    'explicate_control': typecheck_Cif,
}

interpLif = interp_Ltup.InterpLtup().interp
interpCif = interp_Ctup.InterpCtup().interp
interp_dict = {
    'shrink': interpLif,
    'remove_complex_operands': interpLif,
    'explicate_control': interpCif,
    'select_instructions': interp_x86,
    'assign_homes': interp_x86,
    'patch_instructions': interp_x86,
}

run_tests('var', compiler, 'tup', typecheck_dict, interp_dict)
run_tests('regalloc', compiler, 'tup', typecheck_dict, interp_dict)
run_tests('lif', compiler, 'tup', typecheck_dict, interp_dict)
run_tests('while', compiler, 'tup', typecheck_dict, interp_dict)
