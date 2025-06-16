part of 'calculator_bloc.dart';

class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorFormulaALoaded extends CalculatorState {
  CalculatorFormulaALoaded({
    required this.data,
  });
  final dynamic data;
}

class CalculatorFormulaAFailure extends CalculatorState {
  CalculatorFormulaAFailure({
    required this.exception,
  });
  final Object? exception;
}

class CalculatorFormulaNLoaded extends CalculatorState {
  CalculatorFormulaNLoaded({
    required this.data,
  });
  final dynamic data;
}

class CalculatorFormulaNFailure extends CalculatorState {
  CalculatorFormulaNFailure({
    required this.exception,
  });
  final Object? exception;
}

class CalculatorFormulaDLoaded extends CalculatorState {
  CalculatorFormulaDLoaded({
    required this.data,
  });
  final dynamic data;
}

class CalculatorFormulaDFailure extends CalculatorState {
  CalculatorFormulaDFailure({
    required this.exception,
  });
  final Object? exception;
}
