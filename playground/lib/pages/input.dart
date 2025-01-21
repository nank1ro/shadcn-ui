import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum InputStyle {
  email,
  password,
}

class InputPage extends StatelessWidget {
  const InputPage({
    super.key,
    required this.style,
  });

  final InputStyle style;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: switch (style) {
            InputStyle.email => const EmailInput(),
            InputStyle.password => const PasswordInput(),
          },
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadInput(
      hintText: 'Email',
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      hintText: 'Password',
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
    );
  }
}
