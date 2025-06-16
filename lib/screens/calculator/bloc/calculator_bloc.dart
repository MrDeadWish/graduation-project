import 'dart:async';

import 'package:binevir/data/repository/calculator_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc(this.calculatorRepository) : super(CalculatorInitial()) {
    on<GetFormulaA>((event, emit) async {
      try {
        final double data =
            await calculatorRepository.getFormulaA(h: event.h, l: event.l);
        emit(CalculatorFormulaALoaded(data: data));
      } catch (e) {
        emit(CalculatorFormulaAFailure(exception: e));
      }
    });

    on<GetFormulaN>((event, emit) async {
      try {
        final double data = await calculatorRepository.getFormulaN(
            d: event.d, m: event.m, s: event.s);
        emit(CalculatorFormulaNLoaded(data: data));
      } catch (e) {
        emit(CalculatorFormulaNFailure(exception: e));
      }
    });

    on<GetFormulaD>((event, emit) async {
      try {
        final double data = await calculatorRepository.getFormulaD(
          a: event.a,
          m: event.m,
        );
        emit(CalculatorFormulaDLoaded(data: data));
      } catch (e) {
        emit(CalculatorFormulaDFailure(exception: e));
      }
    });
  }
  final CalculatorRepository calculatorRepository;
}
