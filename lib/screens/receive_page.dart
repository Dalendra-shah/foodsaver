// Author: Rakesh Bhul - Receive
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'donate_food_page.dart';
import 'profile_page.dart';
import 'food_details_page.dart';
import 'notifications_page.dart';

class ReceivePage extends StatelessWidget {
  const ReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===== Top Bar =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
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
            ),

            // ===== Scroll body =====
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Food',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Browse & request food near you',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.textGrey,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search available food...',
                          hintStyle: GoogleFonts.poppins(
                              color: AppColors.textGrey, fontSize: 14),
                          prefixIcon:
                              const Icon(Icons.search, color: AppColors.textDark),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Filters
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _chip('All', true),
                          const SizedBox(width: 8),
                          _chip('Meals', false),
                          const SizedBox(width: 8),
                          _chip('Fruits', false),
                          const SizedBox(width: 8),
                          _chip('Vegetables', false),
                          const SizedBox(width: 8),
                          _chip('Bakery', false),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Available Near You',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
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

                    const SizedBox(height: 14),

                    _FoodCard(
                      image: AppImages.biryani,
                      title: 'Sagar Restaurant',
                      foodName: 'Veg Biryani',
                      distance: '2.4 km away',
                      qty: '5 kg left',
                      time: 'Today 7:00 PM',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FoodDetailsPage()),
                      ),
                    ),

                    _FoodCard(
                      image: AppImages.pulao,
                      title: 'Hotel Green Park',
                      foodName: 'Veg Pulao',
                      distance: '1.8 km away',
                      qty: '3 kg left',
                      time: 'Today 6:00 PM',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FoodDetailsPage()),
                      ),
                    ),

                    _FoodCard(
                      image: AppImages.dalTadka,
                      title: 'Shree Restaurant',
                      foodName: 'Dal Tadka',
                      distance: '3.2 km away',
                      qty: '5 kg left',
                      time: 'Tomorrow 1:00 PM',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FoodDetailsPage()),
                      ),
                    ),

                    _FoodCard(
                      image: AppImages.mixVeg,
                      title: 'Food Corner',
                      foodName: 'Mix Veg',
                      distance: '4.1 km away',
                      qty: '4 kg left',
                      time: 'Yesterday 8:00 PM',
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 2) return;
          if (index == 0) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomePage()));
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const DonateFoodPage()));
          } else if (index == 3) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ProfilePage()));
          }
        },
      ),
    );
  }

  Widget _chip(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.primaryGreen : AppColors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: active ? AppColors.white : AppColors.textDark,
        ),
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  final String image;
  final String title;
  final String foodName;
  final String distance;
  final String qty;
  final String time;
  final VoidCallback onTap;

  const _FoodCard({
    required this.image,
    required this.title,
    required this.foodName,
    required this.distance,
    required this.qty,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
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
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      distance,
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: AppColors.textGrey),
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
                              fontSize: 11, color: AppColors.textDark),
                        ),
                        Text(
                          time,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
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