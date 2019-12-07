# Faking and Mocking

![](https://github.com/yokall/perl-test-mockmodule/workflows/CI/badge.svg)

This is a series of t tests which show the usage of Test::MockModule and Test::MockObject.  Both modules behave in a similar way with the main difference being that MockObject mocks a whole module at a time whereas MockModule mocks a sub at a time.

In my experience I have found it best to use MockObject to fake a module and then use MockModule to override a sub when required for a different scenario.  It is not possible to mock a sub twice and then revert to the first mock.  unmock will always revert to the original code.  You also cant use scope to temporarily mock an object and then revert to a previous mock when it goes out of scope.

Doing this means you use MockObject to setup everything "happy path" and then use MockModule to excercise all paths through the code.