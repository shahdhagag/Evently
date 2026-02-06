import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/shared/custom_button.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_dialogs.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/core/utiles/app_theme.dart';
import 'package:evently/features/home/widgets/arrow_back_widget.dart';
import 'package:evently/features/home/widgets/desc_text_form_field.dart';
import 'package:evently/features/home/widgets/event_img_widget.dart';
import 'package:evently/features/home/widgets/tab_category_widget.dart';
import 'package:evently/features/home/widgets/title_text_form_field.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key, this.eventToEdit});
  final EventModel? eventToEdit;

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

String convertToArabicNumbers(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], arabic[i]);
  }
  return input;
}

class _AddEventScreenState extends State<AddEventScreen> {
  bool get isEditMode => widget.eventToEdit != null;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> eventImagesListLight = [
    AppAssets.sports,
    AppAssets.birthday,
    AppAssets.meeting,
    AppAssets.gaming,
    AppAssets.workshop,
    AppAssets.bookClub,
    AppAssets.exhibition,
    AppAssets.holiday,
    AppAssets.eating,
  ];

  final List<String> eventImagesListDark = [
    AppAssets.sportsDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.gamingDark,
    AppAssets.workshopDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
    AppAssets.holidayDark,
    AppAssets.eatingDark,
  ];

  String selectedEventImage = '';
  String selectedEventsName = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String formattedTime = '';
  String formattedDate = '';

