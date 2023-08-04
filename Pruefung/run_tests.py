import compiler_tup as compiler
import interp_Ltup
import interp_Ctup
import type_check_Ctup
import type_check_Ltup
from utils import run_tests, enable_tracing
from interp_x86.eval_x86 import interp_x86

compiler = compiler.Compiler()

###########################################################################

type_check_Ltup = type_check_Ltup.TypeCheckLtup().type_check
type_check_Ctup = type_check_Ctup.TypeCheckCtup().type_check

typecheck_dict = {
    'source': type_check_Ltup,
    'remove_complex_operands': type_check_Ltup,
    'explicate_control': type_check_Ctup,
}

interp_Ltup = interp_Ltup.InterpLtup().interp
interp_Ctup = interp_Ctup.InterpCtup().interp
interp_dict = {
    'shrink': interp_Ltup,
    'remove_complex_operands': interp_Ltup,
    'expose_allocation': interp_Ltup,
    'explicate_control': interp_Ctup,
    'select_instructions': interp_x86,
    'assign_homes': interp_x86,
    'patch_instructions': interp_x86,
    'prelude_and_conclusion': interp_x86,
}

# enable_tracing()

run_tests('var', compiler, 'tup', typecheck_dict, interp_dict)
run_tests('regalloc', compiler, 'tup', typecheck_dict, interp_dict)
run_tests('lif', compiler, 'tup', typecheck_dict, interp_dict)
run_tests('while', compiler, 'tup', typecheck_dict, interp_dict)

run_tests('tup', compiler, 'tup', typecheck_dict, {
   'shrink': interp_Ltup,
   'expose_allocation': interp_Ltup,
   'remove_complex_operands': interp_Ltup,
   'explicate_control': interp_Ctup,
   'prelude_and_conclusion': interp_x86,
})