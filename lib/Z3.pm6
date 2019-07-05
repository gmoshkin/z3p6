use v6;

use NativeCall;

unit module Z3;
need Z3::Constants;

constant LIB = 'z3';

sub Z3_get_version(uint32 $major is rw,
                   uint32 $minor is rw,
                   uint32 $build is rw,
                   uint32 $rev is rw)
    is native(LIB) {...}

sub z3-get-version() is export {
    Z3_get_version(my uint32 $major, my uint32 $minor, my uint32 $build, my uint32 $rev);
    Version.new: "$major.$minor.$build.$rev";
}
