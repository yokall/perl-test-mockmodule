#!/usr/bin/perl

use strict;
use warnings;

use Test::MockModule;
use Test::More;

use_ok('TestMock::ModuleA');

subtest 'add without mock' => sub {
	my $number1 = 1;
	my $number2 = 1;

	my $result = TestMock::ModuleA::add($number1, $number2);

	is($result, 2, '1 + 1 = 2');
};

subtest 'add with mock' => sub {
	my $mock = Test::MockModule->new('TestMock::ModuleB')->redefine(add => sub { return 3; });

	my $number1 = 1;
	my $number2 = 1;

	my $result = TestMock::ModuleA::add($number1, $number2);

	is($result, 3, '1 + 1 = 3');
};

done_testing();
