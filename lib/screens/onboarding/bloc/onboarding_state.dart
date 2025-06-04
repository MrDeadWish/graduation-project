part of 'onboarding_bloc.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  OnboardingLoaded({
    required this.guides,
  });
  final List<Guide> guides;
}

class OnboardingLoadingFailure extends OnboardingState {
  OnboardingLoadingFailure({
    required this.exception,
  });
  final Object? exception;
}