import 'package:chat/Home/home_screen/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading=false;

  loginFunction() async {
    setState(() {
      isLoading=true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      rethrow;
      // TO
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
        title: Text('Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter E-mail";
                  }
                },
                decoration: InputDecoration(hintText: "E-mail"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter password";
                  }
                },
                decoration: InputDecoration(hintText: "password"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    loginFunction();
                  },
                  child: (isLoading==false)?Text('Log in'):CircularProgressIndicator()),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
