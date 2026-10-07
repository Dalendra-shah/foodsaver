import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../widgets/bottom_nav_bar.dart';
import 'donate_food_page.dart';
import 'food_details_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'receive_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Top Bar =====
              Row(
                children: [
                  const Icon(Icons.menu, size: 28, color: AppColors.textDark),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NotificationsPage()),
                      );
                    },
                    child: const Icon(Icons.notifications_none,
                        size: 28, color: AppColors.textDark),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ===== Greeting =====
              RichText(
                text: TextSpan(
                  text: 'Hello, ',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  children: [
                    TextSpan(
                      text: 'Name',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== Search bar =====
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search food, restaurant...',
                    hintStyle: GoogleFonts.poppins(
                        color: AppColors.textGrey, fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: AppColors.textDark),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== Categories header =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    'View all',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ===== Categories =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _CategoryItem(emoji: '🍲', label: 'Meals'),
                  _CategoryItem(emoji: '🍎', label: 'Fruits'),
                  _CategoryItem(emoji: '🥦', label: 'Vegetables'),
                  _CategoryItem(emoji: '🥖', label: 'Bakery'),
                ],
              ),

              const SizedBox(height: 26),

              // ===== Nearby header =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nearby Donations',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    'View all',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ===== Nearby cards =====
              _NearbyCard(
                image: AppImages.biryani,
                title: 'Sagar Restaurant',
                distance: '2.4km away',
                foodName: 'Veg Biryani',
                qty: '5 kg left',
                time: 'Today 7:00 PM',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FoodDetailsPage()),
                ),
              ),

              const SizedBox(height: 14),

              _NearbyCard(
                image: AppImages.pulao,
                title: 'Hotel Green Park',
                distance: '1.8 km away',
                foodName: 'Veg Pulao',
                qty: '3 kg left',
                time: 'Today 6:00 PM',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FoodDetailsPage()),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) return;
          if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const DonateFoodPage()));
          } else if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ReceivePage()));
          } else if (index == 3) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ProfilePage()));
          }
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String emoji;
  final String label;

  const _CategoryItem({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(emoji, style: const TextStyle(fontSize: 32)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

class _NearbyCard extends StatelessWidget {
  final String image;
  final String title;
  final String distance;
  final String foodName;
  final String qty;
  final String time;
  final VoidCallback onTap;

  const _NearbyCard({
    required this.image,
    required this.title,
    required this.distance,
    required this.foodName,
    required this.qty,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
              child: Image.asset(
                image,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      distance,
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      foodName,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          qty,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: AppColors.textDark),
                        ),
                        Text(
                          time,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}