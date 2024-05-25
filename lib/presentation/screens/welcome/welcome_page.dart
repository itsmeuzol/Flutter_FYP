import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen.dart';
import '../../../widgets/widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Flexible(
                  child: Column(
                    children: [
                      const Column(
                        children: [
                          Image(
                            image: AssetImage(
                              'assets/images/Eco.png',
                            ),
                            height: 100.0,
                          ),
                        ],
                      ),
                      const Text('SAFA SAHAR',
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/vector.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              "Welcome to Safa Sahar! Your journey towards a greener planet starts here. Track and manage your waste to make a positive impact on the environment.",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(216, 243, 220, 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyTextButton(
                          bgColor: const Color.fromRGBO(0, 62, 31, 2),
                          buttonName: 'Register',
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                        ),
                      ),
                      Expanded(
                        child: MyTextButton(
                          bgColor: const Color.fromRGBO(82, 183, 136, 2),
                          buttonName: 'Sign In',
                          textColor: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const SignInPage(),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
