import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Struk extends StatefulWidget {
  const Struk({super.key, required this.uid});
  final String uid;

  @override
  State<Struk> createState() => _StrukState();
}

class _StrukState extends State<Struk> {
  Map<String, dynamic> data = {};
  int totalHarga = 0;
  int totalQty = 0;

  fetchData() {
    FirebaseDatabase.instance.ref().child("transaksi").onValue.listen((event) {
      var snapshot = event.snapshot.value as Map;
      // data[]
      for (var x in snapshot.entries) {
        if (x.key != widget.uid) {
          continue;
        }
        Map<String, dynamic> detail = {};
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
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Struk Orderan ${widget.uid}",
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
    final dataStruk = data.entries.first.value;
    Map detailOrder = dataStruk['detail_order'];

    pdf.addPage(pw.MultiPage(build: (context) {
      return [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Kedai Mantan",
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              "JL. Az-Zahra No. 7-10 (Sebelah Utara Gedung Serba Guna Azzahra),\nSuradadi, Jawa Tengah, Indonesia\n52184",
              style: pw.TextStyle(fontSize: 14),
            ),
          ],
        ),
        pw.SizedBox(height: 15),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Text(
            "${DateFormat("dd/MM/yyyy").format(DateTime.parse(dataStruk['tanggal']))}",
            style: pw.TextStyle(fontSize: 16),
          ),
          pw.Text(
            "${DateFormat("hh:mm:ss").format(DateTime.parse(dataStruk['tanggal']))}",
            style: pw.TextStyle(fontSize: 16),
          ),
        ]),
        pw.Divider(
          thickness: 3,
          color: PdfColors.black,
          height: 20,
        ),
        detailMenu(detailOrder.entries, currencyFormatter),
        pw.Divider(
          thickness: 3,
          color: PdfColors.black,
          height: 20,
        ),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Container(
            alignment: pw.Alignment.topCenter,
            child: pw.Text(
              "${totalQty} Item",
              style: pw.TextStyle(fontSize: 16),
            ),
          ),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            pw.RichText(
                text: pw.TextSpan(children: [
              pw.TextSpan(text: "Subtotal", style: pw.TextStyle(fontSize: 16)),
              pw.WidgetSpan(child: pw.SizedBox(width: 25)),
              pw.TextSpan(
                  text: "${currencyFormatter.format(totalHarga).toString()}",
                  style: pw.TextStyle(fontSize: 16)),
            ])),
            pw.RichText(
                text: pw.TextSpan(children: [
              pw.TextSpan(text: "TOTAL", style: pw.TextStyle(fontSize: 16)),
              pw.WidgetSpan(child: pw.SizedBox(width: 25)),
              pw.TextSpan(
                  text: "${currencyFormatter.format(totalHarga).toString()}",
                  style: pw.TextStyle(fontSize: 16)),
            ])),
            pw.RichText(
                text: pw.TextSpan(children: [
              pw.TextSpan(text: "TUNAI", style: pw.TextStyle(fontSize: 16)),
              pw.WidgetSpan(child: pw.SizedBox(width: 25)),
              pw.TextSpan(
                  text: "${currencyFormatter.format(totalHarga).toString()}",
                  style: pw.TextStyle(fontSize: 16)),
            ])),
          ])
        ]),
        pw.Divider(
          thickness: 3, // thickness of the line
          color: PdfColors.black, // The color to use when painting the line.
          height: 20, // The divider's height extent.
        ),
        pw.Center(child: 
        pw.Text(
          "Terima Kasih Atas Kunjungan Anda\nSilahkan Datang Kembali",
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        )
      ];
    }));
    return pdf.save();
  }

  pw.Column detailMenu(
      Iterable<MapEntry> entries, NumberFormat currencyFormatter) {
    for (var x in entries) {
      setState(() {
        totalHarga += int.parse(x.value['total_harga'].toString());
        totalQty += int.parse(x.value['qty'].toString());
      });
    }
    return pw.Column(children: [
      for (var x in entries)
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text(
            "${x.value['menu_makanan']}",
            style: pw.TextStyle(fontSize: 16),
          ),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "qty : ${x.value['qty']}",
                  style: pw.TextStyle(fontSize: 16),
                ),
                pw.Text(
                  "${currencyFormatter.format(x.value['harga'])}",
                  style: pw.TextStyle(fontSize: 16),
                ),
                pw.Text(
                  "${currencyFormatter.format(x.value['total_harga'])}",
                  style: pw.TextStyle(fontSize: 16),
                ),
              ]),
        ])
    ]);
  }
}
