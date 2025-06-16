part of 'calculator_bloc.dart';

class CalculatorEvent {}

class GetFormulaA extends CalculatorEvent {
  final Completer? completer;
  final double h;
  final double l;

  GetFormulaA({
    required this.h,
    required this.l,
    this.completer,
  });
}

class GetFormulaN extends CalculatorEvent {
  final Completer? completer;
  final double d;
  final double m;
  final double s;

  GetFormulaN({
    required this.d,
    required this.m,
    required this.s,
    this.completer,
  });
}

class GetFormulaD extends CalculatorEvent {
  final Completer? completer;
  final double a;
  final double m;

  GetFormulaD({
    required this.a,
    required this.m,
    this.completer,
  });
}
