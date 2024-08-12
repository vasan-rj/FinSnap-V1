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

