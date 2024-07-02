import 'package:finsnap/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;

  signUpFunc() async {
    if (password.text != confirmPassword.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      setState(() {
        isLoading = false;
      });
      Get.offAll(wrapper());
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
          "Signup",
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
                      // SizedBox(height: 20),
                       Image.asset('assets/signup-asset.png'),
                      //  SizedBox(height:10),
                      TextField(
                        controller: email,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter Mail",
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
                      SizedBox(height: 20),
                      TextField(
                        controller: password,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Color.fromARGB(190, 6, 34, 43),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: confirmPassword,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Color.fromARGB(190, 6, 34, 43),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => signUpFunc(),
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
                              "Sign Up",
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







// import 'package:finsnap/wrapper.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class signUp extends StatefulWidget {
//   const signUp({super.key});

//   @override
//   State<signUp> createState() => _signUpState();
// }

// class _signUpState extends State<signUp> {
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController confirm_password = TextEditingController();

//   signUp_func()async
//   {
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
//     Get.offAll(wrapper());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Signup",
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               TextField(
//                 controller: email,
//                 decoration: InputDecoration(hintText: "Enter Mail"),
//               ),
//               TextField(
//                 controller: password,
//                 decoration: InputDecoration(hintText: "Enter Passwoord"),
//               ),
//               TextField(
//                 controller: confirm_password,
//                 decoration: InputDecoration(hintText: "Confirm Passwoord"),
//               ),
//               ElevatedButton(
//                 onPressed: (()=>signUp_func()),
//                 child: Text("Sign Up"),
//               ),
//             ],
//           ),
//         ));
//   }
// }