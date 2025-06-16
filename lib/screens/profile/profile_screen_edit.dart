import 'package:binevir/components/form_field.dart';
import 'package:binevir/components/primary_button.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/dropdown.dart';
import '../../components/image_modal.dart';
import '../../components/show_modal.dart';
import '../../components/screen.dart';
import '../../constants/image_constants.dart';
import '../../data/models/country.dart';
import '../../data/models/person.dart';
import 'package:binevir/binevir_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreenEdit extends StatefulWidget {
  const ProfileScreenEdit({super.key});

  @override
  State<ProfileScreenEdit> createState() => _ProfileScreenEditState();
}

class _ProfileScreenEditState extends State<ProfileScreenEdit> {
  final picker = ImagePicker();
  late Box person;
  late dynamic appUser;

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _companyController = TextEditingController();
  final _jobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryRepository = getIt<CountryRepository>();

  String userPhoto = '';
  String countryCode = '';

  @override
  void initState() {
    person = Hive.box('person_box');
    appUser = person.get('AppUser') as Person?;

    if (appUser != null) {
      _firstNameController.text = appUser.first_name;
      _middleNameController.text = appUser.middle_name;
      _surnameController.text = appUser.surname;
      _companyController.text = appUser.company;
      _jobController.text = appUser.job_title;
      _phoneController.text = appUser.phone;
      _emailController.text = appUser.email;
      userPhoto = appUser.photo;
      countryCode = appUser.country_code ?? '';
    }

    if (userPhoto == '') AppImages().userDefaultPhoto;

    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _surnameController.dispose();
    _companyController.dispose();
    _jobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.findAncestorStateOfType<BinevirAppState>();
    return Screen(
      userEdit: true,
      userPhoto: userPhoto,
      userOnTap: () {
        showModal(
          context: context,
          child: ImageModal(
            onChanged: (value) async {
              if (value != '') {
                setState(() {
                  userPhoto = value;
                });

                Navigator.of(context).pop();
              }
            },
          ),
        );
      },
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  right: 25.0,
                  top: 15.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        runSpacing: 15.0,
                        children: [
                          InputField(
                            label: AppLocalizations.of(context)!.firstName,
                            labelWidth: 110,
                            field: TextFormField(
                              controller: _firstNameController,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return AppLocalizations.of(
                                    context,
                                  )!.requiredFirstName;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            required: true,
                          ),
                          InputField(
                            label: AppLocalizations.of(context)!.middleName,
                            labelWidth: 110,
                            field: TextFormField(
                              controller: _middleNameController,
                            ),
                          ),
                          InputField(
                            label: AppLocalizations.of(context)!.surname,
                            labelWidth: 110,
                            field: TextFormField(
                              controller: _surnameController,
                            ),
                          ),
                          InputField(
                            label: AppLocalizations.of(context)!.country,
                            labelWidth: 110,
                            field: Dropdown(
                              hint: AppLocalizations.of(context)!.selectCountry,
                              value: getCountry(
                                _countryRepository.countries,
                                countryCode,
                              ),
                              items:
                                  _countryRepository.countries
                                      .map(
                                        (item) => DropdownMenuItem<Country>(
                                          value: item,
                                          child: Text(
                                            item.title,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              validator: (value) {
                                return null;
                              },
                              onChanged: (value) {
                                final country = value as Country;
                                setState(() {
                                  countryCode = country.code;
                                });
                              },
                              onSaved: (value) {},
                            ),
                          ),
                          InputField(
                            label: AppLocalizations.of(context)!.company,
                            labelWidth: 110,
                            field: TextFormField(
                              controller: _companyController,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return AppLocalizations.of(
                                    context,
                                  )!.requiredCompany;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            required: true,
                          ),
                          InputField(
                            label: AppLocalizations.of(context)!.jobTitle,
                            labelWidth: 110,
                            field: TextFormField(controller: _jobController),
                          ),
                          InputField(
                            label: AppLocalizations.of(context)!.phone,
                            labelWidth: 110,
                            field: TextFormField(controller: _phoneController),
                          ),
                          InputField(
                            label: AppLocalizations.of(context)!.email,
                            labelWidth: 110,
                            field: TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return 'Email is required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            required: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 27),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrimaryButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                var newPerson = Person(
                                  first_name: _firstNameController.text,
                                  middle_name: _middleNameController.text,
                                  surname: _surnameController.text,
                                  country_code: countryCode,
                                  company: _companyController.text,
                                  job_title: _jobController.text,
                                  phone: _phoneController.text,
                                  email: _emailController.text,
                                  photo: userPhoto,
                                );
                                person.put('AppUser', newPerson);
                                GoRouter.of(context).go('/profile');
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.save.toUpperCase(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.appSettings,
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 15),

                InputField(
                  label: AppLocalizations.of(context)!.language,
                  labelWidth: 110,
                  field: DropdownButton<Locale>(
                    value: Localizations.localeOf(context),
                    items: const [
                      DropdownMenuItem(
                        value: Locale('en'),
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: Locale('ru'),
                        child: Text('Русский'),
                      ),
                    ],
                    onChanged: (locale) {
                      if (locale != null) {
                        appState?.setLocale(locale);
                      }
                    },
                  ),
                ),

                InputField(
                  label: AppLocalizations.of(context)!.theme,
                  labelWidth: 110,
                  field: DropdownButton<ThemeMode>(
                    value:
                        Theme.of(context).brightness == Brightness.dark
                            ? ThemeMode.dark
                            : ThemeMode.light,
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(AppLocalizations.of(context)!.light),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(AppLocalizations.of(context)!.dark),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text(AppLocalizations.of(context)!.system),
                      ),
                    ],
                    onChanged: (themeMode) {
                      if (themeMode != null) {
                        appState?.setTheme(themeMode);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
