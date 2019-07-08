use v6;

use NativeCall;
use Z3::Constants;

unit module Z3::Core;

constant LIB = 'z3';

# Global Parameters {{{

sub Z3_global_param_set(Str is encoded('utf8'), Str is encoded('utf8')) is native(LIB)                {…}
sub Z3_global_param_reset_all() is native(LIB)                                                        {…}
sub Z3_global_param_get(Str is encoded('utf8'), Str is encoded('utf8')) returns int32 is native(LIB)  {…}

sub z3-global-param-set(Str:D $id, Str:D $value) is export { Z3_global_param_set($id, $value); }
sub z3-global-param-reset-all                    is export { Z3_global_param_reset_all; }
sub z3-global-param-get(Str:D $id, Str:D $value) is export { Z3_global_param_get($id, $value).so; }

# }}}
# Types {{{

class Z3-Config           is repr('CPointer') is export {…}
class Z3-Context          is repr('CPointer') is export {…}
class Z3-Ast              is repr('CPointer') is export {}
class Z3-Symbol           is repr('CPointer') is export {}
class Z3-Sort             is repr('CPointer') is export {}
class Z3-Func-Decl        is repr('CPointer') is export {}
class Z3-App              is repr('CPointer') is export {}
class Z3-Pattern          is repr('CPointer') is export {}
class Z3-Constructor      is repr('CPointer') is export {}
class Z3-Constructor-List is repr('CPointer') is export {}
class Z3-Params           is repr('CPointer') is export {}
class Z3-Param-Descrs     is repr('CPointer') is export {}
class Z3-Model            is repr('CPointer') is export {}
class Z3-Func-Interp      is repr('CPointer') is export {}
class Z3-Func-Entry       is repr('CPointer') is export {}
class Z3-Fixedpoint       is repr('CPointer') is export {}
class Z3-Optimize         is repr('CPointer') is export {}
class Z3-Ast-Vector       is repr('CPointer') is export {}
class Z3-Ast-Map          is repr('CPointer') is export {}
class Z3-Goal             is repr('CPointer') is export {}
class Z3-Tactic           is repr('CPointer') is export {}
class Z3-Probe            is repr('CPointer') is export {}
class Z3-Apply-Result     is repr('CPointer') is export {}
class Z3-Solver           is repr('CPointer') is export {}
class Z3-Stats            is repr('CPointer') is export {}

# }}}
# Algebraic Numbers {{{

sub Z3_algebraic_is_value  (Z3-Context, Z3-Ast)                         returns Bool          is native(LIB)  {…}
sub Z3_algebraic_is_pos    (Z3-Context, Z3-Ast)                         returns Bool          is native(LIB)  {…}
sub Z3_algebraic_is_neg    (Z3-Context, Z3-Ast)                         returns Bool          is native(LIB)  {…}
sub Z3_algebraic_is_zero   (Z3-Context, Z3-Ast)                         returns Bool          is native(LIB)  {…}
sub Z3_algebraic_sign      (Z3-Context, Z3-Ast)                         returns int32         is native(LIB)  {…}
sub Z3_algebraic_add       (Z3-Context, Z3-Ast, Z3-Ast)                 returns Z3-Ast        is native(LIB)  {…}
sub Z3_algebraic_sub       (Z3-Context, Z3-Ast, Z3-Ast)                 returns Z3-Ast        is native(LIB)  {…}
sub Z3_algebraic_mul       (Z3-Context, Z3-Ast, Z3-Ast)                 returns Z3-Ast        is native(LIB)  {…}
sub Z3_algebraic_div       (Z3-Context, Z3-Ast, Z3-Ast)                 returns Z3-Ast        is native(LIB)  {…}
sub Z3_algebraic_root      (Z3-Context, Z3-Ast, uint32)                 returns Z3-Ast        is native(LIB)  {…}
sub Z3_algebraic_power     (Z3-Context, Z3-Ast, uint32)                 returns Z3-Ast        is native(LIB)  {…}
sub Z3_algebraic_lt        (Z3-Context, Z3-Ast, Z3-Ast)                 returns Bool          is native(LIB)  {…}
sub Z3_algebraic_gt        (Z3-Context, Z3-Ast, Z3-Ast)                 returns Bool          is native(LIB)  {…}
sub Z3_algebraic_le        (Z3-Context, Z3-Ast, Z3-Ast)                 returns Bool          is native(LIB)  {…}
sub Z3_algebraic_ge        (Z3-Context, Z3-Ast, Z3-Ast)                 returns Bool          is native(LIB)  {…}
sub Z3_algebraic_eq        (Z3-Context, Z3-Ast, Z3-Ast)                 returns Bool          is native(LIB)  {…}
sub Z3_algebraic_neq       (Z3-Context, Z3-Ast, Z3-Ast)                 returns Bool          is native(LIB)  {…}
sub Z3_algebraic_roots     (Z3-Context, Z3-Ast, uint32, CArray[Z3-Ast]) returns Z3-Ast-Vector is native(LIB)  {…}
sub Z3_algebraic_eval      (Z3-Context, Z3-Ast, uint32, CArray[Z3-Ast]) returns int32         is native(LIB)  {…}

