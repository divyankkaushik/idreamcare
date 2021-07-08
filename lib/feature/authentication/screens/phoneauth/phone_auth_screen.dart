import 'package:country_code_picker/country_code_picker.dart';
import 'package:idreamcare/constants/constants.dart';
import 'package:idreamcare/feature/authentication/screens/phoneauth/provider/phone_auth_provider.dart';
import 'package:idreamcare/feature/authentication/screens/phoneauth/widgets/widget.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool textIsEmplty = true;
  Timer? _timer;

  HapticFeedback? hapticFeedback;

  TextEditingController _controller = new TextEditingController();
  final phoneAuthentication = PhoneAuthentication();
  String countryCodeNumber = "";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        setState(() {
          textIsEmplty = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color textfieldBorderColor =
        (textIsEmplty) ? AppColors.errorColor : AppColors.primaryBlueColor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 60.0, right: 20.0),
        child: Container(
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Navigation back button at top left
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios)),
              Spacer(),
              // first heading text
              Text(
                "Enter your",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(
                height: 5.0,
              ),
              // second heading text
              Text("Mobile Number"),
              SizedBox(
                height: 5.0,
              ),
              Text("We will send you a one time password(OTP)"),
              Spacer(),
              // phone number textfield
              phoneNumberTextField(textfieldBorderColor),
              Spacer(),
              // different pop ups shown during otp verification
              (textIsEmplty)
                  ?
                  // shows error Container
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 250,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                            child: Text(
                          "Please enter a valid mobile number",
                          style: TextStyle(color: Colors.red),
                        )),
                      ),
                    )
                  : (_controller.text.length < 10)
                      ?
                      // shows loading lottie file
                      LottieFiles()
                      : (_controller.text.length == 10)
                          ?
                          // Navigation to Otp Page Button
                          Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    phoneAuthentication.phoneNumber =
                                        _controller.text.trim();
                                  });
                                  phoneAuthentication.loginUser(
                                      countryCodeNumber +
                                          phoneAuthentication.phoneNumber!,
                                      context);
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 250,
                  child: Image.asset(
                    "assets/images/Group841.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Spacer(),
              // more login option at the bottom of the screen
              MoreLoginOption(),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onCountryChange(CountryCode? countryCode) {
    this.countryCodeNumber = countryCode.toString();
    print(countryCode);
  }

//  phoneNumber TextField
  Align phoneNumberTextField(Color textfieldBorderColor) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 200.0,
        height: 50.0,
        child: Center(
          child: Row(
            children: [
              Container(
                  width: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: CountryCodePicker(
                    onChanged: _onCountryChange,
                    onInit: _onCountryChange,
                    initialSelection: "IN",
                    showFlagMain: false,
                    alignLeft: true,
                  ),
                ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                  child: TextField(
                controller: _controller,
                onChanged: (value) {
                  if (value.isEmpty || value.length > 10) {
                    setState(() {
                      textIsEmplty = true;
                      hapticFeedback?.errorVibration();
                    });
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Here",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: textfieldBorderColor)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: textfieldBorderColor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: textfieldBorderColor),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
