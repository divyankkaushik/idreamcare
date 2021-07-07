import 'package:flutter/material.dart';
import 'package:idreamcare/constants/constants.dart';
import 'package:idreamcare/feature/widgets/custom_drawer.dart';
import 'package:idreamcare/feature/widgets/custom_navbar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int screenNumber = 0;
  int selectSlide = 0;
  int currentIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: CustomDrawer(
        index: currentIndex,
        onListChildPressed: (value) {
          setState(() {
            screenNumber = value;
            currentIndex = value;
          });
        },
      ),
      body: Stack(
        children: [
          screenNumber == 0
              ? Center(child: Text("HomeScreen"))
              : screenNumber == 1
                  ? Center(child: Text("SearchScreen"))
                  : screenNumber == 2
                      ? Center(child: Text("InsightsScreen"))
                      : screenNumber == 3
                          ? Center(child: Text("FavouritesScreen"))
                          : Center(child: Text("ProfileScfreen")),
          Positioned(
            top: 60.0,
            left: 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    width: 35.0,
                    child: Image.asset("assets/images/menu.png"))
                ),
                SizedBox(
                  width: 20.0,
                ),
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: AppColors.textGreyColor.withOpacity(0.5),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: AppColors.textGreyColor,
                      size: 35.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        onSelectScreen: (value) {
          setState(() {
            currentIndex = value;
            screenNumber = value;
          });
        },
      ),
    );
  }
}
