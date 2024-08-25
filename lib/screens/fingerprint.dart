import 'package:finsnap/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class fingerprintPage extends StatefulWidget {
  const fingerprintPage({super.key});

  @override
  State<fingerprintPage> createState() => _fingerprintPageState();
}

class _fingerprintPageState extends State<fingerprintPage> {
  final LocalAuthentication fingerprintauth = LocalAuthentication();

  checkAuth() async {
    bool isAvailable = await fingerprintauth.canCheckBiometrics;
    if (isAvailable) {
      bool result = await fingerprintauth.authenticate(
        localizedReason: "Scan Your FingerPrint to proceed",
      );
      if (result) {
        Get.offAll(const wrapper());
      } else {
        Get.snackbar("Error msg", "Authentication Failed");
      }
    } else {
      Get.offAll(const wrapper());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Fingerprint Authentication",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/logo3.png', height: 200, width: 200),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  checkAuth();
                },
                style: ElevatedButton.styleFrom(
                  // primary: Color.fromARGB(255, 33, 150, 243),
                  // onPrimary: Colors.white,
                  backgroundColor: const Color.fromARGB(210, 5, 242, 155) ,
                  // foregroundColor:
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  color:Colors.white,
                  ),
                )
            
          ),
            ]
        ),
      ),
      )
    );
  }
}
