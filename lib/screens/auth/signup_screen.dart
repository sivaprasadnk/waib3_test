import 'package:flutter/material.dart';
import 'package:machine_test/screens/auth/login_btn.dart';
import 'package:machine_test/screens/home/home_screen.dart';
import 'package:machine_test/screens/widgets/logo_text.dart';
import 'package:machine_test/utils/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final bool _showSignInFields = true;
  final bool _showSignUpFields = false;

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  checkAndNavigate() {
    var number = _numberController.text;
    if (number == kSignInNumber) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const HomeScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlackColor,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 100),
            const LogoText(),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 165,
              child: Stack(
                children: [
                  Positioned(
                    bottom: -103,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/car.png', // Replace with your car image path
                      width: 286,
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 40),
                          TextFormField(
                            controller: _numberController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              color: kWhiteColor,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.call_outlined,
                                color: kGrey1Color,
                              ),
                              hintText: 'Mobile Number *',
                              hintStyle: const TextStyle(
                                color: kGrey1Color,
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: kGrey1Color,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          if (_showSignUpFields)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 10),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    hintText: 'Full Name',
                                    hintStyle: const TextStyle(
                                      color: kGrey1Color,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: kGrey1Color,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: const TextStyle(
                                      color: kGrey1Color,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: kGrey1Color,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  'By clicking continue, you agree to our',
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 14,
                                  ),
                                ),
                                // const SizedBox(height: 10),
                                const Text(
                                  'Terms of Service and Privacy Policy',
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          else if (_showSignInFields)
                            const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 55),
                                Text(
                                  'Welcome Back to CarPool',
                                  style: TextStyle(
                                    color: kGrey3Color,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 95),
                              ],
                            ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              checkAndNavigate();
                            },
                            child: const LoginBtn(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
