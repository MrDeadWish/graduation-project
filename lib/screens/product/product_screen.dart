import 'dart:async';

import 'package:binevir/components/application_card.dart';
import 'package:binevir/components/custom_checkbox.dart';
import 'package:binevir/components/input_number.dart';
import 'package:binevir/components/loading_failure.dart';
import 'package:binevir/components/platform_indicator.dart';
import 'package:binevir/data/repository/product_repository.dart';
import 'package:binevir/screens/product/bloc/product_bloc.dart';
import 'package:binevir/screens/product/widgets/product_project_item.dart';
import 'package:binevir/components/screen.dart';
import 'package:binevir/data/models/product.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widgets/product_applications.dart';
import 'widgets/product_calc_button.dart';
import 'widgets/product_description.dart';
import 'widgets/product_model.dart';
import 'widgets/product_projects.dart';
import 'widgets/product_title.dart';

class ProductScreen extends StatefulWidget {
  final int id;

  const ProductScreen({super.key, required this.id});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  final _productBlock = ProductBloc(getIt<ProductRepository>());
  String type = '';
  String openingSize = '50x50 mm';
  String barDiameter = '4 mm';
  TextEditingController openingSizeController = TextEditingController();
  TextEditingController barDiameterController = TextEditingController();
  TextInputFormatter metrFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^(\d+)?\,?\d{0,2}'),
  );

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    openingSizeController.dispose();
    barDiameterController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _productBlock.add(ProductLoad(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: RefreshIndicator(
        onRefresh: () {
          final completer = Completer();
          _productBlock.add(ProductLoad(completer: completer, id: widget.id));
          return completer.future;
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          bloc: _productBlock,
          builder: (context, state) {
            if (state is ProductLoaded) {
              final product = state.product;
              type = product.type;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductTitle(title: product.title),
                          ProductModel(
                            src: product.model!,
                            margin: const EdgeInsets.only(bottom: 10.0),
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                crossAxisAlignment: WrapCrossAlignment.end,
                                children: [
                                  SizedBox(
                                    width: constraints.maxWidth / 2 - 10,
                                    child: NumberInput(
                                      isModal: true,
                                      modalHeader: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.spacing,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      ),
                                      modalBody: StatefulBuilder(
                                        builder: (context, setState) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 0,
                                            itemBuilder: (
                                              BuildContext context,
                                              int index,
                                            ) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 0,
                                                ),
                                                child: CustomCheckbox<String>(
                                                  value: '',
                                                  groupValue: openingSize,
                                                  title: '',
                                                  onChanged: (value) {
                                                    setState(() {
                                                      openingSize = value;
                                                      openingSizeController
                                                          .text = value;
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    });
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      label:
                                          AppLocalizations.of(context)!.spacing,
                                      controller: openingSizeController,
                                      placeholder: '0,0 mm',
                                      suffix: 'm',
                                      inputFormatters: [metrFormatter],
                                      inputFontSize: 20.0,
                                      inputHeight: 1.2,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth / 2 - 10,
                                    child: NumberInput(
                                      isModal: true,
                                      modalHeader: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.barDiameter,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      ),
                                      modalBody: StatefulBuilder(
                                        builder: (context, setState) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 0,
                                            itemBuilder: (
                                              BuildContext context,
                                              int index,
                                            ) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 0,
                                                ),
                                                child: CustomCheckbox<String>(
                                                  value: '',
                                                  groupValue: barDiameter,
                                                  title: '',
                                                  onChanged: (value) {
                                                    setState(() {
                                                      barDiameter = value;
                                                      barDiameterController
                                                          .text = value;
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    });
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      label:
                                          AppLocalizations.of(
                                            context,
                                          )!.barDiameter,
                                      controller: barDiameterController,
                                      placeholder: '0,0 mm',
                                      suffix: 'm',
                                      inputFormatters: [metrFormatter],
                                      inputFontSize: 20.0,
                                      inputHeight: 1.2,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              CustomCheckbox<String>(
                                value: 'sheet',
                                groupValue: type,
                                title: AppLocalizations.of(context)!.sheet,
                                onChanged: (value) {
                                  setState(() {
                                    type = value;
                                  });
                                },
                              ),
                              const SizedBox(width: 20.0),
                              CustomCheckbox<String>(
                                value: 'roll',
                                groupValue: type,
                                title: AppLocalizations.of(context)!.roll,
                                onChanged: (value) {
                                  setState(() {
                                    type = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.sandCoating +
                                    ': ',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                AppLocalizations.of(context)!.yes,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge!.copyWith(
                                  color:
                                      (product as Product).sandCoating == 1
                                          ? Colors.black
                                          : Colors.black26,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                ' / ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.no,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge!.copyWith(
                                  color:
                                      (product as Product).sandCoating == 0
                                          ? Colors.black
                                          : Colors.black26,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          if (product.description != null &&
                              product.description!.isNotEmpty)
                            ProductDescription(text: product.description!),
                          if (product.applications != null &&
                              product.applications!.isNotEmpty)
                            ProductApplications(
                              margin: const EdgeInsets.only(bottom: 15),
                              slides:
                                  product.applications!
                                      .map(
                                        (slide) => ApplicationCard(
                                          title: slide.title,
                                          icon: slide.icon,
                                        ),
                                      )
                                      .toList(),
                            ),
                        ],
                      ),
                    ),
                    if (product.project_model != null &&
                        product.project_model!.isNotEmpty)
                      ProductModel(
                        src: product.project_model!,
                        isGradient: true,
                        margin: const EdgeInsets.only(bottom: 20.0),
                      ),
                    const ProductCalcButton(
                      margin: EdgeInsets.only(bottom: 20.0),
                    ),
                    if (product.projects != null &&
                        product.projects!.isNotEmpty)
                      ProductProjects(
                        slides:
                            product.projects!.map((project) {
                              return ProductProjectItem(image: project.image);
                            }).toList(),
                      ),
                  ],
                ),
              );
            } else if (state is ProductLoadingFailure) {
              return LoadingFailureWidget(
                onRetry: () {
                  final completer = Completer();
                  _productBlock.add(ProductLoad(completer: completer, id: widget.id));
                },
              );
            }
            return platformIndicator();
          },
        ),
      ),
    );
  }
}
