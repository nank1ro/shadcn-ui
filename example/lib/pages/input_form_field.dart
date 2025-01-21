// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:example/common/base_scaffold.dart';
import 'package:example/common/properties/bool_property.dart';
import 'package:example/common/properties/enum_property.dart';
import 'package:example/common/properties/string_property.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InputFormFieldPage extends StatefulWidget {
  const InputFormFieldPage({super.key});

  @override
  State<InputFormFieldPage> createState() => _InputFormFieldPageState();
}

class _InputFormFieldPageState extends State<InputFormFieldPage> {
  bool enabled = true;
  var autovalidateMode = ShadAutovalidateMode.alwaysAfterFirstValidation;
  String? initialValue;
  Map<Object, dynamic> formValue = {};
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadForm(
      key: formKey,
      enabled: enabled,
      autovalidateMode: autovalidateMode,
      initialValue: {if (initialValue != null) 'username': initialValue},
      child: BaseScaffold(
        appBarTitle: 'InputFormField',
        editable: [
          MyBoolProperty(
            label: 'Enabled',
            value: enabled,
            onChanged: (value) => setState(() => enabled = value),
          ),
          MyEnumProperty(
            label: 'autovalidateMode',
            value: autovalidateMode,
            values: ShadAutovalidateMode.values,
            onChanged: (value) {
              if (value != null) {
                setState(() => autovalidateMode = value);
              }
            },
          ),
          MyStringProperty(
            label: 'Form Initial Value',
            initialValue: initialValue,
            hintText: 'Name',
            onChanged: (value) {
              setState(() {
                value.isEmpty ? initialValue = null : initialValue = value;
              });
              // Reset the form
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                formKey.currentState!.reset();
              });
            },
          ),
        ],
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShadInputFormField(
                  id: 'username',
                  prefix: const Icon(LucideIcons.user),
                  label: const Text('Username'),
                  hintText: 'Enter your username',
                  description: const Text('This is your public display name.'),
                  validator: (v) {
                    if (v.length < 2) {
                      return 'Username must be at least 2 characters.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ShadButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    print('submitted');
                    if (formKey.currentState!.saveAndValidate()) {
                      setState(() {
                        formValue = formKey.currentState!.value;
                      });
                    } else {
                      print('validation failed');
                    }
                  },
                ),
                if (formValue.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('FormValue', style: theme.textTheme.p),
                        const SizedBox(height: 4),
                        SelectableText(
                          const JsonEncoder.withIndent('    ')
                              .convert(formValue),
                          style: theme.textTheme.small,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
