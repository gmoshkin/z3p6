use v6;

use NativeCall;

unit module Z3;
need Z3::Constants;

constant LIB = 'z3';

# global

sub Z3_global_param_set(Str is encoded('utf8'), Str is encoded('utf8'))
    is native(LIB) {...}
sub Z3_global_param_reset_all() is native(LIB) {...}
sub Z3_global_param_get(Str is encoded('utf8'), Str is encoded('utf8'))
    returns int32 is native(LIB) {...}

sub z3-global-param-set(Str:D $id, Str:D $value) is export {
    Z3_global_param_set($id, $value);
}

sub z3-global-param-reset-all is export {
    Z3_global_param_reset_all;
}

sub z3-global-param-get(Str:D $id, Str:D $value) is export {
    Z3_global_param_get($id, $value).so;
}

class Z3-Context is repr('CPointer') is export {...}

# config

class Z3-Config is repr('CPointer') is export {
    sub Z3_mk_config() returns Z3-Config is native(LIB) {...}
    sub Z3_del_config(Z3-Config) is native(LIB) {...}
    sub Z3_set_param_value(Z3-Config, Str is encoded('utf8'),
                           Str is encoded('utf8')) is native(LIB) {...}
    sub Z3_mk_context(Z3-Config) returns Z3-Context is native(LIB) {...}
    sub Z3_mk_context_rc(Z3-Config) returns Z3-Context is native(LIB) {...}

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

# context
class Z3-Ast is repr('CPointer') is export {...}

class Z3-Context {
    sub Z3_del_context(Z3-Context) is native(LIB) {...}
    sub Z3_inc_ref(Z3-Context, Z3-Ast) is native(LIB) {...}
    sub Z3_dec_ref(Z3-Context, Z3-Ast) is native(LIB) {...}
    sub Z3_update_param_value(Z3-Context, Str is encoded('utf8'),
                              Str is encoded('utf8')) is native(LIB) {...}
    sub Z3_interrupt(Z3-Context) is native(LIB) {...}

    method new(Z3-Config:D $config) {
        $config.mk-context;
    }

    submethod DESTROY {
        Z3_del_context(self);
    }

    method inc-ref(Z3-Ast:D $ast) {
        Z3_inc_ref(self, $ast);
    }

    method dec-ref(Z3-Ast:D $ast) {
        Z3_dec_ref(self, $ast);
    }

    method update-param-value(Str:D $id, Str:D $value) {
        Z3_update_param_value(self, $id, $value);
    }

    method interrupt() {
        Z3_interrupt(self);
    }
}

sub Z3_get_version(uint32 $major is rw, uint32 $minor is rw,
                   uint32 $build is rw, uint32 $rev is rw) is native(LIB) {...}

sub z3-get-version() is export {
    Z3_get_version(my uint32 $major, my uint32 $minor, my uint32 $build, my uint32 $rev);
    Version.new: "$major.$minor.$build.$rev";
}
