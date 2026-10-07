import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'donate_food_page.dart';
import 'receive_page.dart';
import 'profile_page.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'icon': Icons.attach_money,
        'text': 'Your donation request has been accepted.',
        'time': '10:30 AM',
      },
      {
        'icon': Icons.notifications_none,
        'text': 'New food donation near you.',
        'time': '1.20 PM',
      },
      {
        'icon': Icons.calendar_today_outlined,
        'text': 'Pickup reminder for your upcoming request',
        'time': '4:45 PM',
      },
      {
        'icon': Icons.check_circle_outline,
        'text': 'Your request has been completed. Thank You!',
        'time': 'Yesterday',
      },
      {
        'icon': Icons.notifications_none,
        'text': 'New food donation near you.',
        'time': 'Yesterday',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.more_vert, color: AppColors.textDark),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: notifications.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: AppColors.borderGrey),
        itemBuilder: (context, index) {
          final n = notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(n['icon'] as IconData,
                    color: AppColors.textDark, size: 24),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    n['text'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  n['time'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomePage()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const DonateFoodPage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ReceivePage()));
          } else if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfilePage()));
          }
        },
      ),
    );
  }
}
