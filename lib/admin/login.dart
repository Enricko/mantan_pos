import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter_easyloading/flutter_easyloading.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool load = false;

  login(BuildContext context) async {
    try{
      var mail = email.text;
      var pass = password.text;

      // Check in input is null
      if(mail == '' || pass == ''){
        EasyLoading.showError('Please Input Email & Password',dismissOnTap: true);
        return;
      }
      setState(() {
        load = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: pass
      );
      EasyLoading.showSuccess('Welcome Back',dismissOnTap: true);
      Navigator.of(context).pushReplacementNamed("/admin");
    }on Exception catch (e){
      print(e);
      EasyLoading.showError('Email or Password incorrect',dismissOnTap: true);
    }
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.roboto(
                      color:Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      color: Colors.black
                    ),
                    decoration: InputDecoration(
                      hintText: "Your Email",
                      labelText: "Your Email",
                      hintStyle: TextStyle(
                        color: Colors.black
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.email),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 230, 230, 230),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: password,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black
                    ),
                    decoration: InputDecoration(
                      hintText: "Your Password",
                      labelText: "Your Password",
                      hintStyle: TextStyle(
                        color: Colors.black
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.password),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 230, 230, 230),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: (){
                      if (load != true) {
                        EasyLoading.show(status: 'loading...');
                        login(context);
                      }
                    }, 
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      width: 350,
                      child: Text(
                        "Login",
                        style: GoogleFonts.roboto(
                          color:Colors.white,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Text("Customer? Click Here"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}