import 'package:d_chart/d_chart.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:mantan_pos/admin/widget/chart.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'package:date_field/date_field.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  SingleValueDropDownController typeFilter = SingleValueDropDownController();
  final intlFormat = intl.NumberFormat("#,##0.00");
  DateTime dateFilter = DateTime.now();
  String? filter;

  String currencyFormat(value){
    String val = "";
    if (value >= 1000000000) {
      val = "${intlFormat.format(value / 1000000000)} T";
    }else if(value >= 1000000){
      val = "${intlFormat.format(value / 1000000)} M";
    }else if(value >= 1000){
      val = "${intlFormat.format(value / 1000)} Jt";
    }else{
      val = "${intlFormat.format(value)} K";
    }
    return val;
  }
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
                  pageSize: 1000000,
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
                  pageSize: 1000000,
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
                  pageSize: 1000000,
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
                  pageSize: 1000000,
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
                          "Laporan Harian",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700
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
                              colL: 6,
                              colXL: 6
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                              child: DateTimeFormField(
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Select Date',
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 230, 230, 230),
                                ),
                                mode: DateTimeFieldPickerMode.date,
                                // autovalidateMode: AutovalidateMode.always,
                                // validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                                onDateSelected: (DateTime value) {
                                  setState(() {
                                    dateFilter = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Div(
                            divison: Division(
                              colXS: 12,
                              colS: 12,
                              colM: 6,
                              colL: 6,
                              colXL: 6,
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                              child: DropDownTextField(
                                controller: typeFilter,
                                dropDownList: [
                                  DropDownValueModel(name: 'Pendapatan', value: "pendapatan"),
                                  DropDownValueModel(name: 'Orderan', value: "orderan"),
                                ],
                                clearOption: false,
                                enableSearch: true,
                                textStyle: TextStyle(
                                  color: Colors.black
                                ),
                                searchDecoration: const InputDecoration(
                                    hintText: "enter your custom hint text here"),
                                validator: (value) {
                                  if (value == null) {
                                    return "Required field";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    filter = typeFilter.dropDownValue!.value;
                                  });
                                },
                                textFieldDecoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  border: OutlineInputBorder(
                                    borderSide:BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                                    borderRadius: BorderRadius.circular(10),
                    ),
                                  labelText: 'Type Laporan',
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 230, 230, 230),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Responsive(
                        children: [
                          Div(
                            divison: Division(
                              colXS: 12,
                              colS: 12,
                              colM: 12,
                              colL: 6,
                              colXL: 6,
                            ),
                            child: FirebaseDatabaseQueryBuilder(
                              pageSize: 1000000,
                              query: FirebaseDatabase.instance.ref().child("transaksi"), 
                              builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) { 
                                final data = snapshot.docs.where((data){
                                  final val = data.value as Map;
                                  var hari = DateTime.parse(val["create_at"].toString()).day;
                                  var bulan = DateTime.parse(val["create_at"].toString()).month;
                                  var tahun = DateTime.parse(val["create_at"].toString()).year;

                                  if (bulan == dateFilter.month && tahun == dateFilter.year) {
                                    return hari == dateFilter.day;
                                  }
                                  return false;

                                }).toList();

                                double total = 0;
                                for (var i = 0; i < data.length;i++) {
                                  final val = data[i].value as Map; 
                                  total += int.parse(val['total_harga'].toString()) / 1000;
                                }
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
                                          Icons.show_chart,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hari ini',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            filter == "orderan" ? "${data.length}" :
                                            "Rp.${currencyFormat(total)}",
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
                              colM: 12,
                              colL: 6,
                              colXL: 6,
                            ),
                            child: FirebaseDatabaseQueryBuilder(
                              pageSize: 1000000,
                              query: FirebaseDatabase.instance.ref().child("transaksi"), 
                              builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) { 
                                final data = snapshot.docs.where((data){
                                  final val = data.value as Map;
                                  var bulan = DateTime.parse(val["create_at"].toString()).month;
                                  var tahun = DateTime.parse(val["create_at"].toString()).year;
                                  if (tahun == dateFilter.year) {
                                    return bulan == dateFilter.month;
                                  }
                                  return false;
                                }).toList();

                                double total = 0;
                                for (var i = 0; i < data.length;i++) {
                                  final val = data[i].value as Map; 
                                  total += int.parse(val['total_harga'].toString()) / 1000;
                                }
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
                                          Icons.show_chart,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bulan ini',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            filter == "orderan" ? "${data.length}" :
                                            "Rp.${currencyFormat(total)}",
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
                              colM: 12,
                              colL: 6,
                              colXL: 6,
                            ),
                            child: FirebaseDatabaseQueryBuilder(
                              pageSize: 1000000,
                              query: FirebaseDatabase.instance.ref().child("transaksi"), 
                              builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) { 
                                final data = snapshot.docs.where((data){
                                  final val = data.value as Map;
                                  var tahun = DateTime.parse(val["create_at"].toString()).year;

                                  return tahun == dateFilter.year;
                                }).toList();

                                double total = 0;
                                for (var i = 0; i < data.length;i++) {
                                  final val = data[i].value as Map; 
                                  total += int.parse(val['total_harga'].toString()) / 1000;
                                }
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
                                          Icons.show_chart,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tahun ini',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            filter == "orderan" ? "${data.length}" :
                                            "Rp.${currencyFormat(total)}",
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
                  pageSize: 1000000,
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
                        var bulan = DateTime.parse(val["create_at"].toString()).month;
                        var tahun = DateTime.parse(val["create_at"].toString()).year;
                        if (tahun == dateFilter.year) {
                          double total = int.parse(val['total_harga'].toString()) / 1000;

                          chartData.update(bulan.toString(), (value) => 
                          filter == "orderan" ? "${int.parse(value) + 1}" :
                          (int.parse(value) + total).toString(),
                          ifAbsent: () => filter == "orderan" ? "${1}" : total.toString());
                        }
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
                                measureLabel: (value) => '${filter == "orderan" ? value :currencyFormat(value)}',
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