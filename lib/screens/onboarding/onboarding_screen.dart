import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final pages = [
    Placeholder(),
    Text("bruh"),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: SizedBox.expand(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index){
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) => pages[index],
          ),
        )
      ],
    ),
  ),
);
  }
}