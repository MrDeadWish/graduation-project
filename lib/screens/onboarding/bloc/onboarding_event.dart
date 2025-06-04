part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {}

class OnboardingLoad extends OnboardingEvent{
  final Completer? completer;

  OnboardingLoad({
    this.completer,
  });
}