import 'package:flutter/material.dart';

import 'package:idreamcare/feature/authentication/screens/landingscreen/widgets/widget.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int page = 0;
  Color? color;

  LiquidController? liquidController;

  UpdateType? updateType;

  // list of data that goes in the pages
  List<ItemData> data = [
    ItemData(
        AppColors.whiteColor,
        "assets/images/Illustration.png",
        "assets/images/image28.png",
        "Explore like a",
        "Ninja!",
        "Take your career to next level with personalized career info based on your interests, skills & personality."),
    ItemData(
        AppColors.primaryBlueColor,
        "assets/images/Group840.png",
        "assets/images/tick.png",
        "Choose like a",
        "Pro!",
        "No matter what aspect of college life you are looking for, we provide listings and rankings based on your preferences."),
    ItemData(
        AppColors.whiteColor,
        "assets/images/Group838.png",
        "assets/images/image30.png",
        "Prepare for the",
        "Real World!",
        "We'll show you exactly what to do to make your dream job a reality."),
    ItemData(
        AppColors.primaryBlueColor,
        "assets/images/Group845.png",
        "assets/images/hand.png",
        "How can we",
        "Help?",
        "Get ready for your transition from school to college and finally to a perfect career with us!"),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    return new Icon(
      (page == index) ? Icons.circle : Icons.circle_outlined,
      color: (page == 0) ? AppColors.primaryBlueColor : color,
      size: 15.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            // Liquid swipe animation builder
            LiquidSwipe.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  color: data[index].color,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, top: 50.0, right: 20.0, bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        // skip text on the top right
                        (index == 3)
                            ? Container(
                                height: 10.0,
                              )
                            : Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "skip",
                                  style: TextStyle(
                                      color: (index == 1)
                                          ? AppColors.whiteColor
                                          : AppColors.textGreyColor),
                                ),
                              ),
                        //image container
                        Container(
                          height: 280,
                          width: 280,
                          child: Image.asset(
                            data[index].image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Spacer(),
                        // first heading text
                        Text(
                          data[index].text1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (index == 0 || index == 2)
                                  ? AppColors.primaryBlueColor
                                  : AppColors.whiteColor),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        // second heading text with image
                        Row(
                          children: [
                            Text(
                              data[index].text2,
                              style: TextStyle(
                                  fontSize: 42.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBlueColor),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              height: 40,
                              child: Image.asset(
                                data[index].image2,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        // desccription text
                        Container(
                          width: 220,
                          child: Text(
                            data[index].text3,
                            style: TextStyle(
                                wordSpacing: 4,
                                color: (index == 0 || index == 2)
                                    ? AppColors.textGreyColor
                                    : AppColors.whiteColor),
                          ),
                        ),
                        Spacer(),
                        // dots builder at the bottom left
                        dotsBuilder(index, context),
                      ],
                    ),
                  ),
                );
              },
              enableSideReveal: (page == 3) ? false : true,
              positionSlideIcon: 0.8,
              slideIconWidget: (page == 3)
                  ? Container()
                  : Stack(
                      children: [
                        Icon(Icons.arrow_back_ios),
                      ],
                    ),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              ignoreUserGestureWhileAnimating: true,
              enableLoop: false,
            ),
          ],
        ),
      ),
    );
  }

  Row dotsBuilder(int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: List<Widget>.generate(data.length, _buildDot),
        ),
        (index == 3)
            ? InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PhoneAuthScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 80,
                  height: 35.0,
                  decoration: BoxDecoration(
                      color: AppColors.primaryBlueColor,
                      border: Border.all(color: AppColors.whiteColor),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(color: AppColors.whiteColor),
                  )),
                ),
              )
            : Container()
      ],
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
      color = (page == 2) ? AppColors.primaryBlueColor : AppColors.whiteColor;
    });
  }
}
