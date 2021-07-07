import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:idreamcare/constants/constants.dart';
import 'package:idreamcare/feature/authentication/screens/widgets/custom_neumorphic_button.dart';

class MoreLoginOption extends StatelessWidget {
  const MoreLoginOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Container(
                    height: 250.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 2.0,
                          width: 40.0,
                          color: AppColors.textGreyColor,
                        ),
                        Spacer(),
                        CustomLoginButton(
                          siginIcon: Icons.facebook,
                          butonText: "Continue with Facebook",
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomLoginButton(
                          siginIcon: Icons.ac_unit,
                          butonText: "Continue with Google",
                        ),
                        Spacer(),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'By Selecting one or the other, you are agreeing to the',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Terms of services',
                                  style: TextStyle(
                                      color: AppColors.primaryBlueColor,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(text: ' & '),
                              TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                      color: AppColors.primaryBlueColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("More login opotions"),
          Align(
            child: Transform.rotate(
              angle: 90 * math.pi / 180,
              child: Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
