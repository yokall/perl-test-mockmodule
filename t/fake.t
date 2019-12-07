#!/usr/bin/perl

use strict;
use warnings;

use Test::MockModule;
use Test::MockObject;
use Test::More;

my $mock_object = Test::MockObject->new();
$mock_object->fake_module(
	'TestMock::ModuleB',
	add => sub { return 3; }
);

use_ok('TestMock::ModuleA');

subtest 'add with mock object' => sub {
	my $number1 = 1;
	my $number2 = 1;

	my $result = TestMock::ModuleA::add($number1, $number2);

	is($result, 3, '1 + 1 = 3');

	my $mock = Test::MockModule->new('TestMock::ModuleB')->redefine(add => sub { return 30; });

	subtest 'add with mock' => sub {
		$result = TestMock::ModuleA::add($number1, $number2);

		is($result, 30, '1 + 1 = 30');
	};

	# falling back to original fake
	$mock->unmock('add');

	$result = TestMock::ModuleA::add($number1, $number2);

	is($result, 3, '1 + 1 = 3');
};

subtest 'add with redefined mock object' => sub {
	$mock_object->fake_module(
		'TestMock::ModuleB',
		add => sub { return 50; }
	);

	my $number1 = 1;
	my $number2 = 1;

	my $result = TestMock::ModuleA::add($number1, $number2);

	is($result, 50, '1 + 1 = 50');

	my $mock = Test::MockModule->new('TestMock::ModuleB')->redefine(add => sub { return 30; });

	subtest 'add with mock' => sub {
		$result = TestMock::ModuleA::add($number1, $number2);

		is($result, 30, '1 + 1 = 30');
	};

	# falling back to original fake
	$mock->unmock('add');

	$result = TestMock::ModuleA::add($number1, $number2);

	is($result, 50, '1 + 1 = 50');
};

subtest 'add with new mock object' => sub {
	my $new_mock_object = Test::MockObject->new();
	$new_mock_object->fake_module(
		'TestMock::ModuleB',
		add => sub { return 45; }
	);

	my $number1 = 1;
	my $number2 = 1;

	my $result = TestMock::ModuleA::add($number1, $number2);

	is($result, 45, '1 + 1 = 45');

	my $mock = Test::MockModule->new('TestMock::ModuleB')->redefine(add => sub { return 30; });

	subtest 'add with mock' => sub {
		$result = TestMock::ModuleA::add($number1, $number2);

		is($result, 30, '1 + 1 = 30');
	};

	# falling back to original fake
	$mock->unmock('add');

	$result = TestMock::ModuleA::add($number1, $number2);

	is($result, 45, '1 + 1 = 45');

	subtest 'add with mock object' => sub {
		my $number1 = 1;
		my $number2 = 1;

		my $result = TestMock::ModuleA::add($number1, $number2);

		is($result, 45, '1 + 1 = 45');

		my $mock = Test::MockModule->new('TestMock::ModuleB')->redefine(add => sub { return 30; });

		subtest 'add with mock' => sub {
			$result = TestMock::ModuleA::add($number1, $number2);

			is($result, 30, '1 + 1 = 30');
		};

		# falling back to original fake
		$mock->unmock('add');

		$result = TestMock::ModuleA::add($number1, $number2);

		is($result, 45, '1 + 1 = 45');
	};
};

done_testing();
