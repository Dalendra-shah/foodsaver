import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../widgets/admin_bottom_nav_bar.dart';
import 'admin_dashboard_page.dart';
import 'admin_users_page.dart';
import 'admin_reports_page.dart';

class AdminDonationsPage extends StatefulWidget {
  const AdminDonationsPage({super.key});

  @override
  State<AdminDonationsPage> createState() => _AdminDonationsPageState();
}

class _AdminDonationsPageState extends State<AdminDonationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data — later you'll fetch this from backend
  final List<Map<String, dynamic>> _donations = [
    {
      'image': AppImages.biryani,
      'name': 'Sagar Restaurant',
      'food': 'Veg Biryani',
      'qty': '5 kg',
      'time': 'Today, 7:00 PM',
      'address': 'Sagar Restaurant, Main Street',
      'status': 'Pending',
    },
    {
      'image': AppImages.pulao,
      'name': 'Hotel Green Park',
      'food': 'Veg Pulao',
      'qty': '3 kg',
      'time': 'Today, 6:00 PM',
      'address': 'Hotel Green Park, MG Road',
      'status': 'Accepted',
    },
    {
      'image': AppImages.dalTadka,
      'name': 'Shree Restaurant',
      'food': 'Dal Tadka',
      'qty': '5 kg',
      'time': 'Tomorrow, 1:00 PM',
      'address': 'Shree Restaurant, Park Lane',
      'status': 'Pending',
    },
    {
      'image': AppImages.mixVeg,
      'name': 'Food Corner',
      'food': 'Mix Veg',
      'qty': '4 kg',
      'time': 'Yesterday, 8:00 PM',
      'address': 'Food Corner, Sector 5',
      'status': 'Completed',
    },
    {
      'image': AppImages.biryani,
      'name': 'Tasty Bites',
      'food': 'Chicken Biryani',
      'qty': '2 kg',
      'time': 'Today, 9:00 PM',
      'address': 'Tasty Bites, Downtown',
      'status': 'Rejected',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Filter donations by tab
  List<Map<String, dynamic>> _filtered(String filter) {
    if (filter == 'All') return _donations;
    return _donations.where((d) => d['status'] == filter).toList();
  }

  // ============== Action handlers ==============
  void _updateStatus(int originalIndex, String newStatus) {
    setState(() {
      _donations[originalIndex]['status'] = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Donation marked as $newStatus'),
        backgroundColor: AppColors.primaryGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDonationDetails(Map<String, dynamic> donation, int originalIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DonationDetailsSheet(
        donation: donation,
        onAccept: () {
          Navigator.pop(context);
          _updateStatus(originalIndex, 'Accepted');
        },
        onReject: () {
          Navigator.pop(context);
          _updateStatus(originalIndex, 'Rejected');
        },
        onComplete: () {
          Navigator.pop(context);
          _updateStatus(originalIndex, 'Completed');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const Icon(Icons.menu, color: AppColors.textDark),
        title: Text(
          'Donations',
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
            child: Icon(Icons.filter_list, color: AppColors.textDark),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryGreen,
          unselectedLabelColor: AppColors.textGrey,
          indicatorColor: AppColors.primaryGreen,
          labelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList('All'),
          _buildList('Pending'),
          _buildList('Completed'),
        ],
      ),
      bottomNavigationBar: AdminBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) return;
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AdminDashboardPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminUsersPage()),
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

  Widget _buildList(String filter) {
    final list = _filtered(filter);
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox_outlined,
                size: 64, color: AppColors.textGrey),
            const SizedBox(height: 12),
            Text(
              'No $filter donations',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final donation = list[index];
        final originalIndex = _donations.indexOf(donation);
        return _DonationAdminCard(
          donation: donation,
          onTap: () => _showDonationDetails(donation, originalIndex),
          onAccept: () => _updateStatus(originalIndex, 'Accepted'),
          onReject: () => _updateStatus(originalIndex, 'Rejected'),
          onComplete: () => _updateStatus(originalIndex, 'Completed'),
        );
      },
    );
  }
}

// ================= Donation Card =================
class _DonationAdminCard extends StatelessWidget {
  final Map<String, dynamic> donation;
  final VoidCallback onTap;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onComplete;

  const _DonationAdminCard({
    required this.donation,
    required this.onTap,
    required this.onAccept,
    required this.onReject,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final status = donation['status'] as String;
    Color bg, fg;
    if (status == 'Pending') {
      bg = AppColors.pendingBg;
      fg = AppColors.pendingText;
    } else if (status == 'Accepted') {
      bg = AppColors.acceptedBg;
      fg = AppColors.acceptedText;
    } else if (status == 'Completed') {
      bg = AppColors.lightGreen;
      fg = AppColors.primaryGreen;
    } else {
      bg = AppColors.blockedBg;
      fg = AppColors.blockedText;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    donation['image'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donation['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        donation['food'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${donation['qty']} • ${donation['time']}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: fg,
                    ),
                  ),
                ),
              ],
            ),

            // Action buttons — only for Pending donations
            if (status == 'Pending') ...[
              const SizedBox(height: 10),
              const Divider(height: 1, color: AppColors.borderGrey),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Reject',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Accept',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Complete button — only for Accepted donations
            if (status == 'Accepted') ...[
              const SizedBox(height: 10),
              const Divider(height: 1, color: AppColors.borderGrey),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onComplete,
                  icon: const Icon(Icons.check_circle_outline, size: 16),
                  label: Text(
                    'Mark as Completed',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ================= Detail Sheet =================
class _DonationDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> donation;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onComplete;

  const _DonationDetailsSheet({
    required this.donation,
    required this.onAccept,
    required this.onReject,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final status = donation['status'] as String;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                donation['image'],
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              donation['food'],
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              donation['name'],
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _row('Quantity', donation['qty']),
                  const SizedBox(height: 10),
                  _row('Available Until', donation['time']),
                  const SizedBox(height: 10),
                  _row('Pickup Address', donation['address']),
                  const SizedBox(height: 10),
                  _row('Status', status),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Action buttons
            if (status == 'Pending')
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Reject',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: AppColors.primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Accept',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else if (status == 'Accepted')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onComplete,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Mark as Completed',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'No actions available',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}
