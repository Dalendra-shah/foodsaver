import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'donate_food_page.dart';
import 'receive_page.dart';
import 'my_donations_page.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Green header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              decoration: const BoxDecoration(
                color: AppColors.primaryGreen,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.settings, color: AppColors.white),
                      onPressed: () {},
                    ),
                  ),
                  const CircleAvatar(
                    radius: 46,
                    backgroundColor: AppColors.white,
                    child: Icon(Icons.person,
                        size: 55, color: AppColors.primaryGreen),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Nibesh Shah',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'nibeshshah@gmail.com',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _StatItem(value: '12', label: 'Donations'),
                  _StatItem(value: '24', label: 'Requests'),
                  _StatItem(value: '120', label: 'Points'),
                ],
              ),
            ),

            const Divider(height: 1),

            // Menu
            Expanded(
              child: ListView(
                children: [
                  _MenuItem(
                    emoji: '🥪',
                    title: 'My Donations',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MyDonationsPage()),
                    ),
                  ),
                  _MenuItem(emoji: '📦', title: 'My Requests', onTap: () {}),
                  _MenuItem(emoji: '🏅', title: 'Reward Points', onTap: () {}),
                  _MenuItem(emoji: '⚙️', title: 'Settings', onTap: () {}),
                  _MenuItem(
                    emoji: '↪️',
                    title: 'Logout',
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const LoginPage()), // ✅ Goes to Login
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 3) return;
          if (index == 0) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomePage()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const DonateFoodPage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ReceivePage()));
          }
        },
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryGreen,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String emoji;
  final String title;
  final VoidCallback onTap;
  const _MenuItem(
      {required this.emoji, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
