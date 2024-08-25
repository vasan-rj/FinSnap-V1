

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finsnap/screens/forgetpassword.dart';
import 'package:finsnap/screens/signup.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool is_loading = false;

  Future<void> google_sign_in() async {
    setState(() {
      is_loading = true;
    });

    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth == null) {
        throw FirebaseAuthException(
          code: 'ERROR_GOOGLE_AUTH_FAILED',
          message: 'Google authentication failed',
        );
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error msg", e.code);
    } catch (e) {
      Get.snackbar("Error msg", e.toString());
    }

    setState(() {
      is_loading = false;
    });
  }

  Future<void> signIn() async {
    setState(() {
      is_loading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error msg", e.code);
    } catch (e) {
      Get.snackbar("Error msg", e.toString());
    }
    setState(() {
      is_loading = false;
    });
  } 

  @override
  Widget build(BuildContext context) {
    return is_loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.black87,
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      autocorrect: true,
                      
                      controller: email,
                      style: const TextStyle(color: Colors.white,backgroundColor: Colors.black45),
                      
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.black12,
                        
                        // backgroundColor:Color.fromARGB(85, 0, 0, 0)
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                          
                          
                        ),
                        prefixIcon: const Icon(Icons.email, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: password,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility, color: Colors.grey),
                          onPressed: () {
                            // Implement visibility toggle
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (value) {
                                // value:true;
                              },
                              // activeColor: Colors.blue,
                            ),
                            const Text(
                              "Remember me",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => Get.to(const ForgetPassword()),
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(color:Color.fromARGB(210, 5, 242, 155),)
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
  onPressed: () => signIn(),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.zero, // Remove padding from ElevatedButton
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  child: Ink(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [  Color.fromARGB(210, 5, 242, 155), Colors.teal],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(minHeight: 50), // Set a minimum height for the button
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: const Text(
        "Sign In",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ),
),

                  
                    const SizedBox(height: 25),
                    const Text(
                      "Or Sign In with",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        
                        ElevatedButton.icon(
                          onPressed: () => google_sign_in(),
                          icon: const Icon(Icons.g_translate, color: Colors.white),
                          label: Container(child: const Text("Google",style: TextStyle(color: Colors.white),)),
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () => Get.to(const SignUp()),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Color.fromARGB(210, 5, 242, 155)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}


