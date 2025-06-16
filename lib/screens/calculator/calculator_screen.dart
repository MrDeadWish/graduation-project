import 'package:binevir/components/dropdown.dart';
import 'package:binevir/components/screen.dart';
import 'package:binevir/components/top_panel.dart';
import 'package:binevir/data/models/product.dart';
import 'package:binevir/data/repository/application_repository.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:binevir/screens/calculator/widgets/CalculatorSendButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';
import 'formulas/add.dart';
import 'formulas/subtract.dart';
import 'formulas/type_2.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  ApplicationRepository applicationRepository = getIt<ApplicationRepository>();
  Application? _selectedApplication;
  Widget _resultWidget = const SizedBox();
  final ScrollController _scrollController = ScrollController();

  void _onResultChanged(Widget resultWidget) {
    setState(() {
      _resultWidget = resultWidget;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildFormulaWidget() {
    if (_selectedApplication == null) return const SizedBox();

    switch (_selectedApplication?.calculation_type) {
      case 'type_1':
      // return AddFormula(onResultChanged: _onResultChanged);
      case 'type_2':
        return ShotcreteFormula(onResultChanged: _onResultChanged, isSI: isSI);
      default:
        return const SizedBox();
    }
  }

  final Box person = Hive.box('person_box');
  bool isSI = true;
  final _countryRepository = getIt<CountryRepository>();
  @override
  void initState() {
    super.initState();

    final appUser = person.get('AppUser');
    final measurementCode =
        _countryRepository.countries
            .firstWhereOrNull(
              (country) => country.code == appUser?.country_code,
            )
            ?.measurement
            .name;

    isSI = (measurementCode == 'International system of units (SI)');
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopPanel(),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.calculationTitle,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    height: 52,
                    color: Color.fromARGB(217, 177, 177, 177),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.chooseApplication),
                      const SizedBox(height: 10),

                      Expanded(
                        child: Dropdown(
                          hint: AppLocalizations.of(context)!.application,
                          value: _selectedApplication,
                          items:
                              applicationRepository.applications
                                  .map(
                                    (app) => DropdownMenuItem<Application>(
                                      value: app,
                                      child: Text(app.title),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (app) {
                            setState(() {
                              _selectedApplication = app;
                              _resultWidget = const SizedBox();
                            });
                          },
                          onSaved: (_) {},
                          validator: (_) => null,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _buildFormulaWidget(),
                  const SizedBox(height: 30),
                  const Text('Result:', style: TextStyle(fontSize: 24)),
                  _resultWidget,
                  Center(child: const CalculatorSendButton()),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