# }}}
# Symbols {{{

sub Z3_mk_int_symbol    (Z3-Context, int32)                  returns Z3-Symbol is native(LIB) {…}
sub Z3_mk_string_symbol (Z3-Context, Str is encoded('utf8')) returns Z3-Symbol is native(LIB) {…}

# }}}
# Sorts {{{

sub Z3_mk_uninterpreted_sort(Z3-Context, Z3-Symbol) returns Z3-Sort                                                                                                                          is native(LIB) {…}
sub Z3_mk_bool_sort(Z3-Context) returns Z3-Sort                                                                                                                                              is native(LIB) {…}
sub Z3_mk_int_sort(Z3-Context) returns Z3-Sort                                                                                                                                               is native(LIB) {…}
sub Z3_mk_real_sort(Z3-Context) returns Z3-Sort                                                                                                                                              is native(LIB) {…}
sub Z3_mk_bv_sort(Z3-Context, uint32) returns Z3-Sort                                                                                                                                        is native(LIB) {…}
sub Z3_mk_finite_domain_sort(Z3-Context, Z3-Symbol, uint64) returns Z3-Sort                                                                                                                  is native(LIB) {…}
sub Z3_mk_array_sort(Z3-Context, Z3-Sort, Z3-Sort) returns Z3-Sort                                                                                                                           is native(LIB) {…}
sub Z3_mk_array_sort_n(Z3-Context, uint32, Z3-Sort is rw, Z3-Sort) returns Z3-Sort                                                                                                           is native(LIB) {…}
sub Z3_mk_tuple_sort(Z3-Context, Z3-Symbol, uint32, CArray[Z3-Symbol], CArray[Z3-Sort], Z3-Func-Decl is rw, CArray[Z3-Func-Decl]) returns Z3-Sort                                            is native(LIB) {…}
sub Z3_mk_enumeration_sort(Z3-Context, Z3-Symbol, uint32, CArray[Z3-Symbol], CArray[Z3-Func-Decl], CArray[Z3-Func-Decl]) returns Z3-Sort                                                     is native(LIB) {…}
sub Z3_mk_list_sort(Z3-Context, Z3-Symbol, Z3-Sort, Z3-Func-Decl is rw, Z3-Func-Decl is rw, Z3-Func-Decl is rw, Z3-Func-Decl is rw, Z3-Func-Decl is rw, Z3-Func-Decl is rw) returns Z3-Sort  is native(LIB) {…}
sub Z3_mk_constructor(Z3-Context, Z3-Symbol, Z3-Symbol, uint32, CArray[Z3-Symbol], CArray[Z3-Sort], CArray[uint32]) returns Z3-Constructor                                                   is native(LIB) {…}
sub Z3_del_constructor(Z3-Context, Z3-Constructor)                                                                                                                                           is native(LIB) {…}
sub Z3_mk_datatype(Z3-Context, Z3-Symbol, uint32, CArray[Z3-Constructor]) returns Z3-Sort                                                                                                    is native(LIB) {…}
sub Z3_mk_constructor_list(Z3-Context, uint32, CArray[Z3-Constructor]) returns Z3-Constructor-List                                                                                           is native(LIB) {…}
sub Z3_del_constructor_list(Z3-Context, Z3-Constructor-List)                                                                                                                                 is native(LIB) {…}
sub Z3_mk_datatypes(Z3-Context, uint32, CArray[Z3-Symbol], CArray[Z3-Sort], CArray[Z3-Constructor-List])                                                                                     is native(LIB) {…}
sub Z3_query_constructor(Z3-Context, Z3-Constructor, uint32, Z3-Func-Decl is rw, Z3-Func-Decl is rw, CArray[Z3-Func-Decl])                                                                   is native(LIB) {…}

