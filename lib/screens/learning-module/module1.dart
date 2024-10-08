import 'package:finsnap/data/module-one.dart';
import 'package:flutter/material.dart';

class module_one extends StatefulWidget {
  const module_one({super.key});

  @override
  State<module_one> createState() => _module_oneState();
}

class _module_oneState extends State<module_one> {
  int currentQuestionIndex = 0;
    // Map<String, String> userResponses = {};
    bool isLoading = false;

  // void _onOptionSelected(String option, String questions) {
  //   setState(() {
  //     userResponses[questions] = option;
  //     print(userResponses);
  //     if (currentQuestionIndex < quizQuestions.length - 1) {
  //       currentQuestionIndex++;
  //     } else {
  //       if (currentQuestionIndex == 7) {
  //         // _calculateFinancialHealthScore(userResponses);
  //         print("hello");
  //       } else {
  //         Get.snackbar("Error", "You must select atleast 10 question..");
  //       }
  //       // All questions answered
  //     }
  //   });
  //   }
    Future<void> goBack_func() async {
    if (currentQuestionIndex != 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  Future<void> goNext_func() async {
    if (currentQuestionIndex != quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
     final currentQuestion = quizQuestions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: SizedBox(
            child: Text('Finance Modules 🧾',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(210, 5, 242, 155),
                )),
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
                        currentQuestion["module"],
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Center(
                      child: Text(
                        currentQuestion["lesson"],
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(210, 5, 242, 155)),
                      ),
                    ),
                     SizedBox(height: 25.0),
                    Center(
                      child: Text(
                        currentQuestion["content"],
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,)
                      ),
                    ),
                    // SizedBox(height: 25.0),
                    // ...currentQuestion["options"].map<Widget>((option) {
                    //   return Container(
                    //     margin: EdgeInsets.symmetric(vertical: 8.0),
                    //     decoration: BoxDecoration(
                    //       color: Color.fromARGB(110, 66, 66, 66),
                    //       //  color: const  Color.fromARGB(210, 5, 242, 155),
                    //       borderRadius: BorderRadius.circular(20.0),
                    //       border: Border.all(
                    //         //  color: const  Color.fromARGB(210, 5, 242, 155),
                    //         color: const Color.fromARGB(78, 158, 158, 158),
                    //         // color: const Color.fromARGB(84, 158, 158, 158),
                    //         width: 1.0,
                    //       ),
                    //     ),
                    //     child: ListTile(
                    //       title: Center(
                    //           child: Text(
                    //         option,
                    //         style: TextStyle(
                    //           color: const Color.fromARGB(210, 5, 242, 155),
                    //         ),
                    //       )),
                    //       onTap: (){},
                    //       // onTap: () => _onOptionSelected(
                    //       //     option, currentQuestion["question"]),
                    //     ),
                    //   );
                    // }).toList(),
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

// class HealthScorePage extends StatefulWidget {
//   const HealthScorePage({super.key});

//   @override
//   State<HealthScorePage> createState() => _HealthScorePageState();
// }

// class _HealthScorePageState extends State<HealthScorePage> {
//   int currentQuestionIndex = 0;
//   Map<String, String> userResponses = {};
//   bool isLoading = false;

//   void _onOptionSelected(String option, String questions) {
//     setState(() {
//       userResponses[questions] = option;
//       print(userResponses);
//       if (currentQuestionIndex < quizQuestions.length - 1) {
//         currentQuestionIndex++;
//       } else 
//       {
//         if(userResponses.length>9)
//         {
//             _calculateFinancialHealthScore(userResponses);
//         }
//         else
//         {
//           Get.snackbar("Error", "You must select atleast 10 question..");
//         }
//         // All questions answered
        
        
//       }
//     });
//   }

//   void _showResults(
//       dynamic score, dynamic recommendations, dynamic category_with_marks) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Center(child: Text("Financial Health Score")),
//         content: Container(
//           width: double.maxFinite,
//           child: ListView(
//             shrinkWrap: true,
//             children: [
//               Center(
//                 child: CircularPercentIndicator(
//                   radius: 60.0,
//                   lineWidth: 10.0,
//                   percent: score * 0.01,
//                   center: Text("${score}%"),
//                   progressColor: Color.fromARGB(128, 5, 242, 155),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Row(
//                 children: [
//                   Text(
//                     "Finance Health Score:",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: const Color.fromARGB(210, 5, 242, 155),
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     " $score/100",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 "Category Marks:",
//                 style: TextStyle(
//                     fontSize: 15,
//                     color: const Color.fromARGB(210, 5, 242, 155),
//                     fontWeight: FontWeight.bold),
//               ),
//               // Text(
//               //   "Category Marks:",
//               // ),
//               SizedBox(height: 10.0),
//               ...category_with_marks.entries.map((entry) {
//                 return Text(
//                       "${entry.key} : ${entry.value} marks",
//                     );
                
                
//               }).toList(),
//              SizedBox(height: 20.0),
//               Column(
//                 children: [
//                   Text(
//                     "Recommendations: ",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: const Color.fromARGB(210, 5, 242, 155),
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 15,),
//                   Text(
//                     "$recommendations",
//                     style: TextStyle(fontSize: 15),
//                   ),
//                 ],
//               ),
//               // Text("Recommendations: $recommendations"),
//             ],
//           ),
//         ),
//         actions: [
//           // TextButton(
//           //   onPressed: () => Navigator.of(context).pop(),
//           //   child: Text("OK"),
//           // ),

//           Row(
//             children: [
//               TextButton(
//                 onPressed: () =>Get.to(IndexPage()),
//                 style: TextButton.styleFrom(
//                   backgroundColor: Color.fromARGB(164, 5, 242, 155),
//                   // primary: Colors.white,  // Text color
//                   minimumSize: Size(100, 40), // Width and height
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child:Icon(Icons.home_filled),
//               ),

//               SizedBox(width: 20,),
//               // 
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 style: TextButton.styleFrom(
//                   backgroundColor: Color.fromARGB(164, 5, 242, 155),
//                   // primary: Colors.white,  // Text color
//                   minimumSize: Size(100, 40), // Width and height
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: Text("OK"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> goBack_func() async {
//     if (currentQuestionIndex != 0) {
//       setState(() {
//         currentQuestionIndex--;
//       });
//     }
//   }

//   Future<void> goNext_func() async {
//     if (currentQuestionIndex != quizQuestions.length - 1) {
//       setState(() {
//         currentQuestionIndex++;
//       });
//     }
//   }

//   Future<void> _calculateFinancialHealthScore(
//       Map<String, String> prompt) async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final model = await initializeModel();

//       if (model != null) {
//         final content = [Content.text((prompt.toString()))];
//         final response = await model.generateContent(content);

//         final parsedResponse = jsonDecode(response.text.toString());
//         final responseType = parsedResponse['type'];
//         final responseContent = parsedResponse['content'];
//         // things inside content..
//         final finance_score = responseContent['finance-score'];
//         final category_marks = responseContent['category-marks'];

//         final recommendation_text = responseContent['recommendation'];
//         // recommendation:

//         print("response from gemini.....");
//         print("Raw response text: ${response.text.toString()}");
//         print(responseType);
//         print(responseContent);
//         print(finance_score);
//         print(category_marks);
//         print(recommendation_text);
//         print(parsedResponse);

//         setState(() {
//           isLoading = false;
//           _showResults(
//               finance_score, recommendation_text.toString(), category_marks);
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });

//       print("error inside _calculateFinancialHealthScore");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentQuestion = quizQuestions[currentQuestionIndex];
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: SizedBox(
//             child: Text('Finance Health Score',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: const Color.fromARGB(210, 5, 242, 155),
//                 )),
//           ),
//         ),
//         backgroundColor: Colors.black87,
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//                   color: Color.fromARGB(210, 5, 242, 155)),
//             )
//           : SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 16.0),
//                     Center(
//                       child: Text(
//                         currentQuestion["category"],
//                         style: TextStyle(
//                             fontSize: 18.0, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(height: 25.0),
//                     Center(
//                       child: Text(
//                         currentQuestion["question"],
//                         style: TextStyle(
//                             fontSize: 17.0,
//                             fontWeight: FontWeight.bold,
//                             color: const Color.fromARGB(210, 5, 242, 155)),
//                       ),
//                     ),
//                     SizedBox(height: 25.0),
//                     ...currentQuestion["options"].map<Widget>((option) {
//                       return Container(
//                         margin: EdgeInsets.symmetric(vertical: 8.0),
//                         decoration: BoxDecoration(
//                           color: Color.fromARGB(110, 66, 66, 66),
//                           //  color: const  Color.fromARGB(210, 5, 242, 155),
//                           borderRadius: BorderRadius.circular(20.0),
//                           border: Border.all(
//                             //  color: const  Color.fromARGB(210, 5, 242, 155),
//                             color: const Color.fromARGB(78, 158, 158, 158),
//                             // color: const Color.fromARGB(84, 158, 158, 158),
//                             width: 1.0,
//                           ),
//                         ),
//                         child: ListTile(
//                           title: Center(
//                               child: Text(
//                             option,
//                             style: TextStyle(
//                               color: const Color.fromARGB(210, 5, 242, 155),
//                             ),
//                           )),
//                           onTap: () => _onOptionSelected(
//                               option, currentQuestion["question"]),
//                         ),
//                       );
//                     }).toList(),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton(
//                             onPressed: goBack_func,
//                             child: Text(
//                               "Go Back",
//                               style: TextStyle(
//                                   color:
//                                       const Color.fromARGB(210, 5, 242, 155)),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           ElevatedButton(
//                               onPressed: goNext_func,
//                               child: Text(
//                                 "Go Next",
//                                 style: TextStyle(
//                                     color:
//                                         const Color.fromARGB(210, 5, 242, 155)),
//                               )),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
