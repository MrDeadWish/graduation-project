import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:binevir/data/repository/application_repository.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/data/repository/settings_repository.dart';
import 'package:binevir/di/service_locator.dart';

class NetworkBanner extends StatefulWidget {
  const NetworkBanner({super.key});

  @override
  State<NetworkBanner> createState() => _NetworkBannerState();
}

class _NetworkBannerState extends State<NetworkBanner> {
  bool isConnected = true;
  bool hasRetried = false; 
  

  @override
  void initState() {
    super.initState();

    _checkConnection();

    InternetConnectionChecker.instance.onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;

      if (mounted) {
        setState(() {
          isConnected = connected;
          debugPrint('Подключено');
        });
      }

      if (connected && !hasRetried) {
        hasRetried = true;
        _retryDataLoad();
        debugPrint('перезапуск');

      }

      if (!connected) {
        hasRetried = false; 
        debugPrint('Отключено');
      }
    });
  }

  Future<void> _checkConnection() async {
    final connected = await InternetConnectionChecker.instance.hasConnection;
    if (mounted) {
      setState(() {
        isConnected = connected;
      });
    }
  }

void _retryDataLoad() async {
  final countryRepository = getIt<CountryRepository>();
  final applicationRepository = getIt<ApplicationRepository>();
  final settingsRepository = getIt<SettingsRepository>();

  try {
    await countryRepository.getCountriesRequested();
    await applicationRepository.getApplicationsRequested();
    await settingsRepository.getSettingsRequested();
  } catch (e) {
    debugPrint("Retry failed: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    if (isConnected) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      ignoring: true,
      child: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          color: Colors.grey[800]!.withOpacity(0.6),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.noConnection,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
