import 'package:example/common/base_scaffold.dart';
import 'package:example/common/properties/bool_property.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  bool enabled = true;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitle: 'Input',
      editable: [
        MyBoolProperty(
          label: 'Enabled',
          value: enabled,
          onChanged: (value) => setState(() => enabled = value),
        ),
        MyBoolProperty(
          label: 'Obscure',
          value: obscure,
          onChanged: (value) => setState(() => obscure = value),
        ),
      ],
      children: [
        SizedBox(
          width: 40,
          child: ShadInput(
            padding: const EdgeInsets.symmetric(vertical: 8),
            textAlign: TextAlign.center,
            hintText: '0',
            style: const TextStyle(fontSize: 12),
            hintStyle: const TextStyle(fontSize: 12),
            enabled: enabled,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        ShadInput(
          hintText: 'Email',
          enabled: enabled,
          keyboardType: TextInputType.emailAddress,
        ),
        ShadInput(
          hintText: 'Password',
          enabled: enabled,
          obscureText: obscure,
          prefix: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(LucideIcons.lock),
          ),
          suffix: ShadButton(
            width: 24,
            height: 24,
            padding: EdgeInsets.zero,
            decoration: const ShadDecoration(
              secondaryBorder: ShadBorder.none,
              secondaryFocusedBorder: ShadBorder.none,
            ),
            icon: Icon(obscure ? LucideIcons.eyeOff : LucideIcons.eye),
            onPressed: () {
              setState(() => obscure = !obscure);
            },
          ),
        ),
      ],
    );
  }
}
