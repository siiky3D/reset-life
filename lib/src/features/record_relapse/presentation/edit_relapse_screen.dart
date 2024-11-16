import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reset_life/src/common_widgets/scaffold.dart';
import 'package:reset_life/src/constants/app_sizes.dart';
import 'package:reset_life/src/l10n/l10n.dart';
import 'package:reset_life/src/themes/colors.dart';

class EditRelapseScreen extends ConsumerStatefulWidget {
  const EditRelapseScreen({super.key});

  @override
  ConsumerState<EditRelapseScreen> createState() => _EditRelapseScreenState();
}

class _EditRelapseScreenState extends ConsumerState<EditRelapseScreen> {
  double _value = 20;
  String _status = 'idle';
  Color _statusColor = Colors.amber;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return AppScaffold(
      body: Column(
        children: [
          Row(
            children: [
              Icon(Icons.import_contacts_outlined),
              gapW12,
              Text('${DateTime.now()}'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(Sizes.p16),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localizations.activity),
                    Slider(
                      min: 0.0,
                      max: 100.0,
                      value: _value,
                      divisions: 4,
                      onChanged: (dynamic value) {
                        setState(() {
                          _value = value;
                          _status = 'active (${_value.round()})';
                          _statusColor = Colors.green;
                        });
                      },
                      onChangeStart: (value) {
                        setState(() {
                          _status = 'start';
                          _statusColor = Colors.lightGreen;
                        });
                      },
                      onChangeEnd: (value) {
                        setState(() {
                          _status = 'end';
                          _statusColor = Colors.red;
                        });
                      },
                    ),
                    Text(
                      'Status: $_status',
                      style: TextStyle(color: _statusColor),
                    ),
                  ],
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(Sizes.p16),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localizations.activity),
                    Slider(
                      min: 0.0,
                      max: 100.0,
                      value: _value,
                      divisions: 4,
                      onChanged: (dynamic value) {
                        setState(() {
                          _value = value;
                          _status = 'active (${_value.round()})';
                          _statusColor = Colors.green;
                        });
                      },
                      onChangeStart: (value) {
                        setState(() {
                          _status = 'start';
                          _statusColor = Colors.lightGreen;
                        });
                      },
                      onChangeEnd: (value) {
                        setState(() {
                          _status = 'end';
                          _statusColor = Colors.red;
                        });
                      },
                    ),
                    Text(
                      'Status: $_status',
                      style: TextStyle(color: _statusColor),
                    ),
                  ],
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
