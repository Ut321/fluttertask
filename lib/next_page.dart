import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertask/profile_page.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String phoneNumber = '';
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3B62),
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Back to Home Page',
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Please Enter your Mobile Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  'You\'ll receive a 4-digit code',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'to verify next',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final double containerWidth =
                        constraints.maxWidth > 400 ? 400 : constraints.maxWidth;
                    return SizedBox(
                      width: containerWidth,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 57,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black87,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 4,
                                ),
                                child: IntlPhoneField(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 2,
                                      right: 4,
                                      top: 8,
                                      bottom: 4,
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Mobile Number',
                                  ),
                                  initialCountryCode: 'IN',
                                  onChanged: (number) {
                                    setState(() {
                                      phoneNumber = number.completeNumber;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    void verificationCompleted(
                        PhoneAuthCredential credential) async {
                      await auth.signInWithCredential(credential);
                    }

                    void verificationFailed(FirebaseAuthException exception) {
                      print("Verification failed");
                    }

                    void codeSent(String verificationId, int? resendToken) {
                      setState(() {
                        verificationId = verificationId;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerificationPage(
                            verificationId: verificationId,
                          ),
                        ),
                      );
                    }

                    void codeAutoRetrievalTimeout(String verificationId) {}

                    await auth.verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      verificationCompleted: verificationCompleted,
                      verificationFailed: verificationFailed,
                      codeSent: codeSent,
                      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E3B62),
                    minimumSize: const Size(200, 40),
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationPage extends StatefulWidget {
  final String verificationId;

  const VerificationPage({Key? key, required this.verificationId})
      : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String otp = '';
  TextEditingController otpController = TextEditingController();

  void verifyOTP() {
    String enteredOTP = otpController.text;
    if (enteredOTP == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileSelectionPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the correct OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the 4-digit code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                onChanged: (value) {
                  setState(() {
                    otp = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'OTP',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: verifyOTP,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 40),
                ),
                child: const Text(
                  'VERIFY',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// class VerificationPage extends StatelessWidget {
//   final String verificationId;

//   const VerificationPage({Key? key, required this.verificationId})
//       : super(key: key);

//   void _showSnackBar(BuildContext context, String message) {
//     final snackBar = SnackBar(content: Text(message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   void _verifyOTP(
//       BuildContext context, List<TextEditingController> otpControllers) async {
//     String enteredOtp =
//         otpControllers.map((controller) => controller.text).join('');

//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: enteredOtp,
//       );

//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(
//         credential,
//       );

//       if (userCredential.user != null) {
//         // OTP is verified successfully
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProfileSelectionPage(),
//           ),
//         );
//       } else {
//         // OTP verification failed
//         _showSnackBar(context, 'Please input correct OTP.');
//       }
//     } catch (error) {
//       print('Sign-in error: $error');
//       _showSnackBar(context, 'Please input correct OTP.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<TextEditingController> otpControllers = List.generate(
//       6,
//       (index) => TextEditingController(),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E3B62),
//         title: const Text('OTP Verification'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Verify Phone',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Code is sent to',
//                 style: TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: List.generate(
//                   6,
//                   (index) => Container(
//                     width: 40,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF93D2F3),
//                       border: Border.all(
//                         color: Colors.transparent,
//                         width: 2,
//                       ),
//                       borderRadius: BorderRadius.zero,
//                     ),
//                     child: Center(
//                       child: TextField(
//                         cursorColor: Colors.red,
//                         controller: otpControllers[index],
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         maxLength: 1,
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {
//                             if (index < 5) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               FocusScope.of(context).unfocus();
//                             }
//                           }
//                         },
//                         style: const TextStyle(fontSize: 20),
//                         decoration: const InputDecoration(
//                           counterText: '',
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 18),
//               RichText(
//                 text: TextSpan(
//                   text: "Didn’t receive the code? ",
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: "Request Again",
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = () {
//                           // Implement the logic to request the code again
//                         },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 22),
//               ElevatedButton(
//                 onPressed: () => _verifyOTP(context, otpControllers),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF2E3B62),
//                   minimumSize: const Size(250, 60),
//                 ),
//                 child: const Text(
//                   'VERIFY AND CONTINUE',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
