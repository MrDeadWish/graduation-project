part of 'splash_bloc.dart';

abstract class SplashEvent {}

class LoadData extends SplashEvent {
  final Completer? completer;

  LoadData({
    this.completer,
  });
}
