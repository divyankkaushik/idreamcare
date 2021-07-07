import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieFiles extends StatelessWidget {
  const LottieFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
       alignment: Alignment.center,
       child: Container(
           height: 40.0,
           child: Lottie.asset("assets/lottie/lottie.json")),
     );
  }
}