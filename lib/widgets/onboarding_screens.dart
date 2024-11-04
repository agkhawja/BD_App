import 'package:bd_app/auth/signup.dart';
import 'package:bd_app/widgets/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardingScreens extends StatelessWidget {
  const OnboardingScreens({
    super.key,
    required this.page,
    required this.mainText,
    required this.image,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  final int page;
  final VoidCallback onPressed;
  final String mainText;
  final String image;
  final String description;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomBackground(),
        Column(
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                const SizedBox(width: 80),
                Container(
                  width: 60.w,
                  height: 1.h,
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: page == 0 ? const Color.fromRGBO(252, 191, 34, 1) : Colors.transparent, borderRadius: const BorderRadius.all(Radius.circular(20))),
                        height: 1.h,
                        width: 20.w,
                      ),
                      Container(
                        decoration: BoxDecoration(color: page == 1 ? const Color.fromRGBO(252, 191, 34, 1) : Colors.transparent, borderRadius: const BorderRadius.all(Radius.circular(20))),
                        height: 1.h,
                        width: 20.w,
                      ),
                      Container(
                        decoration: BoxDecoration(color: page == 2 ? const Color.fromRGBO(252, 191, 34, 1) : Colors.transparent, borderRadius: const BorderRadius.all(Radius.circular(20))),
                        height: 1.h,
                        width: 20.w,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 25),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) {
                        return Signup();
                      },
                    ));
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.syne(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              textAlign: TextAlign.center,
              mainText,
              style: GoogleFonts.syne(color: Colors.white, fontSize: 45, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Container(
              height: 400,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(248, 163, 29, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Image.asset(
                  height: 350,
                  image,
                  scale: 0.5,
                ),
                // height: 400,

                // image: AssetImage('images/base.png',),
              ),
            ),
            // ),
            const SizedBox(height: 40),
            Container(
              height: 25.h,
              width: 90.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      description,
                      style: GoogleFonts.syne(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Flexible(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: const Color.fromRGBO(22, 103, 128, 1),
                      ),
                      onPressed: onPressed,
                      child: Text(
                        buttonText,
                        style: GoogleFonts.syne(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
