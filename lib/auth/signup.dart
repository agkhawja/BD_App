import 'package:bd_app/auth/forgot_password.dart';
import 'package:bd_app/screens/home_screen%20.dart';
import 'package:bd_app/screens/route.dart';
import 'package:bd_app/services/api_services.dart';
import 'package:bd_app/widgets/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController textEditingControllerEmailLogin = TextEditingController();
  TextEditingController textEditingControllerPasswordLogin = TextEditingController();
  TextEditingController signUpFirstNameTextEditingController = TextEditingController();
  TextEditingController signUpLastNameTextEditingController = TextEditingController();
  TextEditingController signUpEmailTextEditingController = TextEditingController();
  TextEditingController signUpPasswordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSelected = false;
  bool checkBox = false;
  bool isSignUp = false;
  bool eyeVisibility = false;
  Future<void> _validateSignUpInputs() async {
    if (_formKey.currentState!.validate()) {
      if (checkBox == false) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Agree to the User Agreement and Privacy Policy.")));
        return;
      }
      Map<String, dynamic> requestBody = {
        "first_name": signUpFirstNameTextEditingController.text.trim(),
        "last_name": signUpLastNameTextEditingController.text.trim(),
        "email": signUpEmailTextEditingController.text.trim(),
        "password": signUpPasswordTextEditingController.text.trim(),
        "subscription_id": 1, // Default to 1 if invalid
      };
      var result = await ApiService().signupUser(context, requestBody);

      if (result["status"] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("SignUp Successfully!")));
        setState(() {
          isSelected = false;
          isSignUp = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all required fields',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
          ),
        ),
      );
      // if (checkBox == true) {
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Please Agree to the User Agreement and Privacy Policy.'),
      //     ),
      //   );
      // }
    }
  }

  Future<void> _validateSignInInputs() async {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      // Form is valid, you can perform further actions
      textEditingControllerEmailLogin.toString().trim();
      textEditingControllerPasswordLogin.toString().trim();

      if (checkBox == true) {
        Map result = await ApiService().getLoginData(
          context,
          textEditingControllerEmailLogin.text.trim(),
          textEditingControllerPasswordLogin.text.trim(),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).clearSnackBars();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          result["message"],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
        )));
        if (result['message'] == 'Login successful') {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const RoutePage();
              },
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please Agree to the User Agreement and Privacy Policy.',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
            ),
          ),
        );
      }
    } else {
      // Form is invalid, show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all required fields',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
          ),
        ),
      );
    }
  }

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
                  'Create your\nBrilliant Account',
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
                  child: Text(
                    textAlign: TextAlign.center,
                    'Welcome! Let\'s get started by creating your fresh account.',
                    style: GoogleFonts.syne(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomSheet: SizedBox(
        height: 70.h,
        child: BottomSheet(
          backgroundColor: const Color.fromARGB(255, 253, 250, 250),
          onClosing: () {},
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(9, 1, 12, 49),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = true;
                              isSignUp = true;
                            });
                          },
                          child: Center(
                            child: Container(
                              height: 6.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: isSelected == false ? Colors.transparent : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.syne(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected == false ? Colors.black : const Color.fromRGBO(22, 103, 128, 1),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = false;
                              isSignUp = false;
                            });
                          },
                          child: Center(
                            child: Container(
                              height: 6.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: isSelected == true ? Colors.transparent : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.syne(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected == true ? Colors.black : const Color.fromRGBO(22, 103, 128, 1),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isSignUp == true
                    ? Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: TextFormField(
                                controller: signUpFirstNameTextEditingController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your First Name';
                                  }
                                  return null;
                                },
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
                                      'images/Vector.png',
                                    ),
                                  ),
                                  hintText: 'First Name',
                                  hintStyle: GoogleFonts.syne(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: TextFormField(
                                controller: signUpLastNameTextEditingController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter your Last Name';
                                  }
                                  return null;
                                },
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
                                      'images/Vector.png',
                                    ),
                                  ),
                                  hintText: 'Last Name',
                                  hintStyle: GoogleFonts.syne(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: TextFormField(
                                controller: signUpEmailTextEditingController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter your Email.';
                                  }
                                  return null;
                                },
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
                                      'images/sms.png',
                                    ),
                                  ),
                                  hintText: 'Email Address',
                                  hintStyle: GoogleFonts.syne(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: TextFormField(
                                controller: signUpPasswordTextEditingController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Password';
                                  }
                                  return null;
                                },
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
                                  hintText: 'Enter Password',
                                  hintStyle: GoogleFonts.syne(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  suffixIcon: Image.asset('images/eye1.png'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 2,
                                    child: Checkbox(
                                      side: const BorderSide(width: 0.5),

                                      activeColor: Colors.green,
                                      //splashRadius: 100,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      value: checkBox,
                                      onChanged: (value) {
                                        setState(() {
                                          checkBox = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'By signing up, I agree to the User\nAgreement and Privacy Policy.',
                                    style: GoogleFonts.syne(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(350, 65),
                                  backgroundColor: const Color.fromRGBO(22, 103, 128, 1),
                                ),
                                onPressed: () async {
                                  _validateSignUpInputs();
                                },
                                child: Text(
                                  'Sign Me Up',
                                  style: GoogleFonts.syne(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                controller: textEditingControllerEmailLogin,
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
                                      'images/sms.png',
                                    ),
                                  ),
                                  hintText: 'Email Address',
                                  hintStyle: GoogleFonts.syne(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                obscureText: eyeVisibility,
                                controller: textEditingControllerPasswordLogin,
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
                                  hintText: 'Enter Password',
                                  hintStyle: GoogleFonts.syne(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        eyeVisibility = !eyeVisibility;
                                      });
                                    },
                                    child: Icon(
                                      color: const Color.fromRGBO(22, 103, 128, 1),
                                      eyeVisibility == false ? Icons.visibility : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const ForgotPassword();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password',
                                      style: GoogleFonts.syne(fontSize: 18, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 2,
                                    child: Checkbox(
                                      side: const BorderSide(width: 0.5),

                                      activeColor: Colors.green,
                                      //splashRadius: 100,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      value: checkBox,
                                      onChanged: (value) {
                                        setState(() {
                                          checkBox = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'By signing up, I agree to the User\nAgreement and Privacy Policy.',
                                    style: GoogleFonts.syne(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 130),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(350, 65),
                                  backgroundColor: const Color.fromRGBO(22, 103, 128, 1),
                                ),
                                onPressed: () async {
                                  _validateSignInInputs();
                                },
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.syne(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
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
