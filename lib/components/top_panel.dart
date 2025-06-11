import 'package:binevir/components/show_modal.dart';
import 'package:binevir/data/models/sheet_size.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/data/repository/data_repository.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';
import 'custom_checkbox.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({
    super.key,
  });

  @override
  State<TopPanel> createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  Box? person;
  final _countryRepository = getIt<CountryRepository>();
  final _dataRepository = getIt<DataRepository>();

  String sheetSize = '-';

  @override
  void initState() {
    person = Hive.box('person_box');
    sheetSize = _dataRepository.selectedSheetSize?.name ?? '-';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = person?.get('AppUser');

    return RepositoryProvider(
      create: (context) => DataRepository(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.country,
                style: const TextStyle(
                  fontSize: 10,
                  height: 1.2,
                  color: Color.fromRGBO(83, 83, 83, 1),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                _countryRepository.countries
                        .firstWhereOrNull(
                            (country) => country.code == appUser?.country_code)
                        ?.title ??
                    '-',
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.measurmentSystem,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(83, 83, 83, 1),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      _countryRepository.countries
                              .firstWhereOrNull((country) =>
                                  country.code == appUser?.country_code)
                              ?.measurement
                              .name ??
                          '-',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(22, 22, 22, 1)),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  SvgPicture.asset(
                    width: 12.0,
                    height: 8.0,
                    fit: BoxFit.contain,
                    color: Colors.red,
                    'assets/icons/arrow_right.svg',
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              StatefulBuilder(builder: (context, setState) {
                return GestureDetector(
                  onTap: () {
                    showModal(
                      context: context,
                      header: const Column(
                        children: [
                          Text('Sheet sizes'),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _dataRepository.sheetSizes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom:
                                  index != _dataRepository.sheetSizes.length - 1
                                      ? 10
                                      : 0,
                            ),
                            child: CustomCheckbox<String>(
                              value: _dataRepository.sheetSizes[index].name,
                              groupValue: sheetSize,
                              title: _dataRepository.sheetSizes[index].name,
                              onChanged: (value) {
                                setState(
                                  () {
                                    sheetSize = value;
                                    _dataRepository.selectedSheetSize =
                                        _dataRepository.sheetSizes[index];
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Sheet size(' + sheetSize + ')',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(83, 83, 83, 1),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
