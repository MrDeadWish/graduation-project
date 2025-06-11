part of 'splash_bloc.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class DataLoaded extends SplashState {
  DataLoaded({
    required this.countries,
    required this.applications,
    required this.settings,
  });
  final List<Country> countries;
  final List<Application> applications;
  final Settings settings;
}

class DataLoading extends SplashState {}

class DataLoadingFailure extends SplashState {
  DataLoadingFailure({
    required this.exception,
  });
  final Object? exception;
}
