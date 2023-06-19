import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Meja {
  static tambahMeja(int total,BuildContext context) async {
    final db = FirebaseDatabase.instance.ref().child("meja");
    final key = db.push().key;
    db.child(key!).set({
      "no_meja": total.toString(),
    }).whenComplete(() {
      EasyLoading.showSuccess('Meja telah di tambahkan',dismissOnTap: true);
      return;
    });
  }

  static void hapusMeja(BuildContext context, key) {
    FirebaseDatabase.instance.ref().child("meja").child(key).remove();
    EasyLoading.showSuccess('Meja berhasil di hapus',dismissOnTap: true);
  }
}