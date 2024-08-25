

import 'package:finsnap/screens/chatbot.dart';
import 'package:finsnap/screens/remainder.dart';
import 'package:finsnap/widgets/chatbot/chatbot-sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:finsnap/widgets/indexpage/index_ui_widgets.dart';

class IndexPage extends StatelessWidget {
  void _onItemTapped(int index) {
    _selectedIndex = index;

    if (_selectedIndex == 0) {
      Get.to(() => IndexPage());
    } else if (_selectedIndex == 1) {
      Get.to(() => const Homepage());
    } else if (_selectedIndex == 2) {
      Get.to(() => const RemainderPage());
    }
  }

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('AI Finance Assistant',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Custom Remainder',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Center(
          child: SizedBox(
            child: Text(' FinSnap 💸',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(210, 5, 242, 155),
                )),
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BuildSearchbar(),
              // Divider(),
              SizedBox(height: 10),
              _buildSectionTitle('Ai Features ✨'),
              SizedBox(height: 20),
              _buildTransferOptions(),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              _buildSectionTitle('Finance Modules 📈'),
              SizedBox(height: 10),
              _buildLearningModule(),

              // SizedBox(height: 20),
              SizedBox(height: 16),
              _buildSectionTitle('Custom Ai Bots 💳 '),
              SizedBox(height: 8),
              _buildPaymentOptions(),
              SizedBox(height: 20),

              //
              _buildSectionTitle('Talk to Finance Experts'),
              SizedBox(height: 8),
              _buildRecentTransfers(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildFavoriteIcons() {
    final List<Map<String, dynamic>> favorites = [
      {'icon': Icons.add, 'label': 'Add'},
      {'icon': Icons.videogame_asset, 'label': 'Games'},
      {'icon': Icons.receipt, 'label': 'Bills'},
      {'icon': Icons.phone, 'label': 'Phone'},
      {'icon': Icons.home_work_sharp, 'label': 'Charity'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: favorites.map((favorite) {
        return Column(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF2A2A2A),
              child: Icon(favorite['icon'], color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              favorite['label'],
              style: TextStyle(color: Colors.white),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTransferOptions() {
    final List<Map<String, dynamic>> options = [
      {
        'icon': Icons.credit_card,
        'label': 'AI Finance Score',
        'route': '/healthscore'
      },
      {
        'icon': Icons.account_balance_wallet,
        'label': 'AI Custom Roadmap',
        'route': '/roadmap'
      },
      // {
      //   'icon': Icons.person_4_outlined,
      //   'label': 'AI Finance Score',
      //   'route': '/healthscore'
      // },
      // {
      //   'icon': Icons.account_balance,
      //   'label': 'Bank to bank',
      //   'route': '/healthscore'
      // },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: options.map((option) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color.fromARGB(111, 5, 242, 155)),
              // border: Border.all(color:Color.fromARGB(148, 158, 158, 158)),
            ),
            child: Column(
              children: [
                // SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    print("clikeee");
                    Get.toNamed(option['route']);
                  },
                  child: Column(
                    children: [
                      Icon(option['icon'],
                          color: const Color.fromARGB(210, 5, 242, 155)),
                      SizedBox(height: 8),
                      Text(
                        option['label'],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLearningModule() {
    final List<Map<String, dynamic>> options = [
      //     - assets/module_1.png

      {
        'image': "./assets/Revenue.png", // Replace with actual asset path
        'lessons': 7,
        'label': 'Early Financial Independence',
        'route': '/module-one',
        'button': 'Start Module'
      },
      {
        'image': "./assets/module_1.png", // Replace with actual asset path
        'lessons': 14,
        'label': 'Mastering Stock Market',
        'route': '',
        'button': 'Coming Soon..'
      },
      {
        'image': "./assets/credit_card.png", // Replace with actual asset path
        'lessons': 6,
        'label': 'Secrets Of Tax Saving',
        'route': '',
        'button': 'Coming Soon..'
      },
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: options.map((option) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color.fromARGB(82, 5, 242, 155)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  option['image'],
                  height: 165.0,
                  // height: double.infinity,
                  width: double.infinity,
                  // fit: BoxFit.fill,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 10.0),

                Text(
                  option['label'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '${option['lessons']} Lessons',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
                // SizedBox(height: 4.0),
                SizedBox(height: 12.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print("clik module 1");
                      Get.toNamed(option['route']);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(210, 5, 242, 155),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(option['button']),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecentTransfers() {
    final List<Map<String, dynamic>> transfers = [
      {'name': 'John', 'image': 'assets/person1.jpg'},
      {'name': 'Lora', 'image': 'assets/person4.jpg'},
      {'name': 'Waren', 'image': 'assets/person2.jpg'},
      {'name': 'Smith', 'image': 'assets/person3.jpg'},
      {'name': 'Mary', 'image': 'assets/person5.jpg'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: transfers.map((transfer) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(transfer['image']),
                  radius: 30,
                  backgroundColor: Color(0xFF2A2A2A),
                ),
                SizedBox(height: 8),
                Text(
                  transfer['name'],
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    final List<Map<String, dynamic>> options = [
      {'icon': Icons.edit_document, 'label': 'Ai Tax Bot', 'route': '/taxbot'},
      {
        'icon': Icons.attach_money_outlined,
        'label': 'Ai Loan Bot',
        'route': '/loanbot'
      },
      {
        'icon': Icons.credit_score_sharp,
        'label': 'Ai Credit Bot',
        'route': '/creditbot'
      },
      // {'icon': Icons.games, 'label': 'Games'},
    ];

    return Wrap(
      spacing: 8,
      // runSpacing: 8,
      children: options.map((option) {
        return TextButton(
          onPressed: () {
            print("clikeee");
            Get.toNamed(option['route']);
          },
          child: Container(
            // width: MediaQuery.of(context).size.width / 2 - 24,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                // Icon(option['icon'], color:),
                Icon(option['icon'], color: Color.fromARGB(210, 5, 242, 155)),
                SizedBox(height: 8),
                Text(
                  option['label'],
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

//
//  bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.assistant), label: 'AI Assistant'),
//           BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Remainder'),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         backgroundColor: Colors.black87,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.grey,
//       ),

//
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF1F1F1F),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.assistant), label: 'AI Assistant'),
        BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Remainder'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      // backgroundColor: Colors.black87,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    );
  }
}
