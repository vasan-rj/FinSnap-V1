import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void _generatePdf_v(List<dynamic> phases) async {
  final pdf = pw.Document();

  // Helper function to create a page with content for up to 2 phases
  pw.Widget buildPage(List<dynamic> phases) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "AI Financial Roadmap",
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 20),
        ...phases.map((phase) {
          int index = phases.indexOf(phase) + 1; // 1-based index
          String phaseName = phase['phasename'] ?? 'Unnamed Phase';
          String duration = phase['duration'] ?? 'No Duration available';
          List<dynamic> topics = phase['topics'] ?? [];

          return pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Phase $index: $phaseName",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  "Duration: $duration",
                  style: pw.TextStyle(fontSize: 16),
                ),
                pw.SizedBox(height: 8),
                if (topics.isNotEmpty)
                  ...topics.map((topic) {
                    String? topicName = topic['topicname'];
                    List<dynamic> concepts = topic['concepts'] ?? [];

                    return pw.Padding(
                      padding: const pw.EdgeInsets.only(top: 12.0),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            topicName ?? "Unknown Topic",
                            style: pw.TextStyle(
                              fontSize: 16,
                              color: PdfColors.blueGrey,
                            ),
                          ),
                          pw.SizedBox(height: 6),
                          if (concepts.isNotEmpty)
                            ...concepts.map((concept) {
                              return pw.Padding(
                                padding: const pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
                                child: pw.Text(
                                  "- $concept",
                                  style: pw.TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    );
                  }).toList(),
                pw.Divider(),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  int currentIndex = 0;
  while (currentIndex < phases.length) {
    // Get the next 2 phases (or fewer if at the end of the list)
    List<dynamic> phasesForPage = phases.skip(currentIndex).take(2).toList();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return buildPage(phasesForPage);
        },
      ),
    );

    currentIndex += 2; // Move to the next set of 2 phases
  }

  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/finsnap_roadmap.pdf");
  await file.writeAsBytes(await pdf.save());

  // Open the PDF document in a PDF viewer or save it
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}




// void _generatePdf(List<dynamic> phases) async 
// {
//   final pdf = pw.Document();

//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text("AI Financial Roadmap", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 20),
//             ...phases.asMap().entries.map((entry) {
//               int index = entry.key;
//               var phase = entry.value[0];
//               return pw.Padding(
//                 padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text("Phase ${index + 1}: ${phase['phasename']}", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                     pw.SizedBox(height: 8),
//                     pw.Text(phase['description'], style: pw.TextStyle(fontSize: 16)),
//                     pw.Divider(),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ],
//         );
//       },
//     ),
//   );

//   final output = await getApplicationDocumentsDirectory();
//   final file = File("${output.path}/finsnap_roadmap.pdf");
//   await file.writeAsBytes(await pdf.save());

//   // Open the PDF document in a PDF viewer or save it
//   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
// }


// // 

// // 


// void _generatePdf(List<dynamic> phases) async {
//   final pdf = pw.Document();

//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text(
//               "AI Financial Roadmap",
//               style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
//             ),
//             pw.SizedBox(height: 20),
//             ...phases.asMap().entries.map((entry) {
//               int index = entry.key;
//               var phase = entry.value;

//               // Handling potential null values
//               String phaseName = phase != null && phase['phasename'] != null
//                   ? phase['phasename']
//                   : 'Unnamed Phase';

//               String duration = phase != null && phase['duration'] != null
//                   ? phase['duration']
//                   : 'No Duration available';

//               List<dynamic>? topics = phase != null && phase['topics'] != null
//                   ? phase['topics']
//                   : [];

//               return pw.Padding(
//                 padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       "Phase ${index + 1}: $phaseName",
//                       style: pw.TextStyle(
//                           fontSize: 18, fontWeight: pw.FontWeight.bold),
//                     ),
//                     pw.SizedBox(height: 8),
//                     pw.Text(
//                       "Duration: $duration",
//                       style: pw.TextStyle(fontSize: 16),
//                     ),
//                     pw.SizedBox(height: 8),
//                     if (topics != null && topics.isNotEmpty)
//                       ...topics.map((topic) {
//                         String? topicName = topic['topicname'] as String?;
//                         List<dynamic>? concepts = topic['concepts'] as List<dynamic>?;

