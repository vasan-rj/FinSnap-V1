import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finsnap/screens/chatbot.dart';
import 'package:finsnap/screens/login.dart';
import 'package:finsnap/screens/email-verify.dart';
// import 'package:finsnap/phone-verify.dart';

class wrapper extends StatefulWidget {
  const wrapper({super.key});

  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context,snapshot)
        {
          if(snapshot.hasData)
          {
            // return const Homepage();
            // print(snapshot.data);
            if(snapshot.data!.emailVerified)
            {
              // bool hasPhone =snapshot.data!.phoneNumber !=null;

                return const Homepage();
              
              // else
              // {
              //   return PhoneVerify();
              // }
              // return const Homepage();
             
            }
          
            else
            {
             return const Verify();
            }
          }
          else
          {
            return const Login();
          }
        })
    );
  }
}
