import 'package:binevir/components/loading_failure.dart';
import 'package:binevir/components/platform_indicator.dart';
import 'package:binevir/components/primary_button.dart';
import 'package:binevir/data/models/guide.dart';
import 'package:binevir/data/repository/guide_repository.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:binevir/screens/onboarding/widgets/register.dart';
import 'package:binevir/screens/onboarding/widgets/slide.dart';
import 'package:flutter/material.dart';
import 'bloc/onboarding_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Future<List<Guide>> future;
  final PageController _pageController = PageController();
  final _onboardingBloc = OnboardingBloc(getIt<GuideRepository>());
  final countryRepository = getIt<CountryRepository>();
  int _currentPage = 0;
  Box? guideCache;
  @override
  void initState() {
    _onboardingBloc.add(OnboardingLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        bloc: _onboardingBloc,
        builder: (context, state) {
          if (state is OnboardingLoaded) {
            List<Guide> guides = state.guides;
            List<dynamic> pages = [];
            for (var guide in guides) {
              pages.add(
                Slide(
                  controller: _pageController,
                  image: guide.image,
                  title: guide.title,
                  description: guide.description,
                ),
              );
            }
            pages.add(RegisterSlide());

            return SafeArea(
              top: false,
              bottom: true,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) => pages[index],
                    ),
                  ),

                  Column(
                    children: [
                      if (_currentPage < pages.length - 1)
                        PrimaryButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Text(AppLocalizations.of(context)!.start),
                        ),
                      TextButton(
                        onPressed: () {
                          context.go('/home');
                        },
                        child: Text(AppLocalizations.of(context)!.skip),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      pages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                _currentPage == index
                                    ? const Color.fromRGBO(217, 217, 217, 1)
                                    : Colors.transparent,
                            child: CircleAvatar(
                              backgroundColor:
                                  _currentPage == index
                                      ? Colors.white
                                      : Colors.transparent,
                              radius: 6,
                              child: const CircleAvatar(
                                radius: 5,
                                backgroundColor: Color.fromRGBO(
                                  217,
                                  217,
                                  217,
                                  1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (state is OnboardingLoadingFailure) {
            return LoadingFailureWidget(
              onRetry: () {
                _onboardingBloc.add(OnboardingLoad());
              },
            );
          }

          return platformIndicator();
        },
      ),
    );
  }
}