//                         return pw.Padding(
//                           padding: const pw.EdgeInsets.only(top: 12.0),
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text(
//                                 topicName ?? "Unknown Topic",
//                                 style: pw.TextStyle(
//                                   fontSize: 16,
//                                   // fontWeight: pw.FontWeight.w600,
//                                   color: PdfColors.blueGrey,
//                                 ),
//                               ),
//                               pw.SizedBox(height: 6),
//                               if (concepts != null && concepts.isNotEmpty)
//                                 ...concepts.map((concept) {
//                                   return pw.Padding(
//                                     padding: const pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
//                                     child: pw.Text(
//                                       "- $concept",
//                                       style: pw.TextStyle(fontSize: 14),
//                                     ),
//                                   );
//                                 }).toList(),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     pw.Divider(),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ],
//         );
//       },
//     ),
//   );

//   final output = await getApplicationDocumentsDirectory();
//   final file = File("${output.path}/finsnap_roadmap.pdf");
//   await file.writeAsBytes(await pdf.save());

//   // Open the PDF document in a PDF viewer or save it
//   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
// }

// void _generatePdf(List<dynamic> phases) async {
//   final pdf = pw.Document();
//   const int itemsPerPage = 3; // Adjust this value based on your content size

//   // Helper function to add a page
//   void addPage(pw.Document pdf, List<dynamic> phases, int startIndex) {
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text(
//                 "AI Financial Roadmap",
//                 style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.SizedBox(height: 20),
//               ...phases.sublist(startIndex, startIndex + itemsPerPage).map((phase) {
//                 int index = phases.indexOf(phase);
//                 String phaseName = phase != null && phase['phasename'] != null
//                     ? phase['phasename']
//                     : 'Unnamed Phase';
//                 String duration = phase != null && phase['duration'] != null
//                     ? phase['duration']
//                     : 'No Duration available';
//                 List<dynamic>? topics = phase != null && phase['topics'] != null
//                     ? phase['topics']
//                     : [];

//                 return pw.Padding(
//                   padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
//                   child: pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text(
//                         "Phase ${index + 1}: $phaseName",
//                         style: pw.TextStyle(
//                             fontSize: 18, fontWeight: pw.FontWeight.bold),
//                       ),
//                       pw.SizedBox(height: 8),
//                       pw.Text(
//                         "Duration: $duration",
//                         style: pw.TextStyle(fontSize: 16),
//                       ),
//                       pw.SizedBox(height: 8),
//                       if (topics != null && topics.isNotEmpty)
//                         ...topics.map((topic) {
//                           String? topicName = topic['topicname'] as String?;
//                           List<dynamic>? concepts = topic['concepts'] as List<dynamic>?;

//                           return pw.Padding(
//                             padding: const pw.EdgeInsets.only(top: 12.0),
//                             child: pw.Column(
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 pw.Text(
//                                   topicName ?? "Unknown Topic",
//                                   style: pw.TextStyle(
//                                     fontSize: 16,
//                                     // fontWeight: pw.FontWeight.w600,
//                                     color: PdfColors.blueGrey,
//                                   ),
//                                 ),
//                                 pw.SizedBox(height: 6),
//                                 if (concepts != null && concepts.isNotEmpty)
//                                   ...concepts.map((concept) {
//                                     return pw.Padding(
//                                       padding: const pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
//                                       child: pw.Text(
//                                         "- $concept",
//                                         style: pw.TextStyle(fontSize: 14),
//                                       ),
//                                     );
//                                   }).toList(),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       pw.Divider(),
//                     ],
//                   ),
//                 );
//               }).toList(),
//               // Add a page break if there are more phases
//               if (startIndex + itemsPerPage < phases.length)
//                 pw.SizedBox(height: 20), // Optional: Add some space before new page
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Add pages with phases
//   for (int i = 0; i < phases.length; i += itemsPerPage) {
//     addPage(pdf, phases, i);
//   }

//   final output = await getApplicationDocumentsDirectory();
//   final file = File("${output.path}/finsnap_roadmap.pdf");
//   await file.writeAsBytes(await pdf.save());

//   // Open the PDF document in a PDF viewer or save it
//   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
// }


// multiple pages...

// void _generatePdfx(List<dynamic> phases) async {
//   final pdf = pw.Document();

//   // Helper function to create a page with content for up to 2 phases
//   pw.Widget buildPage(List<dynamic> phases) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text(
//           "AI Financial Roadmap",
//           style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 20),
//         ...phases.map((phase) {
//           int index = phases.indexOf(phase); // Adding 1 for 1-based index
//           String phaseName = phase != null && phase['phasename'] != null
//               ? phase['phasename']
//               : 'Unnamed Phase';
//           String duration = phase != null && phase['duration'] != null
//               ? phase['duration']
//               : 'No Duration available';
//           List<dynamic>? topics = phase != null && phase['topics'] != null
//               ? phase['topics']
//               : [];
//           print('\n\n\n\\n');
//           print("ohhh my godddd");
//           print(phase);
//           return pw.Padding(
//             padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text(
//                   // phases.toString(),
//                   "Phase $index: $phaseName",
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold),
//                 ),
//                 pw.SizedBox(height: 8),
//                 pw.Text(
//                   "Duration: $duration",
//                   style: pw.TextStyle(fontSize: 16),
//                 ),
//                 pw.SizedBox(height: 8),
//                 if (topics != null && topics.isNotEmpty)
//                   ...topics.map((topic) {
//                     String? topicName = topic['topicname'] as String?;
//                     List<dynamic>? concepts = topic['concepts'] as List<dynamic>?;

//                     return pw.Padding(
//                       padding: const pw.EdgeInsets.only(top: 12.0),
//                       child: pw.Column(
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Text(
//                             topicName ?? "Unknown Topic",
//                             style: pw.TextStyle(
//                               fontSize: 16,
//                               // fontWeight: pw.FontWeight.w600,
//                               color: PdfColors.blueGrey,
//                             ),
//                           ),
//                           pw.SizedBox(height: 6),
//                           if (concepts != null && concepts.isNotEmpty)
//                             ...concepts.map((concept) {
//                               return pw.Padding(
//                                 padding: const pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
//                                 child: pw.Text(
//                                   "- $concept",
//                                   style: pw.TextStyle(fontSize: 14),
//                                 ),
//                               );
//                             }).toList(),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 pw.Divider(),
//               ],
//             ),
//           );
//         }).toList(),
//       ],
//     );
//   }

//   int currentIndex = 0;
//   while (currentIndex < phases.length) {
//     // Get the next 2 phases (or fewer if at the end of the list)
//     List<dynamic> phasesForPage = phases.skip(currentIndex).take(2).toList();
//     print("\n\n\n\n\n");
//     print(phasesForPage);

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return buildPage(phasesForPage);
//         },
//       ),
//     );

//     currentIndex += 2; // Move to the next set of 2 phases
//   }

//   final output = await getApplicationDocumentsDirectory();
//   final file = File("${output.path}/finsnap_roadmap.pdf");
//   await file.writeAsBytes(await pdf.save());

//   // Open the PDF document in a PDF viewer or save it
//   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
// }

// void _generatePdf_v(List<dynamic> phases) async {
//   final pdf = pw.Document();

//   // Helper function to create a page with content for up to 2 phases
//   pw.Widget buildPage(List<dynamic> phases) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text(
//           "AI Financial Roadmap",
//           style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 20),
//         ...phases.map((phase) {
//           int index = phases.indexOf(phase) + 1; // 1-based index
//           String phaseName = phase['phasename'] ?? 'Unnamed Phase';
//           String duration = phase['duration'] ?? 'No Duration available';
//           List<dynamic> topics = phase['topics'] ?? [];

//           return pw.Padding(
//             padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text(
//                   "Phase $index: $phaseName",
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold),
//                 ),
//                 pw.SizedBox(height: 8),
//                 pw.Text(
//                   "Duration: $duration",
//                   style: pw.TextStyle(fontSize: 16),
//                 ),
//                 pw.SizedBox(height: 8),
//                 if (topics.isNotEmpty)
//                   ...topics.map((topic) {
//                     String? topicName = topic['topicname'];
//                     List<dynamic> concepts = topic['concepts'] ?? [];

//                     return pw.Padding(
//                       padding: const pw.EdgeInsets.only(top: 12.0),
//                       child: pw.Column(
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Text(
//                             topicName ?? "Unknown Topic",
//                             style: pw.TextStyle(
//                               fontSize: 16,
//                               color: PdfColors.blueGrey,
//                             ),
//                           ),
//                           pw.SizedBox(height: 6),
//                           if (concepts.isNotEmpty)
//                             ...concepts.map((concept) {
//                               return pw.Padding(
//                                 padding: const pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
//                                 child: pw.Text(
//                                   "- $concept",
//                                   style: pw.TextStyle(fontSize: 14),
//                                 ),
//                               );
//                             }).toList(),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 pw.Divider(),
//               ],
//             ),
//           );
//         }).toList(),
//       ],
//     );
//   }

//   int currentIndex = 0;
//   while (currentIndex < phases.length) {
//     // Get the next 2 phases (or fewer if at the end of the list)
//     List<dynamic> phasesForPage = phases.skip(currentIndex).take(2).toList();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return buildPage(phasesForPage);
//         },
//       ),
//     );

//     currentIndex += 2; // Move to the next set of 2 phases
//   }

//   final output = await getApplicationDocumentsDirectory();
//   final file = File("${output.path}/finsnap_roadmap.pdf");
//   await file.writeAsBytes(await pdf.save());

//   // Open the PDF document in a PDF viewer or save it
//   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
// }
