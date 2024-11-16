import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reset_life/src/common_widgets/scaffold.dart';
import 'package:reset_life/src/constants/app_sizes.dart';
import 'package:reset_life/src/features/home/presentation/home_controller.dart';
import 'package:reset_life/src/l10n/l10n.dart';
import 'package:reset_life/src/themes/extensions.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(timerProvider.notifier).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerProvider);
    final localizations = AppLocalizations.of(context);

    return AppScaffold(
      body: Column(
        children: [
          gapH16,
          Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: _buildTimer(context, timerState, localizations),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: _buildCheckInMenu(context, localizations),
              ),
              Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: _buildCheckInMenu(context, localizations),
              ),
              Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: _buildCheckInMenu(context, localizations),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildCheckInMenu(
    BuildContext context,
    AppLocalizations localizations,
  ) {
    String replaceText = localizations.recordRelapse.replaceFirst(' ', '\n');
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colors.accent,
            context.colors.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(Sizes.p16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          children: [
            Icon(Icons.import_contacts),
            gapH12,
            Text(
              replaceText,
              style: TextStyle(
                color: context.colors.background,
                fontWeight: FontWeight.bold,
              ).withSize(Sizes.p18),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildTimer(
    BuildContext context,
    TimerState timerState,
    AppLocalizations localizations,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colors.accent,
            context.colors.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(Sizes.p16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.currentStreak,
              style: TextStyle(
                color: context.colors.background,
                fontWeight: FontWeight.bold,
              ).withSize(Sizes.p18),
            ),
            gapH16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${timerState.days}',
                  style: TextStyle(
                    color: context.colors.background,
                    fontWeight: FontWeight.bold,
                  ).withSize(Sizes.p18),
                ),
                Text(
                  '${timerState.hours}',
                  style: TextStyle(
                    color: context.colors.background,
                    fontWeight: FontWeight.bold,
                  ).withSize(Sizes.p18),
                ),
                Text(
                  '${timerState.minutes}',
                  style: TextStyle(
                    color: context.colors.background,
                    fontWeight: FontWeight.bold,
                  ).withSize(Sizes.p18),
                ),
                Text(
                  '${timerState.seconds}',
                  style: TextStyle(
                    color: context.colors.background,
                    fontWeight: FontWeight.bold,
                  ).withSize(Sizes.p18),
                ),
              ],
            ),
            gapH12,
            LinearProgressIndicator(
              value: timerState.progressPercentage / 100,
              minHeight: 10,
            ),
            gapH12,
            Text('${timerState.progressPercentage.toStringAsFixed(2)} %'),
          ],
        ),
      ),
    );
  }
}
