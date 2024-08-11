import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void _generatePdf(List<dynamic> phases) async 
{
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("AI Financial Roadmap", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            ...phases.asMap().entries.map((entry) {
              int index = entry.key;
              var phase = entry.value[0];
              return pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Phase ${index + 1}: ${phase['phasename']}", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 8),
                    pw.Text(phase['description'], style: pw.TextStyle(fontSize: 16)),
                    pw.Divider(),
                  ],
                ),
              );
            }).toList(),
          ],
        );
      },
    ),
  );

  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/finsnap_roadmap.pdf");
  await file.writeAsBytes(await pdf.save());

  // Open the PDF document in a PDF viewer or save it
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
