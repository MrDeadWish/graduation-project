import 'dart:async';
import 'package:binevir/constants/theme_icons.dart';
import 'package:binevir/data/repository/product_repository.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:binevir/screens/catalog/bloc/catalog_bloc.dart';
import 'package:binevir/screens/catalog/widgets/catalog_card.dart';
import 'package:binevir/components/screen.dart';
import 'package:binevir/components/loading_failure.dart';
import 'package:binevir/components/platform_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  Box? settings;
  bool isList = false;
  final _catalogBloc = CatalogBloc(getIt<ProductRepository>());
  final List<bool> isSelected = [true, false];

  @override
  void initState() {
    settings = Hive.box('settings_box');
    _catalogBloc.add(LoadCatalog());
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
    isList = settings?.get('isList', defaultValue: false);
    isSelected[0] = isList == true ? false : true;
    isSelected[1] = isList == true ? true : false;
    if (!isList) isSelected[0] = true;
    return Screen(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ToggleButtons(
                  isSelected: isSelected,
                  renderBorder: false,
                  color: const Color.fromRGBO(87, 86, 86, 1),
                  constraints: const BoxConstraints(
                    minWidth: 35,
                    minHeight: 35,
                  ),
                  onPressed: (int index) {
                    setState(() {
                      for (
                        int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++
                      ) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }

                      if (isSelected[0] == true) {
                        isList = false;
                        settings?.put('isList', false);
                      }
                      if (isSelected[1] == true) {
                        isList = true;
                        settings?.put('isList', true);
                      }
                    });
                  },
                  children: const <Widget>[
                    Icon(AppIcons.grid, size: 18),
                    Icon(AppIcons.list, size: 18),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final completer = Completer();
                _catalogBloc.add(LoadCatalog(completer: completer));
                return completer.future;
              },
              child: BlocBuilder<CatalogBloc, CatalogState>(
                bloc: _catalogBloc,
                builder: (context, state) {
                  if (state is CatalogLoaded) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(state.products[index].image);
                        return InkWell(
                          onTap: () {
                            //print(state.products[index].id);
                            GoRouter.of(
                              context,
                            ).push('/catalog/${state.products[index].id}');
                          },
                          child: CatalogCard(
                            title: state.products[index].title,
                            list: isList,
                            image: state.products[index].image!,
                          ),
                        );
                      },
                    );
                  } else if (state is CatalogLoadingFailure) {
                    return LoadingFailureWidget(
                      onRetry: () {
                        _catalogBloc.add(LoadCatalog());
                      },
                    );
                  }
                  return platformIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
