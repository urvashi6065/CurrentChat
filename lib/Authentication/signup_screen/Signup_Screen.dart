import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Home/home_screen/Home_Screen.dart';
import '../login_screen/Login_Screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading=false;


  signupFunction() async {
    try {
      setState(() {
        isLoading=true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passController.text).then((value) async {

        //Data Add in Firebase
       await FirebaseFirestore.instance.collection('user').doc().set({
          'E-mail':value.user!.email,
          'password':passController.text,
          'uId':value.user!.uid
        });
  
        //Navigation in HomeScreen
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      });

    }  catch (e) {
      rethrow;
      // TODO
    }finally{
      setState(() {
        isLoading=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter E-mail";
                  }
                },
                decoration: InputDecoration(
                  hintText: "E-mail"
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: passController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter password";
                  }
                },
                decoration: InputDecoration(
                    hintText: "password"
                ),
              ),
              SizedBox(height: 20,),

              ElevatedButton(onPressed: (){
                signupFunction();
              }, child: (isLoading==false)?Text('Sign up'):CircularProgressIndicator()),
              SizedBox(height: 20,),

              TextButton(onPressed: (){
                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
              }, child: Text('Log in')),
            ],
          ),
        ),
      ),
    );
  }
}
