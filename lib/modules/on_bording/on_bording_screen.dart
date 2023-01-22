import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';
import '../../shared/styles/colors.dart';
import '../login/shop_login_screen.dart';

class BordingModel {
  final String image;
  final String title;
  final String body;

  BordingModel({required this.image, required this.title, required this.body});
}

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  List<BordingModel> bording = [
    BordingModel(image: 'assets/images/1.jpg', title: 'Explore ', body: 'Choose any product you want in the easiest way'),
    BordingModel(image: 'assets/images/2.jpg', title: 'Shipping', body: '.....'),
    BordingModel(image: 'assets/images/3.jpg', title: 'Payment', body: 'Pay With The easiest Way Possible'),
  ];

  var bordingController = PageController();
  bool isLast = false;

  void submit() {
    CashHelper.saveData(key: 'onBording', value: true).then((value) {
      navigateAndKill(context, ShopLoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [TextButton(onPressed: submit, child: const Text('SKIP'))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == bording.length - 1) {
                      setState(() {
                        log('last');
                        isLast = true;
                      });
                    } else {
                      log('not last');
                      isLast = false;
                    }
                  },
                  controller: bordingController,
                  itemBuilder: (contxt, index) =>
                      BuildBordingIteam(bording[index]),
                  itemCount: bording.length,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: bordingController,
                    count: bording.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      activeDotColor: defaultColor,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      isLast
                          ? submit()
                          : bordingController.nextPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.fastOutSlowIn);
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

Widget BuildBordingIteam(BordingModel bording) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(image: AssetImage(bording.image)),
        ),
        const SizedBox(height: 30),
        Text(
          bording.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          bording.body,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
