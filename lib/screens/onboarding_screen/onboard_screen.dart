import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/login_screens.dart';
import 'onboarding_page.dart';

class OnboardingScreenState extends StatefulWidget {
  const OnboardingScreenState({super.key});

  @override
  State<OnboardingScreenState> createState() => _OnboardingScreenStateState();
}

class _OnboardingScreenStateState extends State<OnboardingScreenState> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updatedUI);
  }

  @override
  void dispose() {
    _controller.removeListener(_updatedUI);
    _controller.dispose();
    super.dispose();
  }

  void _updatedUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: 4, // Assuming 4 onboarding pages
              itemBuilder: (_, index) {
                return OnboardingPage(
                  image: 'assets/images/img_${index + 1}.svg',
                  headline: 'Loren Ipsum Sit Amet',
                  description:
                      'Lorem ipsum dolor sit amet, consectetur elit sit amet',
                  controller: _controller,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Skip'),
                ),
                CupertinoButton.filled(
                  onPressed: () {
                    if (_controller.hasClients) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        int currentPage = _controller.page!.toInt();
                        if (currentPage == 3) {
                          // Last page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        }
                      });
                    }
                  },
                  child: Builder(builder: (context) {
                    // Ensure controller is ready before evaluating the button text
                    return Text(_controller.hasClients &&
                            _controller.page != null &&
                            _controller.page!.toInt() == 3
                        ? 'Finish'
                        : 'Next');
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
