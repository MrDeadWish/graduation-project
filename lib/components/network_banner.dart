import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworkBanner extends StatefulWidget {
  const NetworkBanner({super.key});

  @override
  State<NetworkBanner> createState() => _NetworkBannerState();
}

class _NetworkBannerState extends State<NetworkBanner> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();

    _checkConnection();

    InternetConnectionChecker.instance.onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;
      if (mounted) {
        setState(() {
          isConnected = connected;
        });
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
            Icon(Icons.wifi_off, color: Colors.white, size: 16),
            SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.noConnection,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    )
    );
  }
}
