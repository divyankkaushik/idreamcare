import 'package:firebase_auth/firebase_auth.dart';
import 'package:idreamcare/feature/authentication/screens/otpscreen/widgets/widget.dart';
import 'package:idreamcare/feature/authentication/screens/phoneauth/firebasedb/firebase_db.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, this.contactNumber, this.verificationUSerId})
      : super(key: key);
  final String? contactNumber;
  final String? verificationUSerId;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? timer;
  int time = 30;
  HapticFeedback? hapticFeedback;
  FocusScopeNode _node = FocusScopeNode();
  String otpPin = "858585";
  String otpText = "";
  bool isCorrect = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseRepository appUser = FirebaseRepository();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

//  starts resend otp timer
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  // creates otp text field
  Widget _getInputField() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 200,
        alignment: Alignment.center,
        child: Center(
          child: OTPTextField(
            onChanged: (value) {
              if (value.isNotEmpty || value.length > 6) {
                setState(() {
                  isCorrect = true;
                  hapticFeedback?.errorVibration();
                });
              }
              if (value.isNotEmpty) {
                setState(() {
                  otpText = value;
                });
              }
            },
            keyboardType: TextInputType.number,
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 25,
            style: TextStyle(
              fontSize: 17,
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) async {
              AuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationUSerId ?? "",
                  smsCode: pin.trim());
              UserCredential result =
                  await auth.signInWithCredential(credential);
              User? user = result.user;
              if (user != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Homescreen(),
                  ),
                );
              } else {
                print("error");
              }
              appUser.setData(widget.contactNumber);
              setState(() {
                isCorrect = true;
              });
            },
          ),
        ),
      ),
    );
  }

  // Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Resend OTP in ",
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          new SizedBox(
            width: 5.0,
          ),
          new Text(
            "00:${time.toString()}",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  // Resend otp button
  get _getResendText {
    return Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: (time <= 30) ? () {} : null,
          child: new Text(
            "Resend OTP",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ));
  }

  @override
  void dispose() {
    timer?.cancel();
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 60.0, right: 20.0),
        child: Container(
          height: size.height,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Navigation back button at top left
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios)),
            Spacer(),
            // first heading text
            Text(
              "Enter OTP",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.indigo[900],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            // second heading text
            Text(
                "Please enter the verification code sent to ${widget.contactNumber}"),
            Spacer(),
            // otp text fields
            _getInputField(),
            Spacer(),
            // different pop ups shown during otp verification
            (otpText.length < 6)
                ?
                // shows loading lottie file
                LottieFiles()
                : (otpText == otpPin)
                    ?
                    // show otp corrects container
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 100,
                          height: 40.0,
                          decoration: BoxDecoration(
                              color: Colors.lightGreen.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                              child: Text(
                            "OTP corect",
                            style: TextStyle(color: Colors.green),
                          )),
                        ),
                      )
                    : Container(
                        height: 40.0,
                      ),
            Spacer(),
            (time == 0) ? _getResendText : _getTimerText,
            Spacer(),
            // display image
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 200,
                child: Image.asset(
                  "assets/images/Fingerprint_bro1.png",
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
          ]),
        ),
      ),
    );
  }
}
