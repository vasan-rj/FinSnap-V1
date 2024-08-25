import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finsnap/screens/wrapper.dart';
import 'package:finsnap/screens/login.dart';
class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

    final emaiUser=FirebaseAuth.instance.currentUser;

  @override

  void initState()
  {
    // whenever the user enters the class the function under sendverifylink will be triggered!
    sendverifylink();
    super.initState();
  }

  sendverifylink()async
  {
    final user=FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification().then((value)=>{
      Get.snackbar('Link sent', 'A link has been send to your mail!',margin: const EdgeInsets.all(30),snackPosition: SnackPosition.BOTTOM)
    });
  }

  reload()async{
    await FirebaseAuth.instance.currentUser!.reload().then((value)=>{Get.offAll(const wrapper())});
  }
  // goHome()
  // {
  //   Get.offAll(wrapper());
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Emai-verification",
          ),
        ),
  
        body: Column(
          children: [
              const SizedBox(height:20),
              Image.asset('assets/email-verification.png'),
              const Center(
                child: Padding(
                padding: EdgeInsets.all(10.0),
                  child:Text("Check Your Mail ",style: TextStyle(color:Colors.grey,fontSize: 20,fontWeight: FontWeight.w300),), 
                  // ${emaiUser!.email} 
                ),
              ),
              Center(
                child: Padding(
                padding: const EdgeInsets.all(2.0),
                  child:Text("${emaiUser!.email}  ",style: const TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w500),), 
                  // ${emaiUser!.email} 
                ),
              ),
              const SizedBox(height: 25),

              Center(child: ElevatedButton(onPressed: (()=>reload()), child:const Text("Reload after Verifying Mail",style: TextStyle(color: Colors.white),
              ),
              )
              )

              
          ],
        ),
        floatingActionButton:FloatingActionButton(
          onPressed: (()=> Get.to(const Login())),
          backgroundColor:const Color.fromARGB(162, 5, 242, 155),
          child: const Icon(Icons.home_filled),
        )
        );
  }
}

