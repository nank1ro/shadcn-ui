import 'package:example/common/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MenubarPage extends StatelessWidget {
  const MenubarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      appBarTitle: 'Menubar',
      children: [
        ShadMenubar(),
      ],
    );
  }
}
