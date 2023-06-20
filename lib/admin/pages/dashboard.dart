import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          Responsive(
            children: [
              Div(
                divison: Division(
                  colXS: 12,
                  colS: 12,
                  colM: 6,
                  colL: 4,
                  colXL: 3,
                ),
                child: FirebaseDatabaseQueryBuilder(
                  query: FirebaseDatabase.instance.ref().child("menu"), 
                  builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) { 
                    return Container(
                      child: Card(
                        child: Row(
                          children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 15,top: 15,left: 15,right: 25),
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent
                            ),
                            child: Icon(
                              Icons.food_bank,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Menu',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "${snapshot.docs.length}",
                              ),
                            ],
                          )
                        ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Div(
                divison: Division(
                  colXS: 12,
                  colS: 12,
                  colM: 6,
                  colL: 4,
                  colXL: 3,
                ),
                child: FirebaseDatabaseQueryBuilder(
                  query: FirebaseDatabase.instance.ref().child("meja"), 
                  builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) { 
                    return Container(
                      child: Card(
                        child: Row(
                          children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 15,top: 15,left: 15,right: 25),
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.redAccent
                            ),
                            child: Icon(
                              Icons.table_bar,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Meja',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "${snapshot.docs.length}",
                              ),
                            ],
                          )
                        ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Div(
                divison: Division(
                  colXS: 12,
                  colS: 12,
                  colM: 6,
                  colL: 4,
                  colXL: 3,
                ),
                child: FirebaseDatabaseQueryBuilder(
                  query: FirebaseDatabase.instance.ref().child("user").child("kasir"), 
                  builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) { 
                    return Container(
                      child: Card(
                        child: Row(
                          children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 15,top: 15,left: 15,right: 25),
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent
                            ),
                            child: Icon(
                              Icons.people,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Kasir',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "${snapshot.docs.length}",
                              ),
                            ],
                          )
                        ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Div(
                divison: Division(
                  colXS: 12,
                  colS: 12,
                  colM: 6,
                  colL: 4,
                  colXL: 3,
                ),
                child: FirebaseDatabaseQueryBuilder(
                  query: FirebaseDatabase.instance.ref().child("user").child("admin"), 
                  builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) { 
                    return Container(
                      child: Card(
                        child: Row(
                          children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 15,top: 15,left: 15,right: 25),
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent
                            ),
                            child: Icon(
                              Icons.engineering,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Admin',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "${snapshot.docs.length}",
                              ),
                            ],
                          )
                        ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}