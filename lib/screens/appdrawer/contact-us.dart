import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(210, 5, 242, 155),
          ),
        ),
        backgroundColor: Color.fromARGB(158, 51, 51, 51),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Us Header
            Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Primary Color
              ),
            ),
            SizedBox(height: 8.0),
            _buildContactInfo(
              title: 'Email Us',
              contact: 'contact.finsnap@gmail.com',
              icon: Icons.email,
            ),
            SizedBox(height: 16.0),
            _buildContactInfo(
              title: 'Call Us',
              contact: '+91 8754837392',
              icon: Icons.phone,
            ),
            SizedBox(height: 16.0),
            _buildContactInfo(
              title: 'Visit Our Github Repository',
              contact: 'https://github.com/vasan-rj/FinSnap-V1',
              icon: Icons.code,
            ),
            SizedBox(height: 24.0),

            // Social Media Section
            Text(
              'Follow The Builder',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(210, 5, 242, 155), // Primary Color
              ),
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 16.0),
            _buildContactInfo(
              title: 'Vasan R',
              contact: 'Linkedin: https://www.linkedin.com/in/vasan-r/',
              icon: Icons.person,
            ),
            // _buildSocialMediaRow(),
          ],
        ),
      ),
    );
  }

  // Widget for Contact Information
  Widget _buildContactInfo({
    required String title,
    required String contact,
    required IconData icon,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color.fromARGB(210, 5, 242, 155), // Icon Color
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        subtitle: Text(
          contact,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Widget for Social Media Row
  Widget _buildSocialMediaRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialMediaIcon(icon: Icons.facebook, url: 'https://www.facebook.com/FinSnap'),
        _buildSocialMediaIcon(icon: Icons.hdr_on, url: 'https://www.twitter.com/FinSnap'),
        // _buildSocialMediaIcon(icon: Icons.linkedin, url: 'https://www.linkedin.com/company/finsnap'),
        // _buildSocialMediaIcon(icon: Icons.instagram, url: 'https://www.instagram.com/FinSnap'),
      ],
    );
  }

  // Widget for Social Media Icon
  Widget _buildSocialMediaIcon({required IconData icon, required String url}) {
    return GestureDetector(
      onTap: () {
        // Implement URL launch functionality here
      },
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(210, 5, 242, 155),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