  int selectedIndex = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (isEditMode) {
      final event = widget.eventToEdit!;
      titleController.text = event.title;
      descController.text = event.description;

      selectedDate = event.date;
      formattedDate = DateFormat('MMMM dd, yyyy', 'en').format(event.date);

      // Store in English internally
      formattedTime = event.time;
      selectedTime = _parseTime(event.time);

      final eventNamesList = [
        'Sports'.tr(),
        'Birthday'.tr(),
        'Meeting'.tr(),
        'Gaming'.tr(),
        'Workshop'.tr(),
        'Book Club'.tr(),
        'Exhibition'.tr(),
        'Holiday'.tr(),
        'Eating'.tr(),
      ];

      selectedIndex = eventNamesList.indexOf(event.eventName);
      if (selectedIndex == -1) selectedIndex = 0;
    }
  }

  TimeOfDay _parseTime(String time) {
    //  Convert Arabic numbers back to English before parsing to avoid FormatException
    String englishTime = time
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');

    try {
      //  Parse using the English locale
      final format = DateFormat.jm('en_US');
      final dateTime = format.parse(englishTime);
      return TimeOfDay.fromDateTime(dateTime);
    } catch (e) {
      debugPrint("Time parsing error: $e");
      return TimeOfDay.now();
    }
  }
  String getEnglishEventName(String translatedName) {
    final englishKeys = [
      'Sports',
      'Birthday',
      'Meeting',
      'Gaming',
      'Workshop',
      'Book Club',
      'Exhibition',
      'Holiday',
      'Eating',
    ];

    final translatedList = englishKeys.map((e) => e.tr()).toList();

    final index = translatedList.indexOf(translatedName);
    if (index != -1) return englishKeys[index];
    return englishKeys[0];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<AppThemeProvider>();
    final isDark = themeProvider.isDarkMode();

    final eventNamesList = [
      'Sports'.tr(),
      'Birthday'.tr(),
      'Meeting'.tr(),
      'Gaming'.tr(),
      'Workshop'.tr(),
      'Book Club'.tr(),
      'Exhibition'.tr(),
      'Holiday'.tr(),
      'Eating'.tr(),
    ];

    selectedEventImage = isDark
        ? eventImagesListDark[selectedIndex]
        : eventImagesListLight[selectedIndex];
    selectedEventsName = eventNamesList[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        leading: ArrowBackIconWidget(isDark: isDark, isEditMode: isEditMode),
        title: Text(
          isEditMode ? 'Edit Event'.tr() : 'Add Event'.tr(),
          style: (isDark
              ? AppTheme.darkTheme.textTheme.titleMedium
              : AppTheme.lightTheme.textTheme.titleMedium)
              ?.copyWith(
            color: isDark ? AppColors.darkMainText : AppColors.lightMainText,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Event Image
                EvenImageWidget(isDark: isDark, selectedEventImage: selectedEventImage),
                SizedBox(height: 16.h),

                /// Event Categories
                buildEventCategories(eventNamesList, isDark),
                SizedBox(height: 20.h),

                /// Title
                Text('Title'.tr(),
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.darkMainText
                            : AppColors.lightMainText)),
                SizedBox(height: 8.h),
                title_text_form(titleController: titleController, isDark: isDark),
                SizedBox(height: 16.h),

                /// Description
                Text('Description'.tr(),
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.darkMainText
                            : AppColors.lightMainText)),
                SizedBox(height: 8.h),
                desc_text_form(descController: descController, isDark: isDark),
                SizedBox(height: 16.h),

                /// Date Row
                Row(
                  children: [
                    Image.asset(
                      "assets/images/calendar-add.png",
                      color: isDark
                          ? AppColors.darkPrimary
                          : AppColors.lightPrimary,
                      width: 24.w,
                      height: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    Text('Event Date'.tr(), style: TextStyle(fontSize: 14.sp,color: isDark
                        ? AppColors.darkMainText
                        : AppColors.lightMainText, )),
                    const Spacer(),

                    TextButton(
                      onPressed: chooseDate,
                      child: Text(
                        selectedDate == null
                            ? 'Choose date'.tr()
                            : DateFormat.yMMMMd(context.locale.languageCode)
                            .format(selectedDate!),
                        style: isDark
                            ? AppTheme.darkTheme.textTheme.displayMedium
                            : AppTheme.lightTheme.textTheme.displayMedium,
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 8.h),

                /// Time Row
                Row(
                  children: [
                    Image.asset(
                      "assets/images/clock.png",
                      color: isDark
                          ? AppColors.darkPrimary
                          : AppColors.lightPrimary,
                      width: 24.w,
                      height: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    Text('Event Time'.tr(), style: TextStyle(fontSize: 14.sp,color: isDark
                        ? AppColors.darkMainText
                        : AppColors.lightMainText, )),
                    const Spacer(),
                    TextButton(
                      onPressed: chooseTime,
                      child: Text(
                        selectedTime == null
                            ? 'Choose time'.tr()
                            : DateFormat.jm(context.locale.languageCode).format(
                          DateTime(
                            0,
                            0,
                            0,
                            selectedTime!.hour,
                            selectedTime!.minute,
                          ),
                        ),
                        style: isDark
                            ? AppTheme.darkTheme.textTheme.displayMedium
                            : AppTheme.lightTheme.textTheme.displayMedium,
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20.h),

                /// Add Event Button
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    title: isEditMode ? 'Edit Event'.tr() : 'Add Event'.tr(),
                    onTap: isEditMode ? editEvent : addEvent,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildEventCategories(List<String> eventNamesList, bool isDark) {
    return SizedBox(
                height: 50.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventNamesList.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: TabCategoryWidget(
                        eventName: eventNamesList[index],
                        isSelected: selectedIndex == index,
                        selectedColor: isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary,
                        selectedTextStyle: (isDark
                            ? AppTheme.darkTheme.textTheme.labelMedium
                            : AppTheme.lightTheme.textTheme.labelMedium)
                            ?.copyWith(color: Colors.white, fontSize: 14.sp),
                        unselectedColor:
                        isDark ? AppColors.darkBackground : Colors.white,
                        unselectedBorderColor: isDark
                            ? AppColors.darkStroke
                            : AppColors.lightStroke,
                        unselectedTextStyle: (isDark
                            ? AppTheme.darkTheme.textTheme.labelMedium
                            : AppTheme.lightTheme.textTheme.labelMedium)
                            ?.copyWith(
                          color: isDark
                              ? AppColors.darkMainText
                              : AppColors.lightMainText,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  },
                ),
              );
  }
//date
  void chooseDate() async {
    final now = DateTime.now();
    final initial = selectedDate ?? now;
    final choosedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: now.add(const Duration(days: 365)),
      locale: context.locale,
      builder: (context, child) {
        final themeProvider = context.read<AppThemeProvider>();
        final isDark = themeProvider.isDarkMode();
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme(
              brightness: isDark ? Brightness.dark : Brightness.light,
              primary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
              onPrimary: Colors.white,
              secondary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
              onSecondary: Colors.white,
              surface: isDark ? AppColors.darkInput : Colors.white,
              onSurface: isDark ? AppColors.darkMainText : AppColors.lightMainText,
              background: isDark ? AppColors.darkBackground : AppColors.lightBackground,
              error: AppColors.red,
              onError: Colors.white,
            ),
            dialogBackgroundColor: isDark ? AppColors.darkBackground : Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (choosedDate != null) {
      setState(() {
        selectedDate = choosedDate;
        formattedDate = DateFormat('MMMM dd, yyyy', 'en').format(selectedDate!);
      });
    }
  }

//time
  void chooseTime() async {
    final choosedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        final themeProvider = context.read<AppThemeProvider>();
        final isDark = themeProvider.isDarkMode();
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme(
              brightness: isDark ? Brightness.dark : Brightness.light,
              primary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
              onPrimary: Colors.white,
              secondary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
              onSecondary: Colors.white,
              surface: isDark ? AppColors.darkInput : Colors.white,
              onSurface: isDark ? AppColors.darkMainText : AppColors.lightMainText,
              background: isDark ? AppColors.darkBackground : AppColors.lightBackground,
              error: AppColors.red,
              onError: Colors.white,
            ),
            dialogBackgroundColor: isDark ? AppColors.darkBackground : Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (choosedTime != null) {
      setState(() {
        selectedTime = choosedTime;


        final date = selectedDate ?? DateTime.now();
        selectedDate = DateTime(
          date.year,
          date.month,
          date.day,
          selectedTime!.hour,
          selectedTime!.minute,
        );

        formattedDate = DateFormat('MMMM dd, yyyy', 'en').format(selectedDate!);
        formattedTime = DateFormat.jm('en_US').format(selectedDate!);
      });
    }
  }

  //  Add event
  Future<void> addEvent() async {
    final eventListProvider = context.read<EventListProvider>();

    if (!_formKey.currentState!.validate()) return;
    if (selectedDate == null) {
      AppDialogs.showErrorSnackBar(context, "Please select a date");

      return;
    }
    if (selectedTime == null) {
      AppDialogs.showErrorSnackBar(context, "Please select a time");
      return;
    }

    final englishEventName = getEnglishEventName(selectedEventsName);

    final event = EventModel(
      date: selectedDate!,
      title: titleController.text.trim(),
      description: descController.text.trim(),
      eventName: englishEventName,
      eventImage: selectedEventImage,
      time: formattedTime,
      userUid: FirebaseAuth.instance.currentUser!.uid,
    );

    await eventListProvider.addEvent(event);
    if (!context.mounted) return;
    AppDialogs.showSuccessSnackBar(context, "Event added successfully");



    titleController.clear();
    descController.clear();
    context.go(AppRouts.homeScreen);
  }


  Future<void> editEvent() async {
    final eventListProvider = context.read<EventListProvider>();
    if (!_formKey.currentState!.validate()) return;
    if (selectedDate == null || selectedTime == null) {
      AppDialogs.showErrorSnackBar(context, "Please select date & time");


      return;
    }

    final englishEventName = getEnglishEventName(selectedEventsName);

    final updatedEvent = EventModel(
      id: widget.eventToEdit!.id,
      date: selectedDate!,
      title: titleController.text.trim(),
      description: descController.text.trim(),
      eventName: englishEventName,
      eventImage: selectedEventImage,
      time: formattedTime,
      isFavorite: widget.eventToEdit!.isFavorite,
      userUid: FirebaseAuth.instance.currentUser!.uid,
    );

   // eventListProvider.updateEventLocally(updatedEvent);
    await eventListProvider.updateEvent(updatedEvent);

    if (!context.mounted) return;
    AppDialogs.showSuccessSnackBar(context, "Event updated successfully");
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: AppColors.lightPrimary,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    //     content: Row(
    //       children: const [
    //         Icon(Icons.check_circle, color: Colors.white),
    //         SizedBox(width: 10),
    //         Expanded(
    //           child: Text(
    //             "Event updated successfully",
    //             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),

    context.pop();
  }

}




