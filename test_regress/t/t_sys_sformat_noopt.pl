#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

scenarios(simulator => 1);

top_filename("t/t_sys_sformat.v");

compile(
    # Avoid inlining our simple example, to make sure verilated.h works right
    verilator_flags2 => ["-O0"],
    );

if ($Self->cxx_version =~ /clang version ([0-9]+\.[0-9]+)/
    && ($1 >= 3.8 && $1 <= 5.0)) {
    skip("Known clang bug");
    #Here:   if (VL_UNLIKELY(VL_NEQ_W(12, __Vtemp1, vlSymsp->TOP__t.__PVT__str)))
} else{
    execute(
        check_finished => 1,
        );
}

ok(1);
1;
