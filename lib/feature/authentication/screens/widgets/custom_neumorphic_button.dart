
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:idreamcare/constants/constants.dart';

class CustomLoginButton extends StatelessWidget {
  final IconData? siginIcon;
  final String? butonText;
  const CustomLoginButton({Key? key, this.siginIcon, this.butonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      style: NeumorphicStyle(
          depth: 3,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(15.0),
          ),
          intensity: 1,
          shadowDarkColor: Colors.black54.withOpacity(.4),
          color: AppColors.whiteColor),
      child: Container(
        width: 250,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(siginIcon),
            SizedBox(
              width: 10.0,
            ),
            Text(
              butonText!,
              style: TextStyle(
                color: AppColors.blackColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}