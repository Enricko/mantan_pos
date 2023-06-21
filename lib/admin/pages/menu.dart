import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mantan_pos/admin/widget/menu/menu_update.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mantan_pos/admin/widget/menu/menu_insert.dart';
import 'package:intl/intl.dart' as intl;

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  SingleValueDropDownController categoryFilter = SingleValueDropDownController();
  DatabaseReference db = FirebaseDatabase.instance.ref().child('menu');
  String? filter;

  var shim = true;
  var perPageSelected = 10;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          child: DropDownTextField(
            controller: categoryFilter,
            dropDownList: [
              DropDownValueModel(name: 'Semua Menu', value: "all"),
              DropDownValueModel(name: 'Coffee', value: "coffee"),
              DropDownValueModel(name: 'Non Coffee', value: "non coffee"),
              DropDownValueModel(name: 'Noodle', value: "noodle"),
              DropDownValueModel(name: 'Snack', value: "snack"),
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
                filter = categoryFilter.dropDownValue!.value;
              });
              // SingleValueDropDownController(data: DropDownValueModel(value: "${data['role']}", name: "${data['role']}"))
            },
            textFieldDecoration: InputDecoration(
              hintText: "Pilih Ketegori Menu",
              labelText: "Pilih Ketegori Menu",
              hintStyle: TextStyle(
                color: Colors.black
              ),
              labelStyle: TextStyle(
                color: Colors.black
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.people),
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 230, 230, 230),
              prefixIconColor: Colors.black,
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        FirebaseDatabaseQueryBuilder(
          query: db,
          pageSize: 100000,
          builder: (context, snapshot, _) {
            if(snapshot.hasData){
              final data = snapshot.docs.where((data){
                final val = data.value as Map;
                if (filter == null || categoryFilter.dropDownValue!.value == "all") {
                  return true;
                }
                return val['kategori'] == filter;
              }).toList();
              
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
      dataRowMaxHeight: 150,
      arrowHeadColor: Colors.black,
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Table Menu"),
          InkWell(
            onTap: (){
              showDialog(
                context: context, 
                builder: (BuildContext context) { 
                  return MenuInsert();
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
                "+ Tambah Menu",
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
      columns: const <DataColumn>[
        DataColumn(
          label: Text('No'),
        ),
        DataColumn(
          label: Text('Image'),
        ),
        DataColumn(
          label: Text('Name'),
        ),
        DataColumn(
          label: Text('Deskripsi'),
        ),
        DataColumn(
          label: Text('Kategori'),
        ),
        DataColumn(
          label: Text('Harga'),
        ),
        DataColumn(
          label: Text('Action'),
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
      DataCell(
        Image.network(
          "${val['image']}",
          width: 100,
        )
      ),
      DataCell(Text(val['name'])),
      DataCell(
        Container(
          width: 250,
          child: Text(
            val['deskripsi'],
            maxLines: 5,
          ),
        )
      ),
      DataCell(Text(val['kategori'])),
      DataCell(Text("Rp.${intl.NumberFormat.decimalPattern().format(int.parse(val['harga']))}")),
      DataCell(
        Row(
          children: [
            Tooltip(
              message: "Update data",
              child: IconButton(
                icon: Icon(
                  Icons.note_alt_outlined,
                  color: Colors.yellow[900],
                ),
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) { 
                      return MenuUpdate(uid: uid);
                    }, 
                  );
                },
              ),
            ),
            Tooltip(
              message: "Delete data",
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[900],
                ),
                onPressed: () {
                  delete(context,uid,db,val['image']);
                },
              ),
            ),
          ],
        )
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  void delete(BuildContext context,String uid,DatabaseReference db_Ref,String image) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Tolong Konfirmasi'),
          content: const Text('Apakah anda yakin untuk menghapus data ini?'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                db_Ref.child(uid).remove();
                final del = FirebaseStorage.instance.refFromURL(image);
                del.delete().whenComplete((){
                  EasyLoading.showSuccess('Meja berhasil di hapus',dismissOnTap: true);
                });
                Navigator.pop(context);
              },
              child: const Text('Ya')
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.pop(context);
              },
              child: const Text('Tidak')
            )
          ],
        );
      }
    );
  }
}