import 'package:idreamcare/constants/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNavBar extends StatefulWidget {
  CustomNavBar({this.onSelectScreen, this.currentIndex});
  Function(int)? onSelectScreen;
  int? currentIndex;
  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  List<IconData> bottomIcon = [
    Icons.home,
    Icons.search,
    Icons.insights,
    Icons.favorite,
    Icons.person
  ];
  List<String> bottomOption = ["Courses", "Home", "Profile"];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              widget.currentIndex = index;
              widget.onSelectScreen!(widget.currentIndex!);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              bottomIcon[index],
              color: widget.currentIndex == index
                  ? AppColors.darkBlueColor
                  : AppColors.textGreyColor,
              size: 40.0,
            ),
          ),
        ),
      ),
    );
  }
}
