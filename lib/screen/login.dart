import 'package:flutter/material.dart';
import 'package:sample_proj/screen/otp.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobNum = TextEditingController();
  String mNum = '';

  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginKey,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Login'),
                  const SizedBox(height: 50.0),
                  TextFormField(
                    controller: mobNum,
                    onChanged: (value) {
                      setState(() {
                        mNum = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Mobile No.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: TextButton(
                      onPressed: mNum.length < 10
                          ? null
                          : () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return OtpPage(
                                  mobNum: mobNum.text,
                                );
                              }));
                            },
                      style: TextButton.styleFrom(
                        shape: StadiumBorder(),
                        foregroundColor: Colors.white,
                        backgroundColor: mNum.length < 10 ? Colors.grey : Theme.of(context).primaryColor,
                      ),
                      child: Text('Send Otp'),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('New Account ? '),
                      TextButton(
                        onPressed: () {},
                        child: Text('Register'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
