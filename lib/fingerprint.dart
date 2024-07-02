// import 'package:finsnap/wrapper.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:pinput/pinput.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:finsnap/utils/theme/elevatedbuttontheme.dart';
// class fingerprintPage extends StatefulWidget {
//   const fingerprintPage({super.key});

//   @override
//   State<fingerprintPage> createState() => _fingerprintPageState();
// }

// class _fingerprintPageState extends State<fingerprintPage> {
//   final LocalAuthentication fingerprintauth = LocalAuthentication();
//   checkAuth() async
//   {
    
//     bool is_Available=await fingerprintauth.canCheckBiometrics;
//     if(is_Available)
//     {
//       bool result=await fingerprintauth.authenticate(localizedReason: "Scan Your FingerPrint to proceed",);
//       if(result)
//       {
//         Get.offAll(wrapper());
//       }
//       else
//       {
//         Get.snackbar("Error msg", "Authentication Failed");
//       }

//     }
//     else
//     {
//       Get.offAll(wrapper());
//     }


//   }
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // const SizedBox(height: 10),
//           Text("Fingerprint Authentication",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
//           const SizedBox(height: 4),
          
//           Image.asset('assets/logo3.png'),
//           // widget.TElevatedButtonTheme.darkElevatedButtomTheme
          
//           Container(
//             margin: EdgeInsets.all(10),
//             child: ElevatedButton(
//               onPressed: ()
//               {
//                 checkAuth();
//               },
              
//               style:TextButton.styleFrom(
//                 backgroundColor:  Color.fromARGB(210, 5, 242, 155),
//                 // foregroundColor:Color.fromARGB(195, 40, 141, 105)
//                 ),
                
                
//               child: const Text("Verify",style: TextStyle(fontSize:20,color:Color.fromARGB(253, 219, 240, 233),height:5),),
//                ),
//           ),
//         ],
//       )
//     );
//     // return GetMaterialApp(
//     //   title: 'Flutter Demo',
//     //   theme: ThemeData(
//     //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//     //     useMaterial3: true,
//     //   ),
//     //   home: const wrapper(),
//     // );
//   }
// }

// ************
// GPT Code

// import 'package:finsnap/wrapper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:local_auth/local_auth.dart';

// class fingerprintPage extends StatefulWidget {
//   const fingerprintPage({super.key});

//   @override
//   State<fingerprintPage> createState() => _fingerprintPageState();
// }

// class _fingerprintPageState extends State<fingerprintPage> {
//   final LocalAuthentication fingerprintauth = LocalAuthentication();
  
//   checkAuth() async {
//     bool is_Available = await fingerprintauth.canCheckBiometrics;
//     if (is_Available) {
//       bool result = await fingerprintauth.authenticate(
//         localizedReason: "Scan Your FingerPrint to proceed",
//       );
//       if (result) {
//         Get.offAll(wrapper());
//       } else {
//         Get.snackbar("Error msg", "Authentication Failed");
//       }
//     } else {
//       Get.offAll(wrapper());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black87,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Fingerprint Authentication",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Image.asset('assets/logo3.png', height: 150, width: 150),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () {
//                   checkAuth();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   // primary: Color.fromARGB(255, 33, 150, 243),
//                   // onPrimary: Colors.white,
//                   backgroundColor: Color.fromARGB(210, 5, 242, 155) ,
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   elevation: 5,
//                 ),
//                 child: Text(
//                   "Verify",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
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
// GPT Code

import 'package:finsnap/wrapper.dart';
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
    bool is_Available = await fingerprintauth.canCheckBiometrics;
    if (is_Available) {
      bool result = await fingerprintauth.authenticate(
        localizedReason: "Scan Your FingerPrint to proceed",
      );
      if (result) {
        Get.offAll(wrapper());
      } else {
        Get.snackbar("Error msg", "Authentication Failed");
      }
    } else {
      Get.offAll(wrapper());
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
              Text(
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
                  backgroundColor: Color.fromARGB(210, 5, 242, 155) ,
                  // foregroundColor:
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: Text(
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
