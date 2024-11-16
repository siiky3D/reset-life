import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reset_life/src/common_widgets/main_tab_view.dart';
import 'package:reset_life/src/common_widgets/primary_button%20copy.dart';
import 'package:reset_life/src/common_widgets/scaffold.dart';
import 'package:reset_life/src/constants/app_sizes.dart';
import 'package:reset_life/src/l10n/l10n.dart';
import 'package:reset_life/src/routing/app_router.dart';
import 'package:reset_life/src/themes/colors.dart';
import 'package:reset_life/src/themes/extensions.dart';
import 'package:table_calendar/table_calendar.dart';

var listTabData = [
  MainTabData(
    label: 'label',
    child: Text('data'),
  ),
  MainTabData(
    label: 'label',
    child: Text('data'),
  ),
  MainTabData(
    label: 'label',
    child: Text('data'),
  ),
  MainTabData(
    label: 'label',
    child: Text('data'),
  ),
];

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);

    return AppScaffold(
      body: MainTabView(
        tabs: [
          MainTabData(
            label: localizations.calendar,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(Sizes.p16),
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                    ),
                  ),
                  gapH16,
                  PrimaryButton(
                    text: localizations.addRelapse,
                    color: context.colors.primary,
                    onPressed: () => context.goNamed(AppRoute.addRelapse.name),
                  ),
                  gapH16,
                  Consumer(
                    builder: (context, ref, child) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.darkBrown,
                          borderRadius: BorderRadius.circular(Sizes.p16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Sizes.p16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('data'),
                                  Text('data'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('data'),
                                  Text('data'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('data'),
                                  Text('data'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          MainTabData(
            label: localizations.statistics,
            child: Center(child: Text("Content for Tab 2")),
          ),
        ],
      ),
    );
  }
}
