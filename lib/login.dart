// before gpt code
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:finsnap/forgetpassword.dart';
// import 'package:finsnap/signup.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   bool is_loading=false;

//   Future<void>google_sign_in()async
//   {
//     setState((){
//       is_loading=true;
//     });

//     // ******
//      final GoogleSignIn googleSignIn = GoogleSignIn(
//       // Force the user to select an account every time
//       scopes: ['email'],
//       // prompt: 'select_account',  // Ensure prompt for account selection
//     );

//     try
//     {

//       final GoogleSignInAccount? googleUser= await googleSignIn.signIn();
//       final GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;

//       if(googleAuth==null)
//       {
//         throw FirebaseAuthException(
//           code: 'ERROR_GOOGLE_AUTH_FAILED',
//           message: 'Google authentication failed',
//         );
//       }

//       final credential=GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
      
//         await FirebaseAuth.instance.signInWithCredential(credential);
//     }
    
//      on FirebaseAuthException catch(e)
//     {
//       Get.snackbar("Error msg" ,e.code);
    
//     }

//     catch(e)
//     {
//       Get.snackbar("Error msg" ,e.toString());
//     }


//     setState((){
//       is_loading=false;
//     });
//   }

//   // *******
//   signIn()async
//   {
//     setState(() {
//       is_loading=true;
//     });
//     try
//     {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
//     }
    
//     on FirebaseAuthException catch(e)
//     {
//       Get.snackbar("Error msg" ,e.code);
//     }

//     catch(e)
//     {
//       Get.snackbar("Error msg" ,e.toString());
//     }
//     setState((){
//       is_loading=false;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return is_loading?Center(child: CircularProgressIndicator(),): Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "LoginPage",
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
//               ElevatedButton(
//                 onPressed: (()=>signIn()),
//                 child: Text("Login"),
//               ),

//               SizedBox(height: 20,),
//               ElevatedButton(
//                 onPressed: (()=>Get.to(signUp())),
//                 child: Text("SignUp"),
//               ),

//               SizedBox(height: 20,),
//               ElevatedButton(
//                 onPressed: (()=>Get.to(forgetPassword())),
//                 child: Text("Forget Password"),
//               ),

//                SizedBox(height: 20,),
//               ElevatedButton
//               (
//                 onPressed: (()=>google_sign_in()),
//                 child: Text("Sign In with Google"),
//               ),

//             ],
//           ),
//         ));
//   }
// }
// oG code
// ******************************
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:finsnap/forgetpassword.dart';
// import 'package:finsnap/signup.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   bool is_loading = false;

//   Future<void> google_sign_in() async {
//     setState(() {
//       is_loading = true;
//     });

//     final GoogleSignIn googleSignIn = GoogleSignIn(
//       scopes: ['email'],
//     );

//     try {
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//       final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//       if (googleAuth == null) {
//         throw FirebaseAuthException(
//           code: 'ERROR_GOOGLE_AUTH_FAILED',
//           message: 'Google authentication failed',
//         );
//       }

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar("Error msg", e.code);
//     } catch (e) {
//       Get.snackbar("Error msg", e.toString());
//     }

//     setState(() {
//       is_loading = false;
//     });
//   }

