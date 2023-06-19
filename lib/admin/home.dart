import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mantan_pos/admin/pages/menu.dart';
import 'package:mantan_pos/admin/pages/user.dart';
import 'package:mantan_pos/system/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key,this.page = "dashboard"});
  final String page;

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final pages = <String,dynamic>{
    'dashboard' : Container(),

    'user/admin' : UserPage(role:"admin"),
    'user/kasir' : UserPage(role:"kasir"),

    'menu' : MenuPage(),
  };
  String? role;

  checkUser()async{
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).pushReplacementNamed("/login");
      });
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      role = pref!.getString("role");
    });
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF399D44),
        // automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: pages[widget.page],
        )
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
               DrawerHeader(
                child: Image.asset(
                  'assets/images/logo_white.jpg',
                  width: 50,
                  height: 50,
                  colorBlendMode: BlendMode.srcOver,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,top: 15,bottom: 10),
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14
                  ),
                ),
              ),
              ListTile(
                selectedColor: Color(0xFF399D44),
                hoverColor: Color(0xFF399D44),
                tileColor: widget.page.contains('dashboard') == true ? Color(0xFF399D44) : null,
                title: Container(
                  child: Row(
                    children: [
                      Icon(Icons.speed,size: 16,color: Colors.black),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/admin'),
              ),
              role == "kasir" ? Container() :
              Container(
                padding: EdgeInsets.only(left: 15,top: 15,bottom: 10),
                child: Text(
                  "User",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14
                  ),
                ),
              ),
              role == "kasir" ? Container() :
              ListTile(
                selectedColor: Color(0xFF399D44),
                hoverColor: Color(0xFF399D44),
                tileColor: widget.page.contains('user/admin') == true ? Color(0xFF399D44) : null,
                title: Container(
                  child: Row(
                    children: [
                      Icon(Icons.engineering,size: 16,color: Colors.black),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'User Admin',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/admin/user/admin'),
              ),
              role == "kasir" ? Container() :
              ListTile(
                selectedColor: Color(0xFF399D44),
                hoverColor: Color(0xFF399D44),
                tileColor: widget.page.contains('user/kasir') == true ? Color(0xFF399D44) : null,
                title: Container(
                  child: Row(
                    children: [
                      Icon(Icons.person,size: 16,color: Colors.black),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'User Kasir',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/admin/user/kasir'),
              ),
              Container(
                padding: EdgeInsets.only(left: 15,top: 15,bottom: 10),
                child: Text(
                  "Menu",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14
                  ),
                ),
              ),
              ListTile(
                selectedColor: Color(0xFF399D44),
                hoverColor: Color(0xFF399D44),
                title: Container(
                  child: Row(
                    children: [
                      Icon(Icons.food_bank,size: 16,color: Colors.black),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/admin/menu'),
              ),
              Container(
                padding: EdgeInsets.only(left: 15,top: 15,bottom: 10),
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14
                  ),
                ),
              ),
              ListTile(
                selectedColor: Color(0xFF399D44),
                hoverColor: Color(0xFF399D44),
                title: Container(
                  child: Row(
                    children: [
                      Icon(Icons.power_settings_new,size: 16,color: Colors.black),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => _logout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content: const Text('Are you sure want to logout?'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                Auth.logout(context);
              },
              child: const Text('Yes')
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('No')
            )
          ],
        );
      }
    );
  }
}