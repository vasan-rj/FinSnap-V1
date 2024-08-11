import 'package:finsnap/data/roadmap_queston.dart';
import 'package:finsnap/functions/roadmap-pdf.dart';
import 'package:flutter/material.dart';
import 'package:finsnap/ai-model-config/road-map-model.dart';
import 'package:finsnap/data/health_score_quiz_question.dart';
import 'package:finsnap/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RoadmapGeneratorClass extends StatefulWidget {
  const RoadmapGeneratorClass({super.key});

  @override
  State<RoadmapGeneratorClass> createState() => _RoadmapGeneratorClassState();
}

class _RoadmapGeneratorClassState extends State<RoadmapGeneratorClass> {
  int currentQuestionIndex = 0;
  Map<String, String> userResponses = {};
  bool isLoading = false;

  void _onOptionSelected(String option, String questions) {
    setState(() {
      userResponses[questions] = option;
      print(userResponses);
      if (currentQuestionIndex < roadmapQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        if (userResponses.length > 4) {
          _calculateFinancialHealthScore(userResponses);
        } else {
          Get.snackbar("Error", "You must select atleast 4 question..");
        }
        // All questions answered
      }
    });
  }

//   void _showResults(List<dynamic> phases) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Center(child: Text("AI Financial Roadmap")),
//       content: Container(
//         width: double.maxFinite,
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: phases.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Phase ${index + 1}: ${phases[index][0]['phasename']}",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: const Color.fromARGB(210, 5, 242, 155),
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     phases[index][0]['description'],
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Divider(color: Colors.grey),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {},
//           // onPressed: () => _generatePdf(phases), // Call the function to generate the PDF
//           style: TextButton.styleFrom(
//             backgroundColor: Color.fromARGB(164, 5, 242, 155),
//             minimumSize: Size(100, 40),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//           child: Text("Download PDF"),
//         ),
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           style: TextButton.styleFrom(
//             backgroundColor: Color.fromARGB(164, 5, 242, 155),
//             minimumSize: Size(100, 40),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//           child: Text("OK"),
//         ),
//       ],
//     ),
//   );
// }

  void _showResults(List<dynamic> phases) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text("AI Financial Roadmap")),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: phases.length,
            itemBuilder: (context, index) {
              var phase = phases[index][0];

              String? phaseName = phase['phasename'] as String?;
              String? duration = phase['duration'] as String?;
              List<dynamic>? topics = phase['topics'] as List<dynamic>?;
              // List<dynamic>? resource = phases[index]['resource'] as List<dynamic>?;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      phaseName ?? "Unknown Phase",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(210, 5, 242, 155),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Duration: ${duration ?? "Unknown"}",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    if (topics != null && topics.isNotEmpty)
                      ...topics.map((topic) {
                        String? topicName = topic['topicname'] as String?;
                        List<dynamic>? concepts =
                            topic['concepts'] as List<dynamic>?;
                        // List<dynamic>? resource =
                        //     topic['resource'] as List<dynamic>?;

                        return Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                topicName ?? "Unknown Topic",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              SizedBox(height: 6),
                              if (concepts != null && concepts.isNotEmpty)
                                ...concepts.map((concept) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, bottom: 4.0),
                                    child: Text(
                                      "- $concept",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                              SizedBox(height: 6),
                            ],
                          ),
                        );
                      }).toList(),

                    // if (resource != null && resource.isNotEmpty)
                    // ...resource.map((resource) {
                    //   return Padding(
                    //     padding: const EdgeInsets.only(top: 12.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           "Resource: ${resource['resourcename']}",
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w600,
                    //             color: Colors.blueGrey,
                    //           ),
                    //         ),
                    //         SizedBox(height: 6),
                    //       ],
                    //     ),
                    //   );
                    // }).toList(),

                    Divider(color: Colors.grey),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            // onPressed: () => _generatePdf(phases), // Call the function to generate the PDF
            onPressed: () async {
              // Navigator.of(context).pop();
              await generatePdf(phases); // Generate the PDF
            },
            style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(164, 5, 242, 155),
              minimumSize: Size(100, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text("Download PDF"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(164, 5, 242, 155),
              minimumSize: Size(100, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> goBack_func() async {
    if (currentQuestionIndex != 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  Future<void> goNext_func() async {
    if (currentQuestionIndex != roadmapQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  bool isDuplicate(String lastPhase, String currentPhase) {
    if (lastPhase == currentPhase) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _calculateFinancialHealthScore(
      Map<String, String> prompt) async {
    setState(() {
      isLoading = true;
    });

    try {
      print("Enter initialize Model...");
      final model = await initializeModel();
      print('After model initialization...');

      if (model != null) 
      {
        List<dynamic> allPhases = [];
        bool morePhases = true;
        int phaseIndex = 1;

        while (morePhases) 
        {
          // String fullResponse = "";
          bool complete = false;

          while (!complete) {
            final content = [
              Content.text("${prompt.toString()} Phase $phaseIndex")
            ];
            final response = await model.generateContent(content);
            final parsedResponse = jsonDecode(response.text.toString());

            print("Parsed response: $parsedResponse");

            int last_ind = allPhases.length;

            // dynamic lastresponse = allPhases[last_ind];
            // String last_response=lastresponse[0]['phasename'];
            // String current_response=parsedResponse['phases'][0]['phasename'];

            // for the very first response ..
            // Check if the first phase and add it if it's not a duplicate
            if (parsedResponse['phases'] != null) {
              if (allPhases.isEmpty) {
                allPhases.add(parsedResponse['phases']);
              } else if (parsedResponse['phases'] != null) {
                // Check for duplicates in the remaining phases
                dynamic lastresponse =
                    allPhases.last; // Safely access the last element
                String last_response = lastresponse[0]['phasename'];
                String current_response =
                    parsedResponse['phases'][0]['phasename'];
                // print ("vasan\n");
                // print("${last_response} , \n\n\n\n ${current_response}");
                if (!isDuplicate(last_response, current_response)) {
                  // print("print Priya.......");
                  // print(parsedResponse['phases']);
                  allPhases.add(parsedResponse['phases']);
                } else {
                  print("Duplicate Phase rejected..");
                  print("\n" * 10);
                }
              }
              ;

              // Check for truncation and "MoreContent" flag
              if (response.text.toString().endsWith(",") ||
                  response.text.toString().endsWith(" ")) {
                print("Response seems incomplete, requesting more content...");
                complete = false;
              } else {
                complete = true;
              }

              // Add to phases if full response
              // if (fullResponse.isNotEmpty) {
              //   allPhases.add(parsedResponse['phases']);
              // }

              // Check if there are more phases to fetch
              morePhases = parsedResponse['MoreContent'] == "True";
              if (!morePhases) {
                break;
              }
              setState(() {
                phaseIndex++;
              });
            }
          }

          // Combine and use allPhases for the complete roadmap
          // print("All Phases: $allPhases");
        }
        _showResults(allPhases);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        // _showResults(allPhases);
      });

      print("Error: $e");
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = roadmapQuestions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: SizedBox(
            child: Text(
              'AI Financial Roadmap Generator',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(210, 5, 242, 155),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(210, 5, 242, 155)),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.0),
                    Center(
                      child: Text(
                        currentQuestion["category"],
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Center(
                      child: Text(
                        currentQuestion["question"],
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(210, 5, 242, 155)),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    ...currentQuestion["options"].map<Widget>((option) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(110, 66, 66, 66),
                          //  color: const  Color.fromARGB(210, 5, 242, 155),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            //  color: const  Color.fromARGB(210, 5, 242, 155),
                            color: const Color.fromARGB(78, 158, 158, 158),
                            // color: const Color.fromARGB(84, 158, 158, 158),
                            width: 1.0,
                          ),
                        ),
                        child: ListTile(
                          title: Center(
                              child: Text(
                            option,
                            style: TextStyle(
                              color: const Color.fromARGB(210, 5, 242, 155),
                            ),
                          )),
                          onTap: () => _onOptionSelected(
                              option, currentQuestion["question"]),
                        ),
                      );
                    }).toList(),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: goBack_func,
                            child: Text(
                              "Go Back",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(210, 5, 242, 155)),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: goNext_func,
                              child: Text(
                                "Go Next",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(210, 5, 242, 155)),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
