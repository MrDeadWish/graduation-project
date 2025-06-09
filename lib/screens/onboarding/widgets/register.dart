
import 'package:binevir/components/primary_button.dart';
import 'package:binevir/constants/image_constants.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:binevir/components/dropdown.dart';
import 'package:binevir/components/image_modal.dart';
import 'package:binevir/components/form_field.dart';
import 'package:binevir/components/show_modal.dart';
import '../../../data/models/country.dart';
import '../../../data/models/person.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterSlide extends StatefulWidget {
  const RegisterSlide({super.key});

  @override
  State<RegisterSlide> createState() => _RegisterSlideState();
}

class _RegisterSlideState extends State<RegisterSlide> {
  final picker = ImagePicker();

  late Box person;
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final surnameController = TextEditingController();
  final companyController = TextEditingController();
  final jobController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final countryRepository = getIt<CountryRepository>();
  String userPhoto = AppImages().userDefaultPhoto;
  Country? selectedCountry;

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
    firstNameController.text = '';
    secondNameController.text = '';
    surnameController.text = '';
    companyController.text = '';
    jobController.text = '';
    phoneController.text = '';
    emailController.text = '';
    
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 77,
                        backgroundColor: Colors.white,
                        backgroundImage: Image.asset(userPhoto).image,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(5),
                            clipBehavior: Clip.hardEdge,
                            type: MaterialType.transparency,
                            child: Ink(
                              height: 25.0,
                              child: InkWell(
                                onTap: () {
                                  showModal(
                                    context: context,
                                    child: ImageModal(
                                      onChanged: (value) {
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
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.photo,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        Icons.mode_edit_outline_outlined,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        InputField(
                          label: AppLocalizations.of(context)!.firstName,
                          field: TextFormField(
                            controller: firstNameController,
                            validator: (value) {
                              if (value == null || value == '') {
                                return AppLocalizations.of(context)!.requiredFirstName;
                              } else {
                                return null;
                              }
                            },
                          ),
                          required: true,
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        InputField(
                          label: AppLocalizations.of(context)!.middleName,
                          field: TextFormField(
                            controller: secondNameController,
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        InputField(
                          label: AppLocalizations.of(context)!.surname,
                          field: TextFormField(
                            controller: surnameController,
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        InputField(
                          label: AppLocalizations.of(context)!.country,
                          field: Dropdown(
                            hint: AppLocalizations.of(context)!.selectCountry,
                            items: countryRepository.countries
                                .map(
                                  (item) => DropdownMenuItem<Country>(
                                    value: item,
                                    child: Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {
                              selectedCountry = value as Country;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        InputField(
                          label: AppLocalizations.of(context)!.company,
                          field: TextFormField(
                            controller: companyController,
                          ),
                          required: true,
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        InputField(
                          label: AppLocalizations.of(context)!.jobTitle,
                          field: TextFormField(
                            controller: jobController,
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        InputField(
                          label: AppLocalizations.of(context)!.phone,
                          field: TextFormField(
                            controller: phoneController,
                            validator: (value) {
                              if (value.toString().isNotEmpty &&
                                  value.toString().length < 18) {
                                return AppLocalizations.of(context)!.errorPhone;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        InputField(
                          label: AppLocalizations.of(context)!.email,
                          field: TextFormField(
                            controller: emailController,
                          ),
                          required: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            child: PrimaryButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var newPerson = Person(
                    first_name: firstNameController.text,
                    second_name: secondNameController.text,
                    surname: surnameController.text,
                    country_code: selectedCountry?.code,
                    company: companyController.text,
                    job_title: jobController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    photo: userPhoto,
                  );
                  person.put('AppUser', newPerson);
                  context.go('/home');
                }
              },
              child: Text(
                AppLocalizations.of(context)!.continue_,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