# }}}
# Constants and Applications {{{

# sub Z3_mk_func_decl(Z3-Context, )                      is native(LIB) {…}
# sub Z3_mk_app(Z3-Context, )             returns Z3-Ast is native(LIB) {…}
sub Z3_mk_const(Z3-Context, Z3-Symbol, Z3-Sort) returns Z3-Ast is native(LIB) {…}
# sub Z3_mk_fresh_func_decl(Z3-Context, )                is native(LIB) {…}
# sub Z3_mk_fresh_const(Z3-Context, )     returns Z3-Ast is native(LIB) {…}
# sub Z3_mk_rec_func_decl(Z3-Context, )                  is native(LIB) {…}
# sub Z3_add_rec_def(Z3-Context, )                       is native(LIB) {…}

# }}}
# Propositional Logic and Equality {{{

sub Z3_mk_true(Z3-Context) returns Z3-Ast                              is native(LIB) {…}
sub Z3_mk_false(Z3-Context) returns Z3-Ast                             is native(LIB) {…}
sub Z3_mk_eq(Z3-Context, Z3-Ast, Z3-Ast) returns Z3-Ast                is native(LIB) {…}
sub Z3_mk_distinct(Z3-Context, uint32, CArray[Z3-Ast]) returns Z3-Ast  is native(LIB) {…}
sub Z3_mk_not(Z3-Context, Z3-Ast) returns Z3-Ast                       is native(LIB) {…}
sub Z3_mk_ite(Z3-Context, Z3-Ast, Z3-Ast, Z3-Ast) returns Z3-Ast       is native(LIB) {…}
sub Z3_mk_iff(Z3-Context, Z3-Ast, Z3-Ast) returns Z3-Ast               is native(LIB) {…}
sub Z3_mk_implies(Z3-Context, Z3-Ast, Z3-Ast) returns Z3-Ast           is native(LIB) {…}
sub Z3_mk_xor(Z3-Context, Z3-Ast, Z3-Ast) returns Z3-Ast               is native(LIB) {…}
sub Z3_mk_and(Z3-Context, uint32, CArray[Z3-Ast]) returns Z3-Ast       is native(LIB) {…}
sub Z3_mk_or(Z3-Context, uint32, CArray[Z3-Ast]) returns Z3-Ast        is native(LIB) {…}

# }}}
# Solvers {{{

