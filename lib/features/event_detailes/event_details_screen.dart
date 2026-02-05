import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/features/home/add_event_screen.dart';
import 'package:evently/features/home/widgets/arrow_back_widget.dart';
import 'package:evently/features/home/widgets/event_img_widget.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key, required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<AppThemeProvider>();
    final eventProvider = context.watch<EventListProvider>();
    final isDark = themeProvider.isDarkMode();

    final updatedEvent = eventProvider.eventsList.firstWhere(
          (e) => e.id == event.id,
      orElse: () => event,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event details".tr(),
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.lightMainText,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        leading: ArrowBackIconWidget(isDark: isDark, isEditMode: false),
        actions: [
          /// Edit Button
          _buildActionButton(
            isDark: isDark,
            icon: Icons.edit_outlined,
            iconColor: isDark ? Colors.white : AppColors.lightPrimary,
            onTap: () async {
              final updated = await Navigator.push<EventModel>(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEventScreen(eventToEdit: updatedEvent),
                ),
              );

              // If user edited, update provider
              if (updated != null) {
                eventProvider.updateEvent(updated);
              }
            },
          ),
          SizedBox(width: 8.w),

          /// Delete Button
          _buildActionButton(
            isDark: isDark,
            icon: Icons.delete_outline,
            iconColor: Colors.red,
            onTap: () {
              eventProvider.deleteEvent(updatedEvent.id);
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Event Image
            EvenImageWidget(
              isDark: isDark,
              selectedEventImage: updatedEvent.eventImage,
            ),
            SizedBox(height: 16.h),

            /// Title
            Text(
              updatedEvent.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 9.h),

            /// Date & Time Card
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
                ),
                color: isDark ? AppColors.darkInput : Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkInput
                          : AppColors.lightPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
                      ),
                    ),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d MMMM').format(updatedEvent.date),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkPrimary : AppColors.lightMainText,
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(updatedEvent.date),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isDark ? AppColors.darkSecText : AppColors.lightDisabled,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            /// Description Section
            Text(
              "Description".tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.lightMainText,
              ),
            ),
            SizedBox(height: 9.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkInput : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
                  width: 1.0,
                ),
              ),
              child: Text(
                updatedEvent.description,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.5,
                  color: isDark ? AppColors.darkSecText : AppColors.lightMainText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: isDark ? AppColors.darkInput : Colors.white,
        border: Border.all(
          color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
        ),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Icon(icon, color: iconColor, size: 18.sp),
        onPressed: onTap,
      ),
    );
  }
}
