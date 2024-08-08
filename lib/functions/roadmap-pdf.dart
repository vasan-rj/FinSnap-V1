import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw; 
import 'package:printing/printing.dart'; 
 
 Future<void> generateAndSavePDF() async {
    final image = await imageFromAssetBundle('assets/logos/school-logo.png'); // import 'package:printing/printing.dart'
    final doc = pw.Document(); // import 'package:pdf/widgets.dart' as pw
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          var widget;
          return pw.Padding( // recreate the entire UI
            padding: const pw.EdgeInsets.all(18.00),
            child: pw.Column(
              children: [
                pw.Align(
                  alignment: pw.Alignment.topCenter,
                  child: pw.Image(image, width: 100, height: 100), // our school logo for the official PDF
                ),
                pw.Text(
                  'Jackie & Co. Secondary School',
                  style: const pw.TextStyle(fontSize: 17.00),
                ),
                pw.SizedBox(height: 10.00),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Name: ${widget.studentName}',
                        style: const pw.TextStyle(fontSize: 15.00),
                      ),
                      pw.Text(
                        'Form 4 West',
                        style: const pw.TextStyle(fontSize: 15.00),
                      ),
                    ],
                  ),
                ),
                pw.Divider(),
                pw.SizedBox(height: 15.00),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Subject',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.SizedBox(height: 5.00),
                        pw.Text(
                          'Maths',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          'English',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          'Kiswahili',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          'Physics',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          'Biology',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          'Chemistry',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          'Geography',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          'Spanish',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Marks',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.SizedBox(height: 5.00),
                        pw.Text(
                          widget.studentResults['Maths'][0].toString(),
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['English'][0].toString(),
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Kiswahili'][0].toString(),
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Physics'][0].toString(),
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Biology'][0].toString(),
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Chemistry'][0].toString(),
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Geography'][0].toString(),
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Spanish'][0].toString(),
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Grade',
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.SizedBox(height: 5.00),
                        pw.Text(
                          widget.studentResults['Maths'][1],
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['English'][1],
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Kiswahili'][1],
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Physics'][1],
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Biology'][1],
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Chemistry'][1],
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Geography'][1],
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                        pw.Text(
                          widget.studentResults['Spanish'][1],
                          style: const pw.TextStyle(fontSize: 15.00),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 30.00),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      'Grand Total: ${widget.studentResults['Total'][0]}',
                    ),
                    pw.SizedBox(width: 15),
                    pw.Text(
                      'Mean Grade: ${widget.studentResults['Total'][1]}',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
  }