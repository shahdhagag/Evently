import 'package:easy_localization/easy_localization.dart';
import 'package:evently/features/favourite/widgets/app_text_field.dart';
import 'package:evently/features/home/widgets/event_item.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final themeProvider = context.watch<AppThemeProvider>();
    final isDark = themeProvider.isDarkMode();

    final eventListProvider = context.watch<EventListProvider>();
    final searchProvider = context.watch<FavoriteSearchProvider>();

    final favoriteEvents = eventListProvider.allFavoriteEvents;

    // search + favorites
    final filteredEvents = searchProvider.filterEvents(favoriteEvents);

    // Reverse the filtered list so the most recently favorited appear at the top
    final displayedEvents = filteredEvents.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: AppTextField(
          hint: "search_for_event".tr(),
          onChanged: searchProvider.updateSearch,
        ),
        titleSpacing: 16,
        centerTitle: true,
      ),
      body: displayedEvents.isEmpty
          ? Center(
        child: Text(
          'no_favorite_events'.tr(),
          style: TextStyle(
            fontSize: width * 0.045,
            color: Colors.grey,
          ),
        ),
      )
          : ListView.separated(
        padding: EdgeInsets.all(width * 0.04),
        itemCount: displayedEvents.length,
        separatorBuilder: (_, __) => const Gap(15),
        itemBuilder: (context, index) {
          return EventItem(event: displayedEvents[index]);
        },
      ),
    );
  }
}