//   Future<void> signIn() async {
//     setState(() {
//       is_loading = true;
//     });
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar("Error msg", e.code);
//     } catch (e) {
//       Get.snackbar("Error msg", e.toString());
//     }
//     setState(() {
//       is_loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return is_loading
//         ? Center(child: CircularProgressIndicator())
//         : Scaffold(
//             appBar: AppBar(
//               title: Text("LoginPage", style: TextStyle(color: Colors.white)),
//               backgroundColor: Colors.black,
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: email,
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       hintText: "Enter Email",
//                       hintStyle: TextStyle(color: Colors.grey),
//                       filled: true,
//                       fillColor: Colors.black12,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       prefixIcon: Icon(Icons.email, color: Colors.grey),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextField(
//                     controller: password,
//                     obscureText: true,
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       hintText: "Enter Password",
//                       hintStyle: TextStyle(color: Colors.grey),
//                       filled: true,
//                       fillColor: Colors.black12,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       prefixIcon: Icon(Icons.lock, color: Colors.grey),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => signIn(),
//                     style: ElevatedButton.styleFrom(
//                       // primary: Colors.blueGrey,
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text("Login", style: TextStyle(color: Colors.white)),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => Get.to(signUp()),
//                     style: ElevatedButton.styleFrom(
//                       // primary: Colors.blueGrey,
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text("Sign Up", style: TextStyle(color: Colors.white)),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => Get.to(forgetPassword()),
//                     style: ElevatedButton.styleFrom(
//                       // primary: Colors.blueGrey,
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text("Forget Password", style: TextStyle(color: Colors.white)),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => google_sign_in(),
//                     style: ElevatedButton.styleFrom(
//                       // primary: Colors.redAccent,
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text("Sign In with Google", style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               ),
//             ),
//             backgroundColor: Colors.black87,
//           );
//   }
// }
// *********************************************
// New gpt code

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finsnap/forgetpassword.dart';
import 'package:finsnap/signup.dart';
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
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.black87,
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      autocorrect: true,
                      
                      controller: email,
                      style: TextStyle(color: Colors.white,backgroundColor: Colors.black45),
                      
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.black12,
                        
                        // backgroundColor:Color.fromARGB(85, 0, 0, 0)
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                          
                          
                        ),
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: password,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility, color: Colors.grey),
                          onPressed: () {
                            // Implement visibility toggle
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                            Text(
                              "Remember me",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => Get.to(ForgetPassword()),
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(color:Color.fromARGB(210, 5, 242, 155),)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
      gradient: LinearGradient(
        colors: [  Color.fromARGB(210, 5, 242, 155), Colors.teal],
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

                    // ElevatedButton(
                    //   onPressed: () => signIn(),
                    //   style: ElevatedButton.styleFrom(
                    //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ).copyWith(
                    //     backgroundColor: MaterialStateProperty.resolveWith((states) => null),
                    //     foregroundColor: MaterialStateProperty.all(Colors.white),
                    //   ),
                    //   child: Ink(
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: [Colors.green, Colors.blue],
                    //         begin: Alignment.centerLeft,
                    //         end: Alignment.centerRight,
                    //       ),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       child: Text(
                    //         "Sign In",
                    //         style: TextStyle(
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 25),
                    Text(
                      "Or Sign In with",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ElevatedButton.icon(
                        //   onPressed: () => google_sign_in(),
                        //   icon: Icon(Icons.facebook, color: Colors.white),
                        //   label: Text("Facebook"),
                        //   style: ElevatedButton.styleFrom(
                        //     // 
                        //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        // ),
                        ElevatedButton.icon(
                          onPressed: () => google_sign_in(),
                          icon: Icon(Icons.g_translate, color: Colors.white),
                          label: Container(child: Text("Google",style: TextStyle(color: Colors.white),)),
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () => Get.to(SignUp()),
                          child: Text(
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


// ******************************
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:finsnap/forgetpassword.dart';
// import 'package:finsnap/signup.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'pack'

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   bool isLoading = false;

//   Future<void> googleSignIn() async 
//   {
//     setState(() {
//       isLoading = true;
//     });

//     final GoogleSignIn googleSignIn = GoogleSignIn(
//       // Force the user to select an account every time
//       scopes: ['email'],
//       prompt: 'select_account',  // Ensure prompt for account selection
//     );

//     try {
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//       final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//       if (googleAuth == null) {
//         throw FirebaseAuthException(
//           code: 'ERROR_GOOGLE_AUTH_FAILED',
//           message: 'Google authentication failed',
//         );
//       }

//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar("Error msg", e.message ?? e.code);
//     } catch (e) {
//       Get.snackbar("Error msg", e.toString());
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<void> signIn() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email.text,
//         password: password.text,
//       );
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar("Error msg", e.message ?? e.code);
//     } catch (e) {
//       Get.snackbar("Error msg", e.toString());
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? Center(child: CircularProgressIndicator())
//         : Scaffold(
//             appBar: AppBar(
//               title: Text("LoginPage"),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: email,
//                     decoration: InputDecoration(hintText: "Enter Mail"),
//                   ),
//                   TextField(
//                     controller: password,
//                     decoration: InputDecoration(hintText: "Enter Password"),
//                     obscureText: true,
//                   ),
//                   ElevatedButton(
//                     onPressed: () => signIn(),
//                     child: Text("Login"),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => Get.to(signUp()),
//                     child: Text("SignUp"),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => Get.to(forgetPassword()),
//                     child: Text("Forget Password"),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => googleSignIn(),
//                     child: Text("Sign In with Google"),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }