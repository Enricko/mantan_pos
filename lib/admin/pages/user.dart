import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../widget/user/user_insert.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key,required this.role});
  final String role;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  DatabaseReference? db;

  var shim = true;
  var perPageSelected = 10;
  
  @override
  void initState() {
    print(FirebaseAuth.instance.currentUser!.email);
    db = FirebaseDatabase.instance.ref().child('user').child(widget.role);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FirebaseDatabaseQueryBuilder(
          query: db!,
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
                  child: TableMedia(data,db)
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
  PaginatedDataTable TableMedia(dynamic list, db) {
    return PaginatedDataTable(
      arrowHeadColor: Colors.black,
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Table User ${widget.role}"),
          InkWell(
            onTap: (){
              showDialog(
                context: context, 
                builder: (BuildContext context) { 
                  return UserInsert();
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
                "+ Tambah User",
                style: GoogleFonts.roboto(
                  color:Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14
                ),
              ),
            )
          ),
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
          label: Text('Name'),
        ),
        DataColumn(
          label: Text('Email'),
        ),
        DataColumn(
          label: Text('Role'),
        ),
        // DataColumn(
        //   label: Text('Action'),
        // ),
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
      DataCell(Text(val['name'])),
      DataCell(Text(val['email'])),
      DataCell(Text(val['role'])),
      // DataCell(
      //   Row(
      //     children: [
      //       Tooltip(
      //         message: "Update data",
      //         child: IconButton(
      //           icon: Icon(
      //             Icons.note_alt_outlined,
      //             color: Colors.yellow[900],
      //           ),
      //           onPressed: () {
      //             showDialog(
      //               context: context, 
      //               builder: (BuildContext context) { 
      //                 return UserUpdate(uid: uid,role:"admin");
      //               }, 
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   )
      // ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

}