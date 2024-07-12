// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// // import 'package:finsnap/wrapper.dart';
// // import 'package:pinput/pinput.dart';
// import 'package:finsnap/otp-phone-page.dart';
// class phoneVerify extends StatefulWidget {
//   const phoneVerify({super.key});

//   @override
//   State<phoneVerify> createState() => _phoneVerifyState();
// }

// class _phoneVerifyState extends State<phoneVerify> {
//   final TextEditingController phoneNumberController = TextEditingController();

//   Future<void>sendOtp() async
//   {
//     try
//     {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNumberController.text,
//         verificationCompleted: (PhoneAuthCredential credential) {},
//         verificationFailed: (FirebaseAuthException e) {
//           Get.snackbar("Error Occured", e.code);
//         },
//         codeSent: (verificationId, resendingToken) {
//           Get.to(otpPage(verificationId: verificationId));
//         },
//         codeAutoRetrievalTimeout: (verificationId) {},
//       );
//     }
//     on FirebaseAuthException catch(e)
//     {
//       Get.snackbar("Error msg" ,e.code);
//     }

//     catch(e)
//     {
//       Get.snackbar("Error msg" ,e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(shrinkWrap: true, children: [
//         Center(child: Text("Enter your phone number")),
//         Padding(
//           padding: const EdgeInsets.all(5),
//           child: Text("blah blah blah......"),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         phoneText(),
//         SizedBox(
//           height: 20,
//         ),
//         otpButton(),
//       ]),
//     );
//   }
// }

// Widget phoneText() {
//   // final TextEditingController phone_number_text = TextEditingController();
//   return Padding(
//     padding: const EdgeInsets.all(10),
//     child: TextField(
//       controller: phoneNumberController,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(prefixIcon: Icon(Icons.phone),labelText: "Enter Phone Number",),
//     ),
//   );
// }

// Widget otpButton() {
//   return Center(
//     child: ElevatedButton(
//       onPressed: () {
//         sendOtp();
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Text("Recieve Otp"),
//       ),
//     ),
//   );
// }



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finsnap/screens/otp-phone-page.dart';

class PhoneVerify extends StatefulWidget {
  const PhoneVerify({super.key});

  @override
  State<PhoneVerify> createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> sendOtp() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91'+phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error Occurred", e.code);
        },
        codeSent: (verificationId, resendingToken) {
          Get.to(otpPage(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error msg", e.code);
    } catch (e) {
      Get.snackbar("Error msg", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Center(child: Text("Enter your phone number")),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text("blah blah blah......"),
          ),
          SizedBox(height: 20),
          phoneText(),
          SizedBox(height: 20),
          otpButton(),
        ],
      ),
    );
  }

  Widget phoneText() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: phoneNumberController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          labelText: "Enter Phone Number",
        ),
      ),
    );
  }

  Widget otpButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          sendOtp();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text("Receive OTP"),
        ),
      ),
    );
  }
}

