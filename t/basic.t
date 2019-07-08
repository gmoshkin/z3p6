use v6;

use Test;
use Z3;

use Z3::Core;
use Z3::Constants;

isa-ok z3-get-version, Version;
isa-ok z3-global-param-reset-all, Mu;

isa-ok my $conf = Z3-Config.new(), Z3-Config;
isa-ok $conf.mk-context(), Z3-Context;

{
    isa-ok my $slv = solver(), Solver;
    isa-ok my $var = bool(12), Expr;
    $slv.assert($var);
    isa-ok my $res = $slv.check(), Z3-lbool;
    is $res, Z3-L-TRUE;
    isa-ok my $not-var = !$var, Expr;
    $slv.assert($not-var);
    is $slv.check(), Z3-L-FALSE;
}

{
    isa-ok my $slv = solver(), Solver;
    isa-ok $_, Expr for my ($a, $b) = bools('a', 42);
    isa-ok my $or = ($a OR $b), Expr;
    isnt $or, $a;
    isnt $or, $b;
    $slv.assert($or);
    is my $res = $slv.check(), Z3-L-TRUE;
}

{
    isa-ok my $slv = solver(), Solver;
    isa-ok $_, Expr for my ($tie, $shirt) = bools(<ties shirt>);
    isa-ok my $or1 = $tie OR $shirt, Expr;
    isa-ok my $or2 = !$tie OR $shirt, Expr;
    isa-ok my $or3 = (not $tie) OR not $shirt, Expr;
    $slv.assert($or1, $or2, $or3);
    isa-ok my $res = $slv.check(), Z3-lbool;
    is $res, Z3-L-TRUE;
}

is Z3-lbool::Z3-L-FALSE.Int, -1;
isa-ok Z3-OP-IFF, Z3-decl-kind;

done-testing;
