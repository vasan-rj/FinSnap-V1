// import 'package:flutter/material.dart';

// class IndexPage extends StatefulWidget {
//   const IndexPage({super.key});

//   @override
//   State<IndexPage> createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Text("hi hello");
//   }
// }

import 'package:finsnap/screens/chatbot.dart';
import 'package:finsnap/screens/remainder.dart';
import 'package:finsnap/widgets/chatbot/chatbot-sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:finsnap/widgets/indexpage/index_ui_widgets.dart';

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
              BuildSearchbar(),
              SizedBox(height: 20),
              _buildSectionTitle('Favorites'),
              SizedBox(height: 8),
              _buildFavoriteIcons(),
              SizedBox(height: 16),
              _buildSectionTitle('AI Features ✨'),
              SizedBox(height: 16),
              _buildTransferOptions(),
              SizedBox(height: 16),
              _buildSectionTitle('Recent transfers'),
              SizedBox(height: 8),
              _buildRecentTransfers(),
              SizedBox(height: 16),
              _buildSectionTitle('Payment options'),
              SizedBox(height: 8),
              _buildPaymentOptions(),
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
                      Icon(option['icon'], color: const Color.fromARGB(210, 5, 242, 155)),
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

  Widget _buildRecentTransfers() {
    final List<Map<String, dynamic>> transfers = [
      {'name': 'Henry', 'image': 'assets/images/henry.png'},
      {'name': 'Lora', 'image': 'assets/images/lora.png'},
      {'name': 'John', 'image': 'assets/images/john.png'},
      {'name': 'Meg', 'image': 'assets/images/meg.png'},
      {'name': 'Lee', 'image': 'assets/images/lee.png'},
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
      {'icon': Icons.directions_bus, 'label': 'Transport'},
      {'icon': Icons.tv, 'label': 'Internet & TV'},
      {'icon': Icons.phone, 'label': 'Phone'},
      {'icon': Icons.games, 'label': 'Games'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        return Container(
          // width: MediaQuery.of(context).size.width / 2 - 24,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Icon(option['icon'], color: Colors.white),
              SizedBox(height: 8),
              Text(
                option['label'],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
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
