import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpPage extends StatefulWidget {
  final String mobNum;
  OtpPage({required this.mobNum, super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final OtpFieldController otp = OtpFieldController();
  String otpString = '';
  int seconds = 15;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Verify Phone',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Code is sent to ${widget.mobNum}'),
              const SizedBox(height: 50.0),
              OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width,
                fieldWidth: (MediaQuery.of(context).size.width / 4) - 25,
                controller: otp,
                onChanged: (value) {
                  setState(() {
                    otpString = value;
                  });
                },
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceBetween,
                fieldStyle: FieldStyle.box,
                // onCompleted: (pin) {
                //   print("Completed: " + pin);
                // },
              ),
              const SizedBox(height: 50.0),
              seconds == 0
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          seconds = 15;
                        });
                        startTimer();
                      },
                      child: Text('Resend Otp'),
                    )
                  : Text('Resend Otp in $seconds'),
              const SizedBox(height: 50.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: TextButton(
                  onPressed: otpString.length < 4 ? null : () {},
                  style: TextButton.styleFrom(
                    shape: StadiumBorder(),
                    foregroundColor: Colors.white,
                    backgroundColor: otpString.length < 4
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                  ),
                  child: Text('Verify'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
