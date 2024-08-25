import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F1F1F),
        title: Text('Payments'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: 16),
              _buildSectionTitle('Favorites'),
              SizedBox(height: 8),
              _buildFavoriteIcons(),
              SizedBox(height: 16),
              _buildSectionTitle('Transfer options'),
              SizedBox(height: 8),
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

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search ATMs, Payments, Fines',
        hintStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(Icons.search, color: Colors.white54),
        filled: true,
        fillColor: Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
      ),
      style: TextStyle(color: Colors.white),
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
      {'icon': Icons.credit_card, 'label': 'Card to card'},
      {'icon': Icons.account_balance_wallet, 'label': 'To account'},
      {'icon': Icons.account_balance, 'label': 'Bank to bank'},
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
                Icon(option['icon'], color: Colors.white),
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

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF1F1F1F),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message, color: Colors.white),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.white),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Color(0xFF05F29B),
      unselectedItemColor: Colors.white54,
    );
  }
}
