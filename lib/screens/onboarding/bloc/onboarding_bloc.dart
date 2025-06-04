
import 'dart:async';
import 'package:binevir/data/models/guide.dart';
import 'package:binevir/data/repository/guide_repository.dart';
import 'package:bloc/bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent,OnboardingState>   {
  OnboardingBloc(this.guideRepository):super(OnboardingInitial()){
        on<OnboardingLoad>((event, emit) async {
      try {
        if (state is! OnboardingLoaded) {
          emit(OnboardingLoading());
        }
        final guides = await guideRepository.getGuideRequested();
        emit(OnboardingLoaded(guides: guides));
      } catch (e) {
        emit(OnboardingLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
  final GuideRepository guideRepository;
}