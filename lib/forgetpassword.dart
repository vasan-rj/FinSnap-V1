// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// class forgetPassword extends StatefulWidget {
//   const forgetPassword({super.key});

//   @override
//   State<forgetPassword> createState() => _forgetPasswordState();
// }

// class _forgetPasswordState extends State<forgetPassword> {
//   TextEditingController email = TextEditingController();

//   reset() async {
//     try
//     {
//     await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
//     }
//     on FirebaseAuthException catch (e)
//     {
//       Get.snackbar("Error", e.code);
//     }
//     catch (e) 
//     {
//       Get.snackbar("Error", e.toString());
//     }

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Forgot Password",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             Text(
//               "Forgot Password",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Enter the email associated with your account and we'll send an email with instructions to reset your password.",
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 30),
//             TextField(
//               controller: email,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: "Enter your Mail address",
//                 hintStyle: TextStyle(color: Colors.grey),
//                 filled: true,
//                 fillColor: Colors.black12,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide.none,
//                 ),
//                 prefixIcon: Icon(Icons.email, color: Colors.grey),
//               ),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () => reset(),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.zero, // Remove padding from ElevatedButton
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Ink(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.green, Colors.blue],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Container(
//                   alignment: Alignment.center,
//                   constraints: BoxConstraints(minHeight: 50), // Set a minimum height for the button
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   child: Text(
//                     "Continue",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.black87,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  bool isLoading = false;

  reset() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Check Mail", style: TextStyle(color: Color.fromARGB(210, 5, 242, 155))),
            content: Text("Password reset email has been sent to ${email.text}. Please check your mail.", maxLines: 4),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK", style: TextStyle(color: Color.fromARGB(210, 5, 242, 155))),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar("Error", e.message ?? e.code);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                       Image.asset('assets/forget-password-asset.png'),
                      TextField(
                        controller: email,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter your Mail address",
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Color.fromARGB(190, 6, 34, 43),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          "Enter the email associated with your account and we'll send an email with instructions to reset your password.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => reset(),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, // Remove padding from ElevatedButton
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromARGB(210, 5, 242, 155), Color.fromARGB(255, 4, 140, 126)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(minHeight: 50), // Set a minimum height for the button
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      backgroundColor: Colors.black87,
    );
  }
}