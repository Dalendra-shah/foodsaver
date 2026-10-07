import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../widgets/admin_bottom_nav_bar.dart';
import 'admin_dashboard_page.dart';
import 'admin_reports_page.dart';
import 'admin_donations_page.dart';


class AdminUsersPage extends StatelessWidget {
  const AdminUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {'name': 'Dalendra Shah', 'email': 'dalendra@gmail.com', 'phone': '+977 9823456789', 'status': 'Active'},
      {'name': 'Mohammad Irsad Rain', 'email': 'alimdirshad487@gmail.com', 'phone': '+977 9822034486', 'status': 'Active'},
      {'name': 'Mehnaz Parween', 'email': 'mehnaz@gmail.com', 'phone': '+977 9814567890', 'status': 'Inactive'},
      {'name': 'Najmin Khatun', 'email': 'najmin@gmail.com', 'phone': '+977 9811122233', 'status': 'Blocked'},
      {'name': 'Rakesh Bhul', 'email': 'rakeshbhul@gmail.com', 'phone': '+977 9819968776', 'status': 'Active'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const Icon(Icons.menu, color: AppColors.textDark),
        title: Text(
          'Users',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications_none, color: AppColors.textDark),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Stat row
            Row(
              children: const [
                Expanded(child: _UserStat(icon: Icons.person, value: '245', label: 'Total Users', bg: Color(0xFFE3F2FD), fg: Colors.blue)),
                SizedBox(width: 10),
                Expanded(child: _UserStat(icon: Icons.person_add_alt, value: '85', label: 'Active Users', bg: Color(0xFFE8F5E9), fg: Colors.green)),
                SizedBox(width: 10),
                Expanded(child: _UserStat(icon: Icons.person_off, value: '32', label: 'Inactive Users', bg: Color(0xFFFFF3E0), fg: Colors.orange)),
                SizedBox(width: 10),
                Expanded(child: _UserStat(icon: Icons.block, value: '10', label: 'Blocked Users', bg: Color(0xFFFFEBEE), fg: Colors.red)),
              ],
            ),

            const SizedBox(height: 16),

           
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search users...',
                        hintStyle: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 14),
                        prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list, size: 18, color: AppColors.textDark),
                      const SizedBox(width: 6),
                      Text(
                        'Filter',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'All Users',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ),

            const SizedBox(height: 12),

            ...users.map((u) => _UserCard(
                  name: u['name']!,
                  email: u['email']!,
                  phone: u['phone']!,
                  status: u['status']!,
                )),
          ],
        ),
      ),
       bottomNavigationBar: AdminBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 2) return;
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AdminDashboardPage()),
            );
          }else if (index == 1) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const AdminDonationsPage()),
  );
} else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminReportsPage()),
            );
          }
        },
      ),
    );
  }
}
 
class _UserStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color bg;
  final Color fg;

  const _UserStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.bg,
    required this.fg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 18, color: fg),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String status;

  const _UserCard({
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor, textColor;
    if (status == 'Active') {
      bgColor = AppColors.acceptedBg;
      textColor = AppColors.acceptedText;
    } else if (status == 'Inactive') {
      bgColor = AppColors.inactiveBg;
      textColor = AppColors.inactiveText;
    } else {
      bgColor = AppColors.blockedBg;
      textColor = AppColors.blockedText;
    }

    final initials = name.split(' ').map((e) => e[0]).take(2).join();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.lightGreen,
            child: Text(
              initials,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreen,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  email,
                  style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textGrey),
                ),
                Text(
                  phone,
                  style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textGrey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.more_horiz, color: AppColors.textGrey, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}