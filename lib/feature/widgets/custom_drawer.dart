import 'package:flutter/material.dart';
import 'package:idreamcare/constants/constants.dart';
import 'package:idreamcare/feature/authentication/screens/landingscreen/widgets/widget.dart';
import 'package:idreamcare/feature/authentication/screens/phoneauth/provider/phone_auth_provider.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatefulWidget {
  CustomDrawer(
      {Key? key, this.onProfilePressed, this.onListChildPressed, this.index})
      : super(key: key);

  final Function? onProfilePressed;
  int? index;
  final Function(int)? onListChildPressed;

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  PhoneAuthentication phoneAuthentication = PhoneAuthentication();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      child: Drawer(
        child: Container(
            color: AppColors.whiteColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Drawer items"),
                  Text("Career Assessment"),
                  ElevatedButton(
                      onPressed: () {
                        phoneAuthentication.logOutUser();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (contetx) => PhoneAuthScreen()));
                      },
                      child: Row(
                        children: [Icon(Icons.exit_to_app), Text("Logout")],
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
