import 'package:example/common/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TimePickerPage extends StatelessWidget {
  const TimePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitle: 'TimePicker',
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ShadTimePicker(
            trailing: const Padding(
              padding: EdgeInsets.only(left: 8, top: 14),
              child: Icon(LucideIcons.clock4),
            ),
            // fieldWidth: 40,
            // spacing: 8,
            // style: TextStyle(fontSize: 12),
            // placeholderStyle: TextStyle(fontSize: 12),
            // fieldPadding: EdgeInsets.zero,
            onChanged: (time) {
              print('time: $time');
            },
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ShadTimePicker.period(
            crossAxisAlignment: WrapCrossAlignment.end,
            onChanged: (time) {
              print('time: $time');
            },
          ),
        ),
      ],
    );
  }
}
