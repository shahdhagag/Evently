import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/core/utiles/app_theme.dart';
import 'package:evently/features/home/add_event_screen.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.event});
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final eventProvider = Provider.of<EventListProvider>(context);

    return Slidable(
      key: const ValueKey('event_item'),

      ///  Left side actions (Edit)
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEventScreen(eventToEdit: event),
                ),
              );
            },
            backgroundColor: themeProvider.isDarkMode()?AppColors.darkPrimary:AppColors.lightPrimary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit'.tr(),
          ),
        ],
      ),

      ///  Right side actions (Delete)
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              context.read<EventListProvider>().deleteEvent(event.id);
            },
            backgroundColor:AppColors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete'.tr(),
          ),
        ],
      ),

      ///  Your original UI
      child: InkWell(
        onDoubleTap: (){
          context.push(
            AppRouts.eventDetailsScreen,
            extra: event,
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          height: 200.h,
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
              image: AssetImage(event.eventImage),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: AppColors.lightStroke, width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Date
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: themeProvider.isDarkMode()
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
                  border: Border.all(
                    color: themeProvider.isDarkMode()
                        ? AppColors.darkStroke
                        : AppColors.lightStroke,
                  ),
                ),
                child: Text(
                  DateFormat('d MMM').format(event.date),
                  style: themeProvider.isDarkMode()
                      ? AppTheme.darkTheme.textTheme.labelLarge
                      : AppTheme.lightTheme.textTheme.labelLarge,
                ),
              ),

              /// Title + Favorite
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: themeProvider.isDarkMode()
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
                  border: Border.all(
                    color: themeProvider.isDarkMode()
                        ? AppColors.darkStroke
                        : AppColors.lightStroke,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          overflow: TextOverflow.ellipsis,
                          style: themeProvider.isDarkMode()
                              ? AppTheme.darkTheme.textTheme.labelLarge
                              ?.copyWith(color: Colors.white)
                              : AppTheme.lightTheme.textTheme.labelLarge,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          event.isFavorite = !event.isFavorite;
                          eventProvider.updateEvent(event);
                          // TODO: Add to favorites
                        },
                        icon: Icon(
                          event.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: themeProvider.isDarkMode()
                              ? AppColors.darkPrimary
                              : AppColors.lightPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
