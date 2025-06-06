import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingFailureWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final Color? textColor;

  const LoadingFailureWidget({
     super.key,
    required this.onRetry,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = textColor ?? Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
    final currentPath = GoRouterState.of(context).uri.toString();
    final isNotHome = currentPath != '/' && currentPath != '/home';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.loading_failure,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: color),
          ),
          const SizedBox(height: 5),
          Text(
            AppLocalizations.of(context)!.please_try_again_later,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context)!.try_again),
          ),
          if (isNotHome) ...[
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => context.go('/home'),
              child: Text(AppLocalizations.of(context)!.go_to_main),
            ),
            ],
        ],
      ),
    );
  }
}
