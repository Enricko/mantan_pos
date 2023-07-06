import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Order {
  final String? namaCust;
  final String? noMeja;
  final Map<String, dynamic>? detailOrder;

  Order(this.namaCust, this.noMeja, this.detailOrder);
}

class LaporanPrint extends StatefulWidget {
  const LaporanPrint({super.key, required this.tanggal, required this.option});
  final String tanggal;
  final String option;

  @override
  State<LaporanPrint> createState() => _LaporanPrintState();
}

class _LaporanPrintState extends State<LaporanPrint> {
  String? title;
  int totalPemasukan = 0;
  Map<String, dynamic> data = {};

  titles() {
    if (widget.option == "harian") {
      title = "Tanggal : " +
          DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.tanggal));
    } else {
      title = "Bulan : " +
          DateFormat("MMMM").format(DateTime.parse(widget.tanggal));
    }
  }

  fetchData() {
    FirebaseDatabase.instance.ref().child("transaksi").onValue.listen((event) {
      var snapshot = event.snapshot.value as Map;
      // data[]
      for (var x in snapshot.entries) {
        Map<String, dynamic> detail = {};
        if (DateFormat("yyyy-MM-dd")
                .parse(x.value['create_at'])
                .isAtSameMomentAs(
                    DateFormat("yyyy-MM-dd").parse(widget.tanggal)) &&
            widget.option == "harian") {
          var order = x.value['list_order'] as Map;
          for (var y in order.entries) {
            detail[y.key] = {
              "faktur": y.key,
              "tanggal": x.value['create_at'],
              "menu_makanan": y.value['nama'],
              "qty": int.parse(y.value['qty']),
              "harga": int.parse(y.value['satuan']),
              "total_harga": int.parse(y.value['total_harga'])
            };
          }
          data[x.key] = {
            "nama_cust": x.value['name_customer'],
            "no_meja": x.value['no_meja'],
            "tanggal": x.value['create_at'],
            "total_harga": x.value['total_harga'],
            "detail_order": detail
          };
        }
        if (DateFormat("yyyy-MM").parse(x.value['create_at']).isAtSameMomentAs(
                DateFormat("yyyy-MM").parse(widget.tanggal)) &&
            widget.option == "bulanan") {
          var order = x.value['list_order'] as Map;
          for (var y in order.entries) {
            detail[y.key] = {
              "faktur": y.key,
              "tanggal": x.value['create_at'],
              "menu_makanan": y.value['nama'],
              "qty": int.parse(y.value['qty']),
              "harga": int.parse(y.value['satuan']),
              "total_harga": int.parse(y.value['total_harga'])
            };
          }
          data[x.key] = {
            "nama_cust": x.value['name_customer'],
            "no_meja": x.value['no_meja'],
            "tanggal": x.value['create_at'],
            "total_harga": x.value['total_harga'],
            "detail_order": detail
          };
        }
      }
    });
  }

  @override
  void initState() {
    titles();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Laporan Penjualan $title",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Color(0xFF399D44),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final currencyFormatter = NumberFormat('#,000', 'ID');
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    print(data);

    pdf.addPage(
      pw.MultiPage(build: (context) {
        return [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Kedai Mantan",
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "JL. Az-Zahra No. 7-10 (Sebelah Utara Gedung Serba Guna Azzahra),\nSuradadi, Jawa Tengah, Indonesia\n52184",
                style: pw.TextStyle(fontSize: 14),
              ),
            ],
          ),
          pw.SizedBox(height: 15),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text(
              "Laporan Penjualan $title",
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Divider(height: 5),
          for (var x in data.entries) PdfTable(x, currencyFormatter),
          pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                "Total Pemasukan ${currencyFormatter.format(totalPemasukan).toString()}",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              )),
          pw.Container(
            margin: pw.EdgeInsets.symmetric(vertical: 20),
            alignment: pw.Alignment.centerRight,
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                      "Suradadi Jawa Tengah, ${DateFormat('dd/MM/yyyy').format(DateTime.now())}"),
                  pw.Text("Penanggung Jawab"),
                  pw.SizedBox(height: 50),
                  pw.Text("Nama Penanggung Jawab"),
                ]),
          ),
        ];
      }),
    );
    return pdf.save();
  }

  pw.Container PdfTable(
      MapEntry<String, dynamic> x, NumberFormat currencyFormatter) {
    Map detail = x.value['detail_order'] as Map;
    int no = 1;
    setState(() {
      totalPemasukan += int.parse(x.value['total_harga'].toString());
    });
    return pw.Container(
      margin: pw.EdgeInsets.symmetric(vertical: 10),
      child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(
          "${x.value['nama_cust']}",
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          "${DateFormat("EEEE, dd-MM-yyyy hh:mm:ss").format(DateTime.parse(x.value['tanggal']))}",
          style: pw.TextStyle(fontSize: 12),
        ),
        pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: const <int, pw.TableColumnWidth>{
              0: pw.FixedColumnWidth(30),
              1: pw.FixedColumnWidth(100),
              2: pw.FixedColumnWidth(60),
              3: pw.FlexColumnWidth(),
              4: pw.FixedColumnWidth(35),
              5: pw.FlexColumnWidth(),
              6: pw.FlexColumnWidth(),
            },
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
            children: [
              pw.TableRow(
                children: [
                  pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.center,
                    color: PdfColor.fromInt(0xFF808080),
                    child: pw.Text('No',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.center,
                    color: PdfColor.fromInt(0xFF808080),
                    child: pw.Text('Faktur',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.center,
                    color: PdfColor.fromInt(0xFF808080),
                    child: pw.Text('Tanggal',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.center,
                    color: PdfColor.fromInt(0xFF808080),
                    child: pw.Text('Makanan',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.center,
                    color: PdfColor.fromInt(0xFF808080),
                    child: pw.Text('QTY',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.center,
                    color: PdfColor.fromInt(0xFF808080),
                    child: pw.Text('Harga',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.center,
                    color: PdfColor.fromInt(0xFF808080),
                    child: pw.Text('Jumlah',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                ],
              ),
              for (var y in detail.entries)
                pw.TableRow(
                  children: [
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      alignment: pw.Alignment.center,
                      child:
                          pw.Text('${no++}', style: pw.TextStyle(fontSize: 9)),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      alignment: pw.Alignment.center,
                      child: pw.Text('${y.value['faktur']}',
                          style: pw.TextStyle(fontSize: 9)),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                          '${DateFormat("dd/MM/yyyy").format(DateTime.parse(y.value['tanggal']))}',
                          style: pw.TextStyle(fontSize: 9)),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      alignment: pw.Alignment.center,
                      child: pw.Text('${y.value['menu_makanan']}',
                          style: pw.TextStyle(fontSize: 9)),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      alignment: pw.Alignment.center,
                      child: pw.Text('${y.value['qty']}',
                          style: pw.TextStyle(fontSize: 9)),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                          '${currencyFormatter.format(y.value['harga'])}',
                          style: pw.TextStyle(fontSize: 9)),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                          '${currencyFormatter.format(y.value['total_harga'])}',
                          style: pw.TextStyle(fontSize: 9)),
                    ),
                  ],
                ),
            ]),
        pw.Container(
            alignment: pw.Alignment.centerRight,
            child: pw.RichText(
                text: pw.TextSpan(children: [
              pw.TextSpan(
                  text: "Subtotal",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.WidgetSpan(child: pw.SizedBox(width: 25)),
              pw.TextSpan(
                  text:
                      "${currencyFormatter.format(x.value['total_harga']).toString()}",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ]))),
      ]),
    );
  }
}