sub Z3_mk_solver(Z3-Context) returns Z3-Solver                                                                    is native(LIB) {…}
sub Z3_mk_simple_solver(Z3-Context) returns Z3-Solver                                                             is native(LIB) {…}
sub Z3_mk_solver_for_logic(Z3-Context, Z3-Symbol) returns Z3-Solver                                               is native(LIB) {…}
sub Z3_mk_solver_from_tactic(Z3-Context, Z3-Tactic) returns Z3-Solver                                             is native(LIB) {…}
sub Z3_solver_translate(Z3-Context, Z3-Solver, Z3-Context) returns Z3-Solver                                      is native(LIB) {…}
sub Z3_solver_import_model_converter(Z3-Context, Z3-Solver, Z3-Solver)                                            is native(LIB) {…}
sub Z3_solver_get_help(Z3-Context, Z3-Solver) returns Str is encoded('utf8')                                      is native(LIB) {…}
sub Z3_solver_get_param_descrs(Z3-Context, Z3-Solver) returns Z3-Param-Descrs                                     is native(LIB) {…}
sub Z3_solver_set_params(Z3-Context, Z3-Solver, Z3-Params)                                                        is native(LIB) {…}
sub Z3_solver_inc_ref(Z3-Context, Z3-Solver)                                                                      is native(LIB) {…}
sub Z3_solver_dec_ref(Z3-Context, Z3-Solver)                                                                      is native(LIB) {…}
sub Z3_solver_push(Z3-Context, Z3-Solver)                                                                         is native(LIB) {…}
sub Z3_solver_pop(Z3-Context, Z3-Solver, uint32)                                                                  is native(LIB) {…}
sub Z3_solver_reset(Z3-Context, Z3-Solver)                                                                        is native(LIB) {…}
sub Z3_solver_get_num_scopes(Z3-Context, Z3-Solver) returns uint32                                                is native(LIB) {…}
sub Z3_solver_assert(Z3-Context, Z3-Solver, Z3-Ast)                                                               is native(LIB) {…}
sub Z3_solver_assert_and_track(Z3-Context, Z3-Solver, Z3-Ast, Z3-Ast)                                             is native(LIB) {…}
sub Z3_solver_from_file(Z3-Context, Z3-Solver, Str is encoded('utf8'))                                            is native(LIB) {…}
sub Z3_solver_from_string(Z3-Context, Z3-Solver, Str is encoded('utf8'))                                          is native(LIB) {…}
sub Z3_solver_get_assertions(Z3-Context, Z3-Solver) returns Z3-Ast-Vector                                         is native(LIB) {…}
sub Z3_solver_get_units(Z3-Context, Z3-Solver) returns Z3-Ast-Vector                                              is native(LIB) {…}
sub Z3_solver_get_trail(Z3-Context, Z3-Solver) returns Z3-Ast-Vector                                              is native(LIB) {…}
sub Z3_solver_get_non_units(Z3-Context, Z3-Solver) returns Z3-Ast-Vector                                          is native(LIB) {…}
sub Z3_solver_get_levels(Z3-Context, Z3-Solver, Z3-Ast-Vector, uint32, CArray[uint32])                            is native(LIB) {…}
sub Z3_solver_check(Z3-Context, Z3-Solver) returns int32                                                          is native(LIB) {…}
sub Z3_solver_check_assumptions(Z3-Context, Z3-Solver, uint32, CArray[Z3-Ast]) returns int32                      is native(LIB) {…}
sub Z3_get_implied_equalities(Z3-Context, Z3-Solver, uint32, CArray[Z3-Ast], CArray[uint32]) returns int32        is native(LIB) {…}
sub Z3_solver_get_consequences(Z3-Context, Z3-Solver, Z3-Ast-Vector, Z3-Ast-Vector, Z3-Ast-Vector) returns int32  is native(LIB) {…}
sub Z3_solver_cube(Z3-Context, Z3-Solver, Z3-Ast-Vector, uint32) returns Z3-Ast-Vector                            is native(LIB) {…}
sub Z3_solver_get_model(Z3-Context, Z3-Solver) returns Z3-Model                                                   is native(LIB) {…}
sub Z3_solver_get_proof(Z3-Context, Z3-Solver) returns Z3-Ast                                                     is native(LIB) {…}
sub Z3_solver_get_unsat_core(Z3-Context, Z3-Solver) returns Z3-Ast-Vector                                         is native(LIB) {…}
sub Z3_solver_get_reason_unknown(Z3-Context, Z3-Solver) returns Str is encoded('utf8')                            is native(LIB) {…}
sub Z3_solver_get_statistics(Z3-Context, Z3-Solver) returns Z3-Stats                                              is native(LIB) {…}
sub Z3_solver_to_string(Z3-Context, Z3-Solver) returns Str is encoded('utf8')                                     is native(LIB) {…}
sub Z3_solver_to_dimacs_string(Z3-Context, Z3-Solver) returns Str is encoded('utf8')                              is native(LIB) {…}

# }}}

# Create configuration {{{
sub Z3_mk_config() returns Z3-Config                                               is native(LIB) {…}
sub Z3_del_config(Z3-Config)                                                       is native(LIB) {…}
sub Z3_set_param_value(Z3-Config, Str is encoded('utf8'), Str is encoded('utf8'))  is native(LIB) {…}
sub Z3_mk_context(Z3-Config) returns Z3-Context                                    is native(LIB) {…}
sub Z3_mk_context_rc(Z3-Config) returns Z3-Context                                 is native(LIB) {…}

class Z3-Config {

    method new {
        Z3_mk_config;
    }

    submethod DESTROY {
        Z3_del_config(self);
    }

    method set-param-value(Str:D $id, Str:D $value) {
        Z3_set_param_value(self, $id, $value);
    }

    method mk-context {
        Z3_mk_context(self);
    }

    method mk-context-rc {
        Z3_mk_context_rc(self);
    }
}

# }}}
# Context and AST Reference Counting {{{
sub Z3_del_context(Z3-Context)                                                         is native(LIB) {…}
sub Z3_inc_ref(Z3-Context, Z3-Ast)                                                     is native(LIB) {…}
sub Z3_dec_ref(Z3-Context, Z3-Ast)                                                     is native(LIB) {…}
sub Z3_update_param_value(Z3-Context, Str is encoded('utf8'), Str is encoded('utf8'))  is native(LIB) {…}
sub Z3_interrupt(Z3-Context)                                                           is native(LIB) {…}

