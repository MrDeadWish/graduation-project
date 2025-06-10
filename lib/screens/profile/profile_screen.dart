import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:collection/collection.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/data/repository/settings_repository.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:binevir/components/form_field.dart';
import 'package:binevir/components/screen.dart';
import 'package:binevir/components/primary_button.dart';
import 'package:go_router/go_router.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Box person;
  final settingsRepository = getIt<SettingsRepository>();
  final _countryRepository = getIt<CountryRepository>();

  @override
  void initState() {
    person = Hive.box('person_box');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = person.get('AppUser');
    return Screen(
      userEdit: true,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
            child: Wrap(
              runSpacing: 15.0,
              children: [
                InputField(
                  label: AppLocalizations.of(context)!.country,
                  labelWidth: 90,
                  labelMargin: EdgeInsets.zero,
                  field: Text(
                    _countryRepository.countries
                            .firstWhereOrNull((country) =>
                                country.code == appUser?.country_code)
                            ?.title ??
                        '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                InputField(
                  label: AppLocalizations.of(context)!.company,
                  labelWidth: 90,
                  labelMargin: EdgeInsets.zero,
                  field: Text(
                    appUser != null ? appUser.company : '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                InputField(
                  label: AppLocalizations.of(context)!.jobTitle,
                  labelWidth: 90,
                  labelMargin: EdgeInsets.zero,
                  field: Text(
                    appUser != null ? appUser.job_title! : '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                InputField(
                  label: AppLocalizations.of(context)!.phone,
                  labelWidth: 90,
                  labelMargin: EdgeInsets.zero,
                  field: Text(
                    appUser != null ? appUser.phone! : '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                InputField(
                  label: AppLocalizations.of(context)!.email,
                  labelWidth: 90,
                  labelMargin: EdgeInsets.zero,
                  field: Text(
                    appUser != null ? appUser.email : '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(217, 177, 177, 177),
                ),
                Text(
                  AppLocalizations.of(context)!.managerContacts,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  runSpacing: 10.0,
                  children: [
                    InputField(
                      label: AppLocalizations.of(context)!.firstName,
                      labelWidth: 90,
                      labelMargin: EdgeInsets.zero,
                      field: Text(
                        settingsRepository.settings.managerName,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    InputField(
                      label: AppLocalizations.of(context)!.phone,
                      labelWidth: 90,
                      labelMargin: EdgeInsets.zero,
                      field: Text(
                        settingsRepository.settings.managerPhone,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    InputField(
                      label: AppLocalizations.of(context)!.email,
                      labelWidth: 90,
                      labelMargin: EdgeInsets.zero,
                      field: Text(
                        settingsRepository.settings.managerEmail,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
