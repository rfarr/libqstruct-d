#!/usr/bin/env perl

use strict;

system("cd lib/libqstruct && make clean && make") and die;
system("cc -I lib/libqstruct/ -o glue.o -c glue.c") and die;
#system("cc -I lib/libqstruct/ -o main_c main_c.c lib/libqstruct/libqstruct.a") and die;
system("dmd -gc -ofmain_d main_d.d glue.o lib/libqstruct/libqstruct.a") and die;
