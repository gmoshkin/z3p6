use v6;

use Test;
use Z3;

isa-ok z3-get-version, Version;

use Z3::Constants;

is Z3-lbool::Z3-L-FALSE.Int, -1;
isa-ok Z3-OP-IFF, Z3-decl-kind;

done-testing;
