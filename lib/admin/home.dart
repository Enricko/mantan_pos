import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key,this.page = "dashboard"});
  final String page;

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final pages = <String,dynamic>{
    'dashboard' : Container(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 239, 239, 1),
        // automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
        )
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
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
                selectedColor: Color.fromARGB(255, 230, 230, 230),
                hoverColor: Color.fromARGB(255, 230, 230, 230),
                tileColor: widget.page.contains('dashboard') == true ? Color.fromARGB(255, 230, 230, 230) : null,
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
                          color: Colors.black
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/admin'),
              ),
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
              ListTile(
                selectedColor: Color.fromARGB(255, 230, 230, 230),
                hoverColor: Color.fromARGB(255, 230, 230, 230),
                tileColor: widget.page.contains('user') == true ? Color.fromARGB(255, 230, 230, 230) : null,
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
                          color: Colors.black
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}