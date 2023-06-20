import 'package:d_chart/d_chart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:mantan_pos/admin/widget/chart.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15,bottom:25),
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
          Responsive(
            children: [
              Div(
                divison: Division(
                  colXS: 12,
                  colS: 12,
                  colM: 6,
                  colL: 6,
                  colXL: 6
                ),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Laporan Transaksi",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Div(
                divison: Division(
                  colXS: 12,
                  colS: 12,
                  colM: 6,
                  colL: 6,
                  colXL: 6
                ),
                child: FirebaseDatabaseQueryBuilder(
                  query: FirebaseDatabase.instance.ref().child("transaksi"), 
                  builder:(context, snapshot, child) {
                    if (snapshot.hasData) {  
                      final data = snapshot.docs;
                      Map chartData = {
                        "1":"0",
                        "2":"0",
                        "3":"0",
                        "4":"0",
                        "5":"0",
                        "6":"0",
                        "7":"0",
                        "8":"0",
                        "9":"0",
                        "10":"0",
                        "11":"0",
                        "12":"0",
                      };
                      for (var i = 0; i < data.length;i++) {
                        final val = data[i].value as Map; 
                        var bulan = (DateFormat("M").format(DateTime.parse(val["create_at"].toString()))).toString();
                        double total = int.parse(val['total_harga'].toString()) / 1000;
                        // print(bulan);
                        chartData.update(bulan, (value) => 
                        (int.parse(value) + total).toString(),
                        ifAbsent: () => total.toString());
                      }
                      return Container(
                        constraints: BoxConstraints(
                          minWidth: 325,
                          maxWidth: 650,
                        ),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Laporan Bulanan",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: DChartTime(
                                chartRender: DRenderBar(),
                                measureLabel: (value) => '${value}k',
                                domainLabel: (dateTime) {
                                    // [DateFormat] from intl package
                                    return DateFormat('MMM').format(dateTime!);
                                },
                                domainTickLength: 5,
                                groupData: [
                                    DChartTimeGroup(
                                        id: 'Keyboard',
                                        color: Colors.blue,
                                        data: [
                                            DChartTimeData(time: DateTime(2023, 1), value: int.parse(chartData['1'].toString())),
                                            DChartTimeData(time: DateTime(2023, 2), value: int.parse(chartData['2'].toString())),
                                            DChartTimeData(time: DateTime(2023, 3), value: int.parse(chartData['3'].toString())),
                                            DChartTimeData(time: DateTime(2023, 4), value: int.parse(chartData['4'].toString())),
                                            DChartTimeData(time: DateTime(2023, 5), value: int.parse(chartData['5'].toString())),
                                            DChartTimeData(time: DateTime(2023, 6), value: int.parse(chartData['6'].toString())),
                                            DChartTimeData(time: DateTime(2023, 7), value: int.parse(chartData['7'].toString())),
                                            DChartTimeData(time: DateTime(2023, 8), value: int.parse(chartData['8'].toString())),
                                            DChartTimeData(time: DateTime(2023, 9), value: int.parse(chartData['9'].toString())),
                                            DChartTimeData(time: DateTime(2023, 10), value: int.parse(chartData['10'].toString())),
                                            DChartTimeData(time: DateTime(2023, 11), value: int.parse(chartData['11'].toString())),
                                            DChartTimeData(time: DateTime(2023, 12), value: int.parse(chartData['12'].toString())),
                                        ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
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