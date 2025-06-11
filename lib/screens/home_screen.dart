import 'package:binevir/components/primary_button.dart';
import 'package:binevir/components/Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../components/input_number.dart';
import '../components/top_panel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextInputFormatter metrFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\,?\d{0,2}'));

  TextEditingController mainLengthController = TextEditingController();
  TextEditingController openingSizeController = TextEditingController();
  TextEditingController barDiameterController = TextEditingController();
  TextEditingController clearSpainController = TextEditingController();
  TextEditingController distanceBetweenController = TextEditingController();
  TextEditingController reinforcementAreaController = TextEditingController();
  TextEditingController strengthClassOfConcreteController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    reinforcementAreaController.text = '100 m';
    clearSpainController.text = '20 m';
    strengthClassOfConcreteController.text = '300';

    return
    Screen(body: 
     SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 15.0,
              ),
              child: Column(
                children: [
                  const TopPanel(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        onPressed: () {
                          GoRouter.of(context).go('/calculator');
                        },
                        child: Text(
                          AppLocalizations.of(context)!.newCalculate.toUpperCase(),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 34,
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 3,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 60,
                          thickness: 1,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Construction',
                              style: TextStyle(
                                fontSize: 10.0,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              'Adana Foundation',
                              style: TextStyle(
                                fontSize: 18.0,
                                height: 1.2,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(22, 22, 22, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 28.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: NumberInput(
                                    label: AppLocalizations.of(context)!.reinforcementArea,
                                    placeholder: '0,0 m',
                                    inputFontSize: 20.0,
                                    inputFormatters: [metrFormatter],
                                    suffix: 'm',
                                    controller: reinforcementAreaController,
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: NumberInput(
                                    label: AppLocalizations.of(context)!.clearSpain,
                                    placeholder: '0,0 m',
                                    inputFontSize: 20.0,
                                    suffix: 'm',
                                    inputFormatters: [metrFormatter],
                                    controller: clearSpainController,
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: NumberInput(
                                    label:
                                        AppLocalizations.of(context)!.strengthClassOfConcrete,
                                    placeholder: '0',
                                    controller:
                                        strengthClassOfConcreteController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    inputFontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 21,
                            ),
                            const Text(
                              'Composite mesh',
                              style: TextStyle(
                                fontSize: 14.0,
                                height: 1.2,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 145.0,
                                  height: 145.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.asset(
                                              'assets/images/main_product.png')
                                          .image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Flexible(
                                  child: Text(
                                    'Common mesh area: 450 m², Diameter 22 mm BFRP mesh with a spacing of 100×100 in 4 layers, 8 mm, lap slice',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      height: 2,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}
