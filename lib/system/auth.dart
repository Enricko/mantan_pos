
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  
  static login(Map<String,dynamic> data,BuildContext context)async{
    try{
      var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password']
      );
      FirebaseDatabase.instance.ref().child("user").onValue.listen((event) async {
        var data = event.snapshot.value as Map;
        SharedPreferences pref = await SharedPreferences.getInstance();

        if (event.snapshot.child("admin").hasChild(user.user!.uid)) {
          pref.setString("role", "admin");
        }else if(event.snapshot.child("kasir").hasChild(user.user!.uid)){
          pref.setString("role", "kasir");
        }
      });
      
      EasyLoading.showSuccess('Welcome Back',dismissOnTap: true);
      Navigator.of(context).pushReplacementNamed("/admin");
    }on Exception catch (e){
      print(e);
      EasyLoading.showError('Email or Password incorrect',dismissOnTap: true);
    }
  }
  static registerUser(Map<String,dynamic> data,BuildContext context)async{
    try{
      FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
      // Insert User to FirebaseAuth
      var user = await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password']
      );
      // Insert User to database
      FirebaseDatabase.instance.ref().child("user").child(data['role']).child(user.user!.uid).set({
        "email": data['email'],
        "name": data['name'],
        "role": data['role'],
        "uid": data['uid'],
      });

      // Alert 
      EasyLoading.showSuccess('Tambah Akun Berhasil',dismissOnTap: true);
      Navigator.pop(context);
    }on Exception catch (e){
      print(e);
      EasyLoading.showError('Ada Sesuatu Kesalahan',dismissOnTap: true);
    }
  }

  static void logout(BuildContext context) async{
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).pushReplacementNamed("/login");
      });
      EasyLoading.showSuccess('You already logout',dismissOnTap: true);
      return;
      // enricko.putra028@gmail.com
    }else{
      await FirebaseAuth.instance.signOut();
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).pushReplacementNamed("/login");
      });
      EasyLoading.showSuccess('You have been logout',dismissOnTap: true);
      return;
    }
  }

  // static void updateUser(Map<String, dynamic> data, BuildContext context) async {
  //   try{
  //     // Insert User to FirebaseAuth
  //     EmailAuthProvider.credential(email: email, password: password).
  //     var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: data['email'],
  //       password: data['password']
  //     );
  //     // Insert User to database
  //     FirebaseDatabase.instance.ref().child("user").child(data['role']).child(user.user!.uid).set({
  //       "email": data['email'],
  //       "name": data['name'],
  //       "role": data['role'],
  //       "uid": data['uid'],
  //     });

  //     // Alert 
  //     EasyLoading.showSuccess('Tambah Akun Berhasil',dismissOnTap: true);
  //     Navigator.pop(context);
  //   }on Exception catch (e){
  //     print(e);
  //     EasyLoading.showError('Ada Sesuatu Kesalahan',dismissOnTap: true);
  //   }
  // }
}