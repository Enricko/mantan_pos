import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mantan_pos/admin/home.dart';
import 'package:mantan_pos/firebase_options.dart';

// Import Pages
import 'admin/login.dart';
import 'pages/home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mantan POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      routes: {
        "/": (context) => HomePage(),

        // Admin
        "/login": (context) => Login(),
        "/admin": (context) => AdminHome(page:"dashboard"),

        // Admin User
        "/admin/user/admin": (context) => AdminHome(page:"user/admin"),
        "/admin/user/kasir": (context) => AdminHome(page:"user/kasir"),
        
        // Admin Menu
        "/admin/menu": (context) => AdminHome(page:"menu"),

        // Admin Meja
        "/admin/meja": (context) => AdminHome(page:"meja"),
      },
      initialRoute: '/admin',
    );
  }
}
