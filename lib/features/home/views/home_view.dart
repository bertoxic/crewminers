// Example Screens
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minner/core/utils/responsive/responsive_sizes.dart';
import 'package:minner/features/home/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late HomeViewController viewController;
  @override
  void initState() {
    super.initState();
    // Create an AnimationController for continuous rotation.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
void didChangeDependencies() async{
    viewController = await HomeViewController.create(context: context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title:  const Text('Standing Fan Animation'), toolbarHeight: 30.h, titleSpacing: 30.h,),
      body: EventCard(),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 210.h,
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.only(top:10.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Colors.teal.shade200,
            // Colors.purple.shade100,
            Colors.grey.shade200,
            Colors.grey.shade200,
          ],
        ),
        borderRadius: BorderRadius.circular(16.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
           // offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        width: double.maxFinite,
        padding:  EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 140.w,
                  padding: EdgeInsets.all(10.w).copyWith(bottom: 0),
                  margin: EdgeInsets.all(10.w).copyWith(bottom: 0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffffbd36),
                        Colors.purple.shade300,

                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.sp),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Jun 9',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Wednesday',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '4 miners',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                 SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    _EventItem(
                      title: 'Total Online',
                      time: '12:00 - 13:30',
                      color: Colors.teal.shade300,
                    ),
                    SizedBox(height: 12.w),
                    _EventItem(
                      title: 'Total down',
                      time: '14:00 - 16:00',
                      color: Colors.red.shade300,
                      icon: Icons.arrow_downward,
                    ),
                  ]
                ),
              )
              ],
            ),
            _buildQuickStats()
          ],
        ),
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final String title;
  final String time;
  final Color color;
  final IconData? icon;

  const _EventItem({
    required this.title,
    required this.time,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.only(top: 2.sp,bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
           SizedBox(width: 12.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
                 SizedBox(height: 4.sp),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(left: 8.sp),
              child: Icon(
                icon,
                color: color.withOpacity(0.7),
                size: 20.sp,
              ),
            ),
        ],
      ),
    );
  }
}

Widget _buildQuickStats() {
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 1.w),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.sp), bottomRight: Radius.circular(8)
      ),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Power', '2.4 kW/h', Icons.electric_bolt),
           SizedBox(width: 2.w),
          _buildStatItem('Temp', '45°C', Icons.thermostat),
           SizedBox(width: 1.w),
          _buildStatItem('Eff', '92%', Icons.speed),
        ],
      ),
    ),
  );
}
Widget _buildStatItem(String label, String value, IconData icon) {
  return Column(
    children: [
      Row(
        children: [
    Text(
    label,
    style: GoogleFonts.poppins(
      fontSize: 11.sp,
      color: Colors.black54,
    ),),

        ],
      ),
       SizedBox(height: 2.h),
      Row(
        children: [
          Icon(icon, color: Colors.black54, size: 14.sp),
            SizedBox(width: 2.w,),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ],
  );
}