import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop3/core/services/repository_services/cache_service.dart';
import 'package:shop3/routes/app_router.dart';
import 'package:shop3/theme.dart';

final Color aColor = Colors.grey[800]!;

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.person, color: AppTheme.textColor200),
        ),
        title: Text('Profile', style: TextStyle(color: aColor)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const SizedBox(height: 20),
          // Profile Picture
          CircleAvatar(
            radius: 50,
            backgroundColor: aColor,
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),
          // User Info
          Text(
            'Esther Howard',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: aColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '@esther_howard',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: aColor),
          ),
          const SizedBox(height: 30),
          // Account Section Header
          Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: aColor,
            ),
          ),
          const SizedBox(height: 10),
          // Menu Items
          _buildProfileMenuItem(
            icon: Icons.person_outline,
            text: 'Your Profile',
          ),
          _buildProfileMenuItem(
            icon: Icons.payment_outlined,
            text: 'Payment Methods',
          ),
          _buildProfileMenuItem(
            icon: Icons.shopping_bag_outlined,
            text: 'My Orders',
          ),
          _buildProfileMenuItem(
            icon: Icons.settings_outlined,
            text: 'Settings',
          ),
          _buildProfileMenuItem(
            icon: Icons.help_center_outlined,
            text: 'Help Center',
          ),
          _buildProfileMenuItem(
            icon: Icons.privacy_tip_outlined,
            text: 'Privacy Policy',
          ),
          const SizedBox(height: 40),
          // Logout Button
          ElevatedButton(
            onPressed: () async {
              final cache = await CacheService.getInstance();
              var signout = await cache.remove('authToken');
              await cache.setBool('isLoggedIn', false);
              if (signout) {
                context.go(rootView);
              }
            },
            child: const Text(
              'Logout',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for profile menu items
  Widget _buildProfileMenuItem({required IconData icon, required String text}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: aColor),
      title: Text(text, style: TextStyle(color: aColor, fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, color: aColor, size: 16),
    );
  }
}
