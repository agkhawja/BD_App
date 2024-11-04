import 'package:bd_app/auth/signup_success.dart';
import 'package:bd_app/widgets/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomBackground(),
          Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Forgot\nPassword',
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
                      'Almost there! create a new password for your account to keep it secure.',
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      iconColor: const Color.fromRGBO(22, 103, 128, 1),
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 12),
                        child: Image.asset(
                          'images/key.png',
                        ),
                      ),
                      hintText: 'New Password',
                      hintStyle: GoogleFonts.syne(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      suffixIcon: Image.asset('images/eye1.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      iconColor: const Color.fromRGBO(22, 103, 128, 1),
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 12),
                        child: Image.asset(
                          'images/key.png',
                        ),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: GoogleFonts.syne(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      suffixIcon: Image.asset('images/eye1.png'),
                    ),
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
                            return SignupSuccess();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Change Password',
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
