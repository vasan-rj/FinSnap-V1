import 'package:finsnap/data/roadmap_queston.dart';
import 'package:flutter/material.dart';
import 'package:finsnap/ai-model-config/road-map-model.dart';
import 'package:finsnap/data/health_score_quiz_question.dart';
import 'package:finsnap/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
      if (currentQuestionIndex < roadmapQuestions.length - 1) 
      {
        currentQuestionIndex++;
      } else 
      {
        if(userResponses.length>4)
        {
            _calculateFinancialHealthScore(userResponses);
        }
        else
        {
          Get.snackbar("Error", "You must select atleast 4 question..");
        }
        // All questions answered
        
        
      }
    });
  }

  void _showResults(
      dynamic score, dynamic recommendations, dynamic category_with_marks) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text("Financial Health Score")),
        content: Container(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: score * 0.01,
                  center: Text("${score}%"),
                  progressColor: Color.fromARGB(128, 5, 242, 155),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    "Finance Health Score:",
                    style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(210, 5, 242, 155),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " $score/100",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                "Category Marks:",
                style: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(210, 5, 242, 155),
                    fontWeight: FontWeight.bold),
              ),
              // Text(
              //   "Category Marks:",
              // ),
              SizedBox(height: 10.0),
              ...category_with_marks.entries.map((entry) {
                return Text(
                      "${entry.key} : ${entry.value} marks",
                    );
                
                
              }).toList(),
             SizedBox(height: 20.0),
              Column(
                children: [
                  Text(
                    "Recommendations: ",
                    style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(210, 5, 242, 155),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    "$recommendations",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              // Text("Recommendations: $recommendations"),
            ],
          ),
        ),
        actions: [
          // TextButton(
          //   onPressed: () => Navigator.of(context).pop(),
          //   child: Text("OK"),
          // ),

          Row(
            children: [
              TextButton(
                onPressed: () =>Get.to(IndexPage()),
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(164, 5, 242, 155),
                  // primary: Colors.white,  // Text color
                  minimumSize: Size(100, 40), // Width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child:Icon(Icons.home_filled),
              ),

              SizedBox(width: 20,),
              // 
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(164, 5, 242, 155),
                  // primary: Colors.white,  // Text color
                  minimumSize: Size(100, 40), // Width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text("OK"),
              ),
            ],
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

Future<void> _calculateFinancialHealthScore(Map<String, String> prompt) async {
  setState(() {
    isLoading = true;
  });

  try {
    print("Enter initialize Model...");
    final model = await initializeModel();
    print('After model initialization...');

    if (model != null) {
      List<dynamic> allPhases = [];
      bool morePhases = true;
      int phaseIndex = 1;

      while (morePhases) {
        String fullResponse = "";
        bool complete = false;

        while (!complete) {
          final content = [Content.text("${prompt.toString()} Phase $phaseIndex")];
          final response = await model.generateContent(content);
          final parsedResponse = jsonDecode(response.text.toString());

          print("Parsed response: $parsedResponse");

          if (parsedResponse['phases'] != null) {
            allPhases.add(parsedResponse['phases']);

            fullResponse += response.text.toString();
          }

          // Check for truncation and "MoreContent" flag
          if (response.text.toString().endsWith(",") || 
              response.text.toString().endsWith(" ")) {
            print("Response seems incomplete, requesting more content...");
            complete = false;
          } else {
            complete = true;
          }

          // Add to phases if full response
          if (fullResponse.isNotEmpty) {
            allPhases.add(parsedResponse['phases']);
          }

          // Check if there are more phases to fetch
          morePhases = parsedResponse['MoreContent'] == "True";
          if(parsedResponse['MoreContent'] == "True")
          {
            morePhases =true;
          }
          
           if (parsedResponse['MoreContent'] != "True") {
            morePhases = false;
          }
          phaseIndex++;
        }
      }

      // Combine and use allPhases for the complete roadmap
      print("All Phases: $allPhases");
      // _showResults(allPhases);
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });

    print("Error: $e");
    Get.snackbar("Error", "An unexpected error occurred. Please try again.");
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

// Future<void> _calculateFinancialHealthScore(
//     Map<String, String> prompt) async {

//   setState(() {
//     isLoading = true;
//   });

//   try {
//     print("Enter initialize Model...");
//     final model = await initializeModel();
//     print('After model initialization...');

//     if (model != null) {
//       List<dynamic> allPhases = [];
//       bool morePhases = true;
//       int phaseIndex = 1; // Start with phase 1

//       while (morePhases) {
//         final content = [
//           Content.text(
//               "${prompt.toString()} Phase $phaseIndex")
//         ];
        
//         final response = await model.generateContent(content);

//         try {
//           final parsedResponse = jsonDecode(response.text.toString());
//           print("Parsed response: $parsedResponse");

//           if (parsedResponse['phases'] != null) {
//             allPhases.add(parsedResponse['phases']); // Add the current phase
//           }

//           // Check if more phases are to be generated
//           morePhases = parsedResponse['MoreContent'] == "True";
//           phaseIndex++; // Increment phase index for the next API call

//         } catch (jsonError) {
//           print("JSON Parsing Error: $jsonError");
//           Get.snackbar("Error", "Failed to parse response. Please try again.");
//           morePhases = false; // Exit the loop if parsing fails
//         }
//       }

//       // Now `allPhases` contains all the phases combined from multiple responses
//       print("All Phases: $allPhases");

//       // Further processing of `allPhases`...
//       // For example, you can now show the full roadmap using _showResults()

//     }
//   } catch (e) {
//     setState(() {
//       isLoading = false;
//     });

//     print("Error: $e");
//     Get.snackbar("Error", "An unexpected error occurred. Please try again.");
//   } finally {
//     setState(() {
//       isLoading = false;
//     });
//   }
// }


  // Future<void> _calculateFinancialHealthScore(
  //     Map<String, String> prompt) async {
    
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     print("enter initialize Model......");
  //     final model = await initializeModel();
  //     print('after modle initialize......');

  //     if (model != null) {
  //       final content = [Content.text((prompt.toString()))];
  //       final response = await model.generateContent(content);

  //       final parsedResponse = jsonDecode(response.text.toString());
  //       // final responseType = parsedResponse['type'];
  //       // final responseContent = parsedResponse['content'];
  //       // // things inside content..
  //       // final finance_score = responseContent['finance-score'];
  //       // final category_marks = responseContent['category-marks'];

  //       // final recommendation_text = responseContent['recommendation'];
  //       // // recommendation:

  //       print("response from gemini.....");
  //       // print("Raw response text: ${response.text.toString()}");
  //       // print(responseType);
  //       // print(responseContent);
  //       // print(finance_score);
  //       // print(category_marks);
  //       // print(recommendation_text);
  //       print(parsedResponse);

  //       // setState(() {
  //       //   isLoading = false;
  //       //   _showResults(
  //       //       finance_score, recommendation_text.toString(), category_marks);
  //       // });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });

  //     print("error VVVVVV: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = roadmapQuestions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: SizedBox(
            child: Text('AI Financial Roadmap Generator',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(210, 5, 242, 155),
                ),),
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
