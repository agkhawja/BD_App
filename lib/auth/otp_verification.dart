import 'dart:async';

import 'package:bd_app/auth/change_password.dart';
import 'package:bd_app/widgets/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackground(),
          Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'OTP\nVerification',
                  style: GoogleFonts.syne(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Check your email address and Verify Your OTP to Proceed. Just OneStep Away! ',
                      style: GoogleFonts.syne(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomSheet: Container(
        height: 70.h,
        child: BottomSheet(
          backgroundColor: const Color.fromARGB(255, 253, 250, 250),
          onClosing: () {},
          builder: (context) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Enter OTP ',
                        style: GoogleFonts.syne(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
                  child: PinCodeTextField(
                    textStyle: TextStyle(fontSize: 20.sp),
                    appContext: context,
                    length: 4,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      fieldHeight: 8.h,
                      fieldWidth: 17.w,
                      activeColor: Colors.cyan,
                      inactiveColor: Colors.grey,
                      shape: PinCodeFieldShape.box,
                      borderWidth: 1,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    cursorColor: Colors.black,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 20),
                Text('You can resend the code in 56 seconds', style: GoogleFonts.syne(fontSize: 16.sp, color: const Color.fromRGBO(39, 54, 78, 1))),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      'Resend Code',
                      style: GoogleFonts.syne(
                        fontSize: 16.sp,
                        color: const Color.fromRGBO(22, 103, 128, 1),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 170, right: 170),
                      child: Divider(
                        thickness: 1,
                        height: 1,
                        color: Color.fromRGBO(22, 103, 128, 1),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 300),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 65),
                      backgroundColor: const Color.fromRGBO(22, 103, 128, 1),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChangePassword();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Verify',
                      style: GoogleFonts.syne(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
