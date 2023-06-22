import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mantan_pos/system/transaksi.dart';
import 'package:intl/intl.dart' as intl;

class ListOrder extends StatefulWidget {
  const ListOrder({super.key, required this.uid,required this.type});
  final String uid;
  final String type;

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      scrollable: true,
      backgroundColor: Colors.transparent,
      content: Builder(builder: (context){
        return Container(
          padding: EdgeInsets.all(15),
          width: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Text(
                "List Order",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              FirebaseDatabaseQueryBuilder(
                query: FirebaseDatabase.instance.ref().child(widget.type).child(widget.uid).child("list_order"),
                builder: (context, snapshot, child) {
                  final data = snapshot.docs;
                  List<DataRow> rows = [];
                  int subTotal = 0;
                  for (var i = 0; i < data.length;i++) {
                    final val = data[i].value as Map<Object?,Object?>;  
                    val['key'] = data[i].key;
                    subTotal += int.parse(val['total_harga'].toString());
                    rows.add(
                      DataRow(
                        cells: [
                          DataCell(
                            Text("${i + 1}")
                          ),
                          DataCell(
                            Text("${val['nama']}")
                          ),
                          DataCell(
                            Text("Rp.${intl.NumberFormat.decimalPattern().format(int.parse(val['satuan'].toString()))}")
                          ),
                          DataCell(
                            Text("${val['qty']}")
                          ),
                          DataCell(
                            Text("Rp.${intl.NumberFormat.decimalPattern().format(int.parse(val['total_harga'].toString()))}")
                          ),
                        ]
                      )
                    );
                  }
                  return Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: TableBorder.all(width: 2,color: Colors.black),
                            columns: [
                              DataColumn(
                                label: Text(
                                  'No',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nama Menu',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Satuan',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'qty',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Sub Total',
                                ),
                              ),
                            ], 
                            rows: rows
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "SubTotal",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  WidgetSpan(child: SizedBox(width: 5,)),
                                  TextSpan(
                                    text: "Rp.${int.parse(subTotal.toString())}",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ]
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              widget.type == "transaksi" ? Container() :
              InkWell(
                onTap: (){
                  bayar(context,widget.uid);
                }, 
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF399D44),
                  ),
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  width: 350,
                  child: Text(
                    "Bayar",
                    style: GoogleFonts.roboto(
                      color:Colors.white,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                )
              ),
            ],
          ),
        );
      }),
    );
  }
  void bayar(BuildContext context,String uid) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Tolong Konfirmasi'),
          content: const Text('Apakah anda yakin?'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                Transaksi.bayar(context,uid);
                EasyLoading.show(status: 'loading...');
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