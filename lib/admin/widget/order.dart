import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListOrder extends StatefulWidget {
  const ListOrder({super.key, required this.uid});
  final String uid;

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
                query: FirebaseDatabase.instance.ref().child("orderan").child(widget.uid).child("list_order"),
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
                            Text("Rp.${val['satuan']}")
                          ),
                          DataCell(
                            Text("${val['qty']}")
                          ),
                          DataCell(
                            Text("Rp.${val['total_harga']}")
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
                                    text: "Rp.${subTotal}",
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
              )
            ],
          ),
        );
      }),
    );
  }
}