// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum FormStyle {
  inputField,
  checkboxField,
  switchField,
  selectField,
  radioField,
  datePickerField,
  dateRangePickerField,
  timePickerField,
  periodTimePickerField,
  inputOTPField,
}

enum NotifyAbout {
  all,
  mentions,
  nothing;

  String get message {
    return switch (this) {
      all => 'All new messages',
      mentions => 'Direct messages and mentions',
      nothing => 'Nothing',
    };
  }
}

class FormPage extends StatefulWidget {
  const FormPage({
    super.key,
    required this.style,
  });

  final FormStyle style;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<ShadFormState>();

  final verifiedEmails = [
    'm@example.com',
    'm@google.com',
    'm@support.com',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ShadForm(
          key: formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                switch (widget.style) {
                  FormStyle.inputField => ShadInputFormField(
                      id: 'username',
                      label: const Text('Username'),
                      hintText: 'Enter your username',
                      description:
                          const Text('This is your public display name.'),
                      validator: (v) {
                        if (v.length < 2) {
                          return 'Username must be at least 2 characters.';
                        }
                        return null;
                      },
                    ),
                  FormStyle.checkboxField => ShadCheckboxFormField(
                      id: 'terms',
                      initialValue: false,
                      inputLabel:
                          const Text('I accept the terms and conditions'),
                      onChanged: (v) {},
                      inputSublabel:
                          const Text('You agree to our Terms and Conditions'),
                      validator: (v) {
                        if (!v) {
                          return 'You must accept the terms and conditions';
                        }
                        return null;
                      },
                    ),
                  FormStyle.switchField => ShadSwitchFormField(
                      id: 'terms',
                      initialValue: false,
                      inputLabel:
                          const Text('I accept the terms and conditions'),
                      onChanged: (v) {},
                      inputSublabel:
                          const Text('You agree to our Terms and Conditions'),
                      validator: (v) {
                        if (!v) {
                          return 'You must accept the terms and conditions';
                        }
                        return null;
                      },
                    ),
                  FormStyle.selectField => ShadSelectFormField<String>(
                      id: 'email',
                      minWidth: 350,
                      initialValue: null,
                      onChanged: (v) {},
                      options: verifiedEmails
                          .map((email) =>
                              ShadOption(value: email, child: Text(email)))
                          .toList(),
                      selectedOptionBuilder: (context, value) => value == 'none'
                          ? const Text('Select a verified email to display')
                          : Text(value),
                      placeholder:
                          const Text('Select a verified email to display'),
                      validator: (v) {
                        if (v == null) {
                          return 'Please select an email to display';
                        }
                        return null;
                      },
                    ),
                  FormStyle.radioField => ShadRadioGroupFormField<NotifyAbout>(
                      label: const Text('Notify me about'),
                      items: NotifyAbout.values.map(
                        (e) => ShadRadio(
                          value: e,
                          label: Text(e.message),
                        ),
                      ),
                      validator: (v) {
                        if (v == null) {
                          return 'You need to select a notification type.';
                        }
                        return null;
                      },
                    ),
                  FormStyle.datePickerField => ShadDatePickerFormField(
                      label: const Text('Date of birth'),
                      onChanged: print,
                      description: const Text(
                          'Your date of birth is used to calculate your age.'),
                      validator: (v) {
                        if (v == null) {
                          return 'A date of birth is required.';
                        }
                        return null;
                      },
                    ),
                  FormStyle.dateRangePickerField =>
                    ShadDateRangePickerFormField(
                      label: const Text('Range of dates'),
                      onChanged: print,
                      description: const Text(
                          'Select the range of dates you want to search between.'),
                      validator: (v) {
                        if (v == null) return 'A range of dates is required.';
                        if (v.start == null) {
                          return 'The start date is required.';
                        }
                        if (v.end == null) return 'The end date is required.';

                        return null;
                      },
                    ),
                  FormStyle.timePickerField => ShadTimePickerFormField(
                      label: const Text('Pick a time'),
                      onChanged: print,
                      description:
                          const Text('The time of the day you want to pick'),
                      validator: (v) => v == null ? 'A time is required' : null,
                    ),
                  FormStyle.periodTimePickerField =>
                    ShadTimePickerFormField.period(
                      label: const Text('Pick a time'),
                      onChanged: print,
                      description:
                          const Text('The time of the day you want to pick'),
                      validator: (v) => v == null ? 'A time is required' : null,
                    ),
                  FormStyle.inputOTPField => ShadInputOTPFormField(
                      id: 'otp',
                      maxLength: 6,
                      label: const Text('OTP'),
                      description: const Text('Enter your OTP.'),
                      validator: (v) {
                        if (v.contains(' ')) {
                          return 'Fill the whole OTP code';
                        }
                        return null;
                      },
                      children: const [
                        ShadInputOTPGroup(
                          children: [
                            ShadInputOTPSlot(),
                            ShadInputOTPSlot(),
                            ShadInputOTPSlot(),
                          ],
                        ),
                        Icon(size: 24, LucideIcons.dot),
                        ShadInputOTPGroup(
                          children: [
                            ShadInputOTPSlot(),
                            ShadInputOTPSlot(),
                            ShadInputOTPSlot(),
                          ],
                        ),
                      ],
                    ),
                },
                const SizedBox(height: 16),
                ShadButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      print(
                          'validation succeeded with ${formKey.currentState!.value}');
                    } else {
                      print('validation failed');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