class Expr is export {…}
class Solver is export {…}

class Z3-Context {

    multi method new {
        self.new(Z3-Config.new);
    }

    multi method new(Z3-Config:D $config) {
        $config.mk-context;
    }

    submethod DESTROY {
        Z3_del_context(self);
    }

    multi method inc-ref(Z3-Ast:D $ast) {
        Z3_inc_ref(self, $ast);
    }

    multi method inc-ref(Z3-Solver:D $slv) {
        Z3_solver_inc_ref(self, $slv);
    }

    multi method dec-ref(Z3-Ast:D $ast) {
        Z3_dec_ref(self, $ast);
    }

    multi method dec-ref(Z3-Solver:D $slv) {
        Z3_solver_dec_ref(self, $slv);
    }

    method update-param-value(Str:D $id, Str:D $value) {
        Z3_update_param_value(self, $id, $value);
    }

    method interrupt() {
        Z3_interrupt(self);
    }

    method mk-solver {
        Solver.new(slv => Z3_mk_solver(self), ctx => self);
    }

    method Expr(Z3-Ast:D $ast) {
        Expr.new(:$ast, :ctx(self))
    }

    multi method mk-const(Z3-Symbol $symb, Z3-Sort $sort) {
        $.Expr(Z3_mk_const(self, $symb, $sort))
    }

    multi method mk-sort(Bool) {
        Z3_mk_bool_sort(self);
    }

    multi method mk-symbol(Str:D $name) {
        Z3_mk_string_symbol(self, $name);
    }

    multi method mk-symbol(Int:D $name) {
        Z3_mk_int_symbol(self, $name);
    }

    method xor(Expr:D $lhs, Expr:D $rhs) {
        Z3_mk_xor(self, $lhs.Ast, $rhs.Ast);
    }

    method and(*@exprs where .all ~~ Expr:D) {
        Z3_mk_and(self, @exprs.elems, CArray[Z3-Ast].new(@exprs».Ast));
    }

    method or(*@exprs where .all ~~ Expr:D) {
        $.Expr(Z3_mk_or(self, @exprs.elems, CArray[Z3-Ast].new(@exprs».Ast)));
    }
}

# }}}
# ast

class Expr {
    has Z3-Ast $!ast;
    has Z3-Context $!ctx;

    submethod BUILD(Z3-Ast:D :$!ast, Z3-Context:D :$!ctx) {
        $!ctx.inc-ref($!ast);
    }

    submethod DESTROY {
        $!ctx.dec-ref($!ast);
    }

    method Ast {
        $!ast;
    }

    method not {
        Expr.new(ast => Z3_mk_not($!ctx, $!ast), :$!ctx);
    }
}

# Solver {{{

class Solver {
    has Z3-Solver $!slv;
    has Z3-Context $!ctx;

    submethod BUILD(Z3-Solver:D :$!slv, Z3-Context:D :$!ctx) {
        $!ctx.inc-ref($!slv);
    }

    submethod DESTROY {
        $!ctx.dec-ref($!slv);
    }

    method assert(*@exprs where .all ~~ Expr:D) {
        Z3_solver_assert($!ctx, $!slv, .Ast) for @exprs;
    }

    method check {
        Z3-lbool(Z3_solver_check($!ctx, $!slv));
    }

    method model {
        Z3_solver_get_model($!ctx, $!slv);
    }
}

# }}}

# Miscellaneous {{{

sub Z3_get_version(uint32 $major is rw, uint32 $minor is rw, uint32 $build is rw, uint32 $rev is rw) is native(LIB) {…}
sub Z3_get_full_version() returns Str is encoded('utf8') is native(LIB) {…}
sub Z3_enable_trace(Str is encoded('utf8'))              is native(LIB) {…}
sub Z3_disable_trace(Str is encoded('utf8'))             is native(LIB) {…}
sub Z3_reset_memory()                                    is native(LIB) {…}
sub Z3_finalize_memory()                                 is native(LIB) {…}

# wrappers

sub z3-get-version() is export {
    Z3_get_version(my uint32 $major, my uint32 $minor, my uint32 $build, my uint32 $rev);
    Version.new: "$major.$minor.$build.$rev";
}

# }}}
