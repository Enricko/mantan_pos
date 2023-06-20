import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transaksi {
  
  static void bayar(BuildContext context,String uid)async{

    DatabaseReference dbOrder = FirebaseDatabase.instance.ref().child("orderan").child(uid);
    DatabaseReference dbTransaksi = FirebaseDatabase.instance.ref().child("transaksi");
    DataSnapshot dataOrder = await dbOrder.get();
    final transaksiKey = dbTransaksi.push().key;
    SharedPreferences pref = await SharedPreferences.getInstance();
    
    Map order = dataOrder.value as Map;
    order.removeWhere((key, value) => key == ["status","create_at"]);
    final add = <String, String>{
      "nama_kasir": pref.getString("name_user").toString(),
      "status": "lunas",
      "create_at": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString(),
    };
    order.addAll(add);
    
    dbTransaksi.child(transaksiKey!).set(order);
    // dbOrder.remove();

    EasyLoading.showSuccess('Pembayaran telah berhasil',dismissOnTap: true);
    Navigator.pop(context);
  }

}