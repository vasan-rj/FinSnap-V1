import 'package:finsnap/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
// import 'package:finsnap/wrapper.dart';
class otpPage extends StatefulWidget {
  final String verificationId;
  const otpPage({super.key, required this.verificationId});

  @override
  State<otpPage> createState() => _otpPageState();
}

class _otpPageState extends State<otpPage> {
  var code = '';

  signinOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, 
        smsCode: code);

    try{
      await FirebaseAuth.instance.signInWithCredential(credential).then((value)
      {
        Get.offAll(const wrapper());
      });
      }

    on FirebaseAuthException catch(e)
    {
      Get.snackbar("Error msg" ,e.code);
    }
    catch(e)
    {
      Get.snackbar("Error msg" ,e.toString());
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child:ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 50),
            const Center(child: Text("OTP Verification",style: TextStyle(fontSize: 30)),),
            const SizedBox(height: 10,),
            textcode(),
            const SizedBox(height: 10,),
            verifyotp()
        
          ],
        )
      ),
    );

  

  }
    Widget textcode()
    {
    return Center(
      child:Padding(
        padding:const EdgeInsets.all(6),
        child:Pinput(
          length: 6,
          onChanged: (value) 
          {
            setState(() {
              code = value;
            });
            
          },
        )
        ),
    );
    }

    Widget verifyotp()
    {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            signinOtp();
            
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Verify OTP"),
          ),
        ),
      );
    }
}


// Widget verifyotp()
// {
//   return Scaffold();
// }

// Widget textcode()
// {
//   return Center(
//     child:Padding(
//       padding:const EdgeInsets.all(6),
//       child:Pinput(
//         length: 6,
//         onChanged: (value) 
//         {
//           setState(() {
//             code = value;
//           });
          
//         },
//       )
//       ),
//   );
// }

