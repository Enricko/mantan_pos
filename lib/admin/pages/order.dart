import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mantan_pos/admin/widget/order.dart';
import 'package:shimmer/shimmer.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  DatabaseReference db = FirebaseDatabase.instance.ref().child('orderan');

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
      dataRowMaxHeight: 100,
      arrowHeadColor: Colors.black,
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Table Orderan"),
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
          label: Text('Nama Customer'),
        ),
        DataColumn(
          label: Text('No Meja'),
        ),
        DataColumn(
          label: Text('Catatan'),
        ),
        DataColumn(
          label: Text('Status'),
        ),
        DataColumn(
          label: Text('Tgl Order'),
        ),
        DataColumn(
          label: Text('Total Harga'),
        ),
        DataColumn(
          label: Text('List Order'),
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
    final val = data[index].value as Map;
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(Text(val['name_customer'].toString())),
      DataCell(Text(val['no_meja'].toString())),
      DataCell(
        Container(
          constraints: BoxConstraints(
            minWidth: 50,
            maxWidth: 200,
          ),
          child: Text(
            val['catatan'].toString(),
            maxLines: 5,
          ),
        )
      ),
      DataCell(Text(val['status'].toString())),
      DataCell(Text(val['create_at'].toString())),
      DataCell(Text("Rp.${val['total_harga'].toString()}")),
      DataCell(
        InkWell(
          onTap: (){
            showDialog(
              context: context, 
              builder: (BuildContext context) { 
                return ListOrder(uid:uid);
              }, 
            );
          }, 
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF399D44),
            ),
            padding: EdgeInsets.all(3),
            alignment: Alignment.center,
            width: 110,
            height: 40,
            child: Text(
              "List Order",
              style: GoogleFonts.roboto(
                color:Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14
              ),
            ),
          )
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

}