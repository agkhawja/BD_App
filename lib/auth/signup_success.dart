import 'package:bd_app/screens/home_screen%20.dart';
import 'package:bd_app/screens/route.dart';
import 'package:bd_app/widgets/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignupSuccess extends StatefulWidget {
  const SignupSuccess({super.key});

  @override
  State<SignupSuccess> createState() => _SignupSuccessState();
}

class _SignupSuccessState extends State<SignupSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomBackground(),
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Container(
              child: Center(child: Image.asset('images/account created.png')),
            ),
          )
        ],
      ),
      bottomSheet: Container(
        height: 45.h,
        child: BottomSheet(
          backgroundColor: const Color.fromARGB(255, 253, 250, 250),
          onClosing: () {},
          builder: (context) {
            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Account\nSuccessfully Created!',
                      style: GoogleFonts.syne(
                        fontSize: 21.sp,
                        color: Color.fromRGBO(39, 54, 78, 1),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    textAlign: TextAlign.center,
                    'Congratulations, your account has been successfully created! You can now log in to start exploring all the features and benefits of our platform. Thank you for joining us!',
                    style: GoogleFonts.syne(
                      fontSize: 15.sp,
                      color: Color.fromRGBO(39, 54, 78, 1),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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
                              return RoutePage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Take Me to Home',
                        style: GoogleFonts.syne(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
