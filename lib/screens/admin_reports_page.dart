import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../widgets/admin_bottom_nav_bar.dart';
import 'admin_dashboard_page.dart';
import 'admin_donations_page.dart';
import 'admin_users_page.dart';

class AdminReportsPage extends StatelessWidget {
  const AdminReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const Icon(Icons.menu, color: AppColors.textDark),
        title: Text(
          'Reports',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Stat cards =====
            Row(
              children: const [
                Expanded(
                  child: _ReportStat(
                    value: '320',
                    label: 'Total Donations',
                    trend: '↑ 15% from last month',
                    trendColor: Colors.green,
                    icon: Icons.favorite_border,
                    iconColor: Colors.green,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _ReportStat(
                    value: '245',
                    label: 'People Helped',
                    trend: '↓ 90.5% from last month',
                    trendColor: Colors.red,
                    icon: Icons.person_outline,
                    iconColor: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: _ReportStat(
                    value: '620 kg',
                    label: 'Food Saved (kg)',
                    trend: '↑ 15.7% from last month',
                    trendColor: Colors.green,
                    icon: Icons.water_drop_outlined,
                    iconColor: Colors.blue,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _ReportStat(
                    value: '85',
                    label: 'Active Users',
                    trend: '↑ 8.2% from last month',
                    trendColor: Colors.green,
                    icon: Icons.person_add_alt,
                    iconColor: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ===== Chart card =====
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Donation Overview',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Last 6 Months',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Simple line chart mockup
                  SizedBox(
                    height: 160,
                    child: CustomPaint(
                      painter: _LineChartPainter(),
                      child: Container(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
                        .map((m) => Text(
                              m,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: AppColors.textGrey,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ===== Recent Reports header =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Reports',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  'View all',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            _ReportItem(
              title: 'Monthly Donation Report',
              date: 'June 2024',
              icon: Icons.description_outlined,
              iconBg: const Color(0xFFE8F5E9),
              iconColor: Colors.green,
            ),
            _ReportItem(
              title: 'User Activity Report',
              date: 'June 2024',
              icon: Icons.article_outlined,
              iconBg: const Color(0xFFE3F2FD),
              iconColor: Colors.blue,
            ),
            _ReportItem(
              title: 'Food Distribution Report',
              date: 'June 2024',
              icon: Icons.picture_as_pdf_outlined,
              iconBg: const Color(0xFFFFF3E0),
              iconColor: Colors.orange,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: AdminBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 3) return;
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AdminDashboardPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminDonationsPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminUsersPage()),
            );
          }
        },
      ),
    );
  }
}

// ================== Stat Card ==================
class _ReportStat extends StatelessWidget {
  final String value;
  final String label;
  final String trend;
  final Color trendColor;
  final IconData icon;
  final Color iconColor;

  const _ReportStat({
    required this.value,
    required this.label,
    required this.trend,
    required this.trendColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: AppColors.textGrey),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            trend,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: trendColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ================== Report Item ==================
class _ReportItem extends StatelessWidget {
  final String title;
  final String date;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  const _ReportItem({
    required this.title,
    required this.date,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 22, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: AppColors.textGrey),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.download,
                    size: 14, color: AppColors.primaryGreen),
                const SizedBox(width: 4),
                Text(
                  'Download',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================== Line Chart Painter ==================
class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.borderGrey.withOpacity(0.5)
      ..strokeWidth = 1;

    // Horizontal grid lines
    for (int i = 0; i <= 4; i++) {
      final y = (size.height / 4) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Data points (mock values)
    final points = [180.0, 200.0, 240.0, 280.0, 270.0, 310.0];
    final maxVal = 320.0;
    final stepX = size.width / (points.length - 1);

    final path = Path();
    final fillPath = Path();

    for (int i = 0; i < points.length; i++) {
      final x = stepX * i;
      final y = size.height - (points[i] / maxVal) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    // Fill area under line
    final fillPaint = Paint()
      ..color = AppColors.primaryGreen.withOpacity(0.15)
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    // Line
    final linePaint = Paint()
      ..color = AppColors.primaryGreen
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, linePaint);

    // Dots at each point
    final dotPaint = Paint()..color = AppColors.primaryGreen;
    for (int i = 0; i < points.length; i++) {
      final x = stepX * i;
      final y = size.height - (points[i] / maxVal) * size.height;
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
      canvas.drawCircle(Offset(x, y), 2, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
