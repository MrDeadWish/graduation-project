import 'dart:async';
import 'package:binevir/components/loading_failure.dart';
import 'package:binevir/data/repository/application_repository.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/data/repository/settings_repository.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:binevir/screens/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Box personBox = Hive.box('person_box');

  bool settingsLoaded = false;
  bool applicationsLoaded = false;
  bool countriesLoaded = false;

  final _splashBlock = SplashBloc(
    getIt<CountryRepository>(),
    getIt<ApplicationRepository>(),
    getIt<SettingsRepository>());

  @override
  void initState() {
    _splashBlock.add(LoadData());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: BlocConsumer<SplashBloc, SplashState>(
          bloc: _splashBlock,
          listener: (context, state) {
            if (state is DataLoaded) {
              final appUser = personBox.get('AppUser');
              Timer(const Duration(seconds: 1), () async {
                // if (appUser == null) {
                //   context.go('/welcome');
                // } else {
                //   context.go('/');
                // }
                context.go('/welcome');
              });
            }
          },
          builder: (context, state) {
            if (state is DataLoadingFailure) {
              return LoadingFailureWidget(
                onRetry:(){
                   _splashBlock.add(LoadData());
                   }
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  AppLocalizations.of(context)!.splashTitle.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  AppLocalizations.of(context)!.splashDescription.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image:
                                Image.asset('assets/images/splash.png').image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 169.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
