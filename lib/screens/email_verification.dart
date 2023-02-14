import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_project/screens/home_screens/widgets/routes.dart';

import 'login_page.dart';

class EmailVerification extends StatelessWidget {
  EmailVerification({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
          child: Column(
            children: [
            const Text('Thank you for signing in',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.teal
            ),),
            const SizedBox(height: 25,),
            const Text("We've sent you an email verification.Please verify your email address.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
              color: Colors.teal
            ),),
            const SizedBox(height: 25,),
            const Text("If you haven't recieved a verification email yet",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 109, 109, 109)),),

             const SizedBox(height: 25,),

            SizedBox(height: 55,width: 370,
                  child: ElevatedButton(onPressed: ()async{
                    final user = FirebaseAuth.instance.currentUser;
                    await user?.sendEmailVerification();
                  },
                  
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black),
                      
                    )),
                    elevation: const MaterialStatePropertyAll(20)
                  ), 
                  child: const Text('RESEND VERIFICATION EMAIL',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    
                  ),),)),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text("Already Verified?",style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 109, 109, 109)),),
              TextButton(onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
              }, 
              child: const Text('Login',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.teal),))
            ],)
          ],),
        ),
      ),
    );
  }
}