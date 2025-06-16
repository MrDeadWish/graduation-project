import 'package:binevir/components/show_modal.dart';
import 'package:binevir/components/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/Material.dart';

class CalculatorSendButton extends StatelessWidget {
  const CalculatorSendButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        showModal(
          context: context,
          header: Text(
            'Отправка почты',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.black,
                ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Text(AppLocalizations.of(context)!.email),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.email,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(AppLocalizations.of(context)!.firstName),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.firstName,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Align(
                child: PrimaryButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)!.sendToEmail.toUpperCase()),
                ),
              )
            ],
          ),
        );
      },
      child: Text(
        AppLocalizations.of(context)!.sendToEmail.toUpperCase(),
      ),
    );
  }
}
