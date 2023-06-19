import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mantan_pos/system/meja.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';

class MejaPage extends StatefulWidget {
  const MejaPage({super.key});

  @override
  State<MejaPage> createState() => _MejaPageState();
}

class _MejaPageState extends State<MejaPage> {
  DatabaseReference db = FirebaseDatabase.instance.ref().child('meja');

  var shim = true;
  var perPageSelected = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FirebaseDatabaseQueryBuilder(
          query: db,
          pageSize: 100000,
          builder: (context, snapshot, _) {
            if(snapshot.hasData){
              var data = snapshot.docs;
              List<Widget> listWidget = [];
              return Theme(
                data: Theme.of(context).copyWith(
                  cardColor: Color.fromARGB(255, 54, 60, 66),
                  dividerColor: Color.fromARGB(137, 34, 34, 34),
                  textTheme: TextTheme(
                    titleLarge: TextStyle(color: Colors.black),
                    titleMedium: TextStyle(color: Colors.black),
                    titleSmall: TextStyle(color: Colors.black),
                    bodyLarge: TextStyle(color: Colors.black),
                    bodyMedium: TextStyle(color: Colors.black),
                    bodySmall: TextStyle(color: Colors.black),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: TableMedia(data,db,data.length)
                  )
                );
            }else{
              return Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.grey.shade100,
                enabled: shim,
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                ),
              );
            }
          }
        ),
      ],
    );
  }
  PaginatedDataTable TableMedia(List list, db,int total) {
    return PaginatedDataTable(
      dataRowMaxHeight: 150,
      arrowHeadColor: Colors.black,
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Table Meja"),
          Text("Total Meja (${total + 1})"),
          Row(
            children: [
              InkWell(
                onTap: (){
                  Meja.tambahMeja(total + 1,context);
                }, 
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF399D44),
                  ),
                  padding: EdgeInsets.all(3),
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  child: Text(
                    "+",
                    style: GoogleFonts.roboto(
                      color:Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: (){
                  if (total <= 0) {
                    EasyLoading.showError('Meja tidak dapat di hapus lagi',dismissOnTap: true);
                    return;
                  }
                  Meja.hapusMeja(context,list.last.key);
                }, 
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent,
                  ),
                  padding: EdgeInsets.all(3),
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  child: Text(
                    "-",
                    style: GoogleFonts.roboto(
                      color:Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14
                    ),
                  ),
                )
              ),
            ],
          )
        ],
      ),
      onRowsPerPageChanged: (perPage) {
        setState(() {
          perPageSelected = perPage!;
          // perPageSelectedOnChange = perPage;
        });
      },
      columnSpacing: 50,
      rowsPerPage: perPageSelected,
      columns: <DataColumn>[
        DataColumn(
          label: Text('No'),
        ),
        DataColumn(
          label: Text('QR Image'),
        ),
        DataColumn(
          label: Text('No Meja'),
        ),
      ],
      source: MyData(data: list,db:db,context: context),
    );
  }
}


class MyData extends DataTableSource {
  MyData({required this.data, required this.db,required this.context});
  final dynamic data;
  final dynamic db;
  final BuildContext context;
  
  @override
  DataRow? getRow(int index) {
    if(index >= data.length){
      return null;
    }
    final uid = data[index].key;
    final val = data[index].value as Map<String,dynamic>;
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(
        Image.network(
          "https://chart.apis.google.com/chart?cht=qr&chl=$uid&chs=125",
          width: 125,
        )
        // Text(""),
      ),
      DataCell(Text(val['no_meja'].toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

}