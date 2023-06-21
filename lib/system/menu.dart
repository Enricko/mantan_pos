import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import "package:firebase_storage/firebase_storage.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Menu {
  static void tambahMenu(BuildContext context,Map<String,dynamic> data,Uint8List image,File file)async{
    try {
      var metadata = SettableMetadata(
        contentType: "image/jpeg",
      );
      var imagefile = FirebaseStorage.instance
          .ref()
          .child("menu")
          .child("${data['name']}-${DateTime.now()}.png");
        
      UploadTask task = imagefile.putData(image);
      if (!kIsWeb) {
        UploadTask task = imagefile.putFile(file!);
      }
      TaskSnapshot snapshot = await task;
      var url = await snapshot.ref.getDownloadURL();
      if (url != null) {
        Map<String, String> val = {
          'name': data['name'],
          "deskripsi" : data['deskripsi'],
          "harga" : data['harga'],
          "kategori" : data['kategori'],
          'image': url,
        };

        FirebaseDatabase.instance.ref().child("menu").push().set(val).whenComplete(() {
          EasyLoading.showSuccess('Menu telah di tambahkan',dismissOnTap: true);
          Navigator.pop(context);
          return;
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static void updateMenu(
    BuildContext context, 
    Map<String, dynamic> data, 
    Uint8List? image, 
    File? file,
    String? oldUrl, 
    bool old,
    String uid) async {
    try {
      var url;
      if (old == false) {
        var metadata = SettableMetadata(
          contentType: "image/jpeg",
        );
        var imagefile = FirebaseStorage.instance
            .ref()
            .child("menu")
            .child("${data['name']}-${DateTime.now()}.png");
          
        UploadTask task = imagefile.putData(image!);
        if (!kIsWeb) {
          UploadTask task = imagefile.putFile(file!);
        }
        TaskSnapshot snapshot = await task;
        url = await snapshot.ref.getDownloadURL();
        final del = FirebaseStorage.instance.refFromURL(oldUrl!);
        await del.delete();
      }
      if (oldUrl != null) {
        Map<String, dynamic> val = {
          'name': data['name'],
          "deskripsi" : data['deskripsi'],
          "harga" : int.parse(data['harga']),
          "kategori" : data['kategori'],
          'image': old == true ? oldUrl : url,
        };

        FirebaseDatabase.instance.ref().child("menu").child(uid).set(val);
        EasyLoading.showSuccess('Menu telah di ubah',dismissOnTap: true);
        Navigator.pop(context);
        return;
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}