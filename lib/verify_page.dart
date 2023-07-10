import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage(
      {Key? key,
      required String verificationId,
      required TextEditingController otpController})
      : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String otp = '';

  void verifyOTP() {
    // Add your OTP verification logic here
    if (otp == '1234') {
      // OTP is correct
      // Add your code to navigate to the next screen or perform any desired action
      print('OTP verified successfully');
    } else {
      // OTP is incorrect
      print('OTP verification failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Verify Phone',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Code is sent to',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const Text(
                  'Mobile Number',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // OTP input field
                TextField(
                  onChanged: (value) {
                    setState(() {
                      otp = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E3B62),
                    minimumSize: const Size(200, 40),
                  ),
                  child: const Text(
                    'SUBMIT OTP',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Didn’t receive the code? Request Again',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E3B62),
                    minimumSize: const Size(200, 40),
                  ),
                  child: const Text(
                    'VERIFY AND CONTINUE',
                    style: TextStyle(
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
