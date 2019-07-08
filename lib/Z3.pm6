use v6;

unit module Z3;
use Z3::Constants;
use Z3::Core;

sub main-ctx {
    state Z3::Core::Z3-Context $main-ctx .= new;
    $main-ctx;
}

sub bool(Cool:D $name) is export {
    .mk-const(.mk-symbol($name), .mk-sort(Bool)) given main-ctx;
}

sub bools(*@names) is export {
    @names.map: *.&bool;
}

sub solver is export {
    .mk-solver given main-ctx;
}

multi sub prefix:<not> (Expr:D $e) is export { $e.not; }
multi sub prefix:<!>   (Expr:D $e) is export { $e.not; }

sub or(*@exprs where .all ~~ Expr:D) {
    .or(|@exprs) given main-ctx;
}

multi sub infix:<OR> (Expr:D $lhs, Expr:D $rhs) is export {
    .or($lhs, $rhs) given main-ctx;
}
# multi sub infix:<||> (Expr:D $lhs, Expr:D $rhs) is export {
#     $lhs or $rhs
# }
