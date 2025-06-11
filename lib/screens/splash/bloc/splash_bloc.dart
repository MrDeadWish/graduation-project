import 'dart:async';

import 'package:binevir/data/models/country.dart';
import 'package:binevir/data/models/product.dart';
import 'package:binevir/data/models/settings.dart';
import 'package:binevir/data/repository/application_repository.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/data/repository/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this.countryRepository, this.applicationRepository,
      this.settingsRepository)
      : super(SplashInitial()) {
    on<LoadData>((event, emit) async {
      try {
        if (state is! DataLoaded) {
          emit(DataLoading());
        }
        final countries = await countryRepository.getCountriesRequested();
        final applications =
            await applicationRepository.getApplicationsRequested();
        final settings = await settingsRepository.getSettingsRequested();
        emit(DataLoaded(
          countries: countries,
          settings: settings,
          applications: applications,
        ));
      } catch (e) {
        emit(DataLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
  final CountryRepository countryRepository;
  final ApplicationRepository applicationRepository;
  final SettingsRepository settingsRepository;
}
