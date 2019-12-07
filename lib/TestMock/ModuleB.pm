package TestMock::ModuleB;

sub add {
	my $number1 = shift;
	my $number2 = shift;

	my $result = $number1 + $number2;

	return $result;
}

1;
