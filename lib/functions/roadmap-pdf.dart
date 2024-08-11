import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';


// void sharePdf(String filePath) {
//   Share.shareFiles([filePath], text: 'Here is your PDF!');
// }



Future<void> generatePdf(List<dynamic> phases) async {
  final pdf = pw.Document();

  try {
    pdf.addPage(
      pw.Page(
      
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Personalized Financial Roadmap',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              ...phases.map((phase) {
                if (phase is! Map) return pw.Container(); // Skip if not a Map
                
                final phaseName = phase['phasename'] ?? 'Unknown Phase';
                final duration = phase['duration'] ?? 'Unknown Duration';
                final topics = phase['topics'] ?? [];
                // final resources = phase['resource'] ?? [];

                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(phaseName, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Duration: $duration', style: pw.TextStyle(fontSize: 16)),
                    pw.SizedBox(height: 10),
                    pw.Text('Topics:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ...topics.map((topic) {
                      if (topic is! Map) return pw.Container(); // Skip if not a Map
                      
                      final topicName = topic['topicname'] ?? 'Unknown Topic';
                      final concepts = topic['concepts'] ?? [];

                      return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(topicName, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                          ...concepts.map((concept) => pw.Text('- $concept', style: pw.TextStyle(fontSize: 14))),
                        ],
                      );
                    }).toList(),
                    pw.SizedBox(height: 10),
                    // pw.Text('Resources:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    // ...resources.map((resource) => pw.Text(resource, style: pw.TextStyle(fontSize: 14))),
                    pw.SizedBox(height: 20),
                    pw.Divider(),
                  ],
                );
              }).toList(),
            ],
          );
        },
      ),
    );

    // Save PDF file
    final outputFile = await _getOutputFile();
    final file = File(outputFile.path);
    await file.writeAsBytes(await pdf.save());
    print("\n"*5);
    print('PDF saved to ${file.path}');
    print("\n"*5);
  } catch (e) {
    print("Error generating PDF: $e");
  }
}

Future<File> _getOutputFile() async {
  final directory = await getDownloadsDirectory();
  final file = File('${directory?.path}/finsnap_financial_roadmap.pdf');
  return file;
}

