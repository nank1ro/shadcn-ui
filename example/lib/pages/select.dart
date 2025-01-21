// ignore_for_file: avoid_print

import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:example/common/base_scaffold.dart';
import 'package:example/common/properties/bool_property.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const fruits = {
  'apple': 'Apple',
  'banana': 'Banana',
  'blueberry': 'Blueberry',
  'grapes': 'Grapes',
  'pineapple': 'Pineapple',
};

const timezones = {
  'North America': {
    'est': 'Eastern Standard Time (EST)',
    'cst': 'Central Standard Time (CST)',
    'mst': 'Mountain Standard Time (MST)',
    'pst': 'Pacific Standard Time (PST)',
    'akst': 'Alaska Standard Time (AKST)',
    'hst': 'Hawaii Standard Time (HST)',
  },
  'Europe & Africa': {
    'gmt': 'Greenwich Mean Time (GMT)',
    'cet': 'Central European Time (CET)',
    'eet': 'Eastern European Time (EET)',
    'west': 'Western European Summer Time (WEST)',
    'cat': 'Central Africa Time (CAT)',
    'eat': 'Eastern Africa Time (EAT)',
  },
  'Asia': {
    'msk': 'Moscow Time (MSK)',
    'ist': 'India Standard Time (IST)',
    'cst_china': 'China Standard Time (CST)',
    'jst': 'Japan Standard Time (JST)',
    'kst': 'Korea Standard Time (KST)',
    'ist_indonasia': 'Indonesia Standard Time (IST)',
  },
  'Australia & Pacific': {
    'awst': 'Australian Western Standard Time (AWST)',
    'acst': 'Australian Central Standard Time (ACST)',
    'aest': 'Australian Eastern Standard Time (AEST)',
    'nzst': 'New Zealand Standard Time (NZST)',
    'fjt': 'Fiji Time (FJT)',
  },
  'South America': {
    'art': 'Argentina Time (ART)',
    'bot': 'Bolivia Time (BOT)',
    'brt': 'Brasilia Time (BRT)',
    'clt': 'Chile Standard Time (CLT)',
  },
};

const frameworks = {
  'nextjs': 'Next.js',
  'svelte': 'SvelteKit',
  'nuxtjs': 'Nuxt.js',
  'remix': 'Remix',
  'astro': 'Astro',
};

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  bool enabled = true;
  final focusNodes = [FocusNode(), FocusNode(), FocusNode(), FocusNode()];
  var searchValue = '';
  bool allowDeselection = false;

  Map<String, String> get filteredFrameworks => {
        for (final framework in frameworks.entries)
          if (framework.value.toLowerCase().contains(searchValue.toLowerCase()))
            framework.key: framework.value
      };

  @override
  void dispose() {
    for (final node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return BaseScaffold(
      appBarTitle: 'Select',
      editable: [
        MyBoolProperty(
          label: 'Enabled',
          value: enabled,
          onChanged: (value) => setState(() => enabled = value),
        ),
        MyBoolProperty(
          label: 'Fruits Focused',
          value: focusNodes[0].hasFocus,
          onChanged: (value) => setState(
            () =>
                value ? focusNodes[0].requestFocus() : focusNodes[0].unfocus(),
          ),
        ),
        MyBoolProperty(
          label: 'Timezone Focused',
          value: focusNodes[1].hasFocus,
          onChanged: (value) => setState(
            () =>
                value ? focusNodes[1].requestFocus() : focusNodes[1].unfocus(),
          ),
        ),
        MyBoolProperty(
          label: 'Framework Focused',
          value: focusNodes[2].hasFocus,
          onChanged: (value) => setState(
            () =>
                value ? focusNodes[2].requestFocus() : focusNodes[2].unfocus(),
          ),
        ),
        MyBoolProperty(
          label: 'Allow deselection',
          value: allowDeselection,
          onChanged: (value) => setState(() => allowDeselection = value),
        ),
      ],
      children: [
        ShadSelect<String>(
          minWidth: 180,
          onChanged: print,
          enabled: enabled,
          focusNode: focusNodes[0],
          placeholder: const Text('Select a fruit'),
          allowDeselection: allowDeselection,
          options: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
              child: Text(
                'Fruits',
                style: theme.textTheme.large,
                textAlign: TextAlign.start,
              ),
            ),
            ...fruits.entries.map(
              (e) => ShadOption(
                value: e.key,
                child: Text(e.value),
              ),
            ),
          ],
          selectedOptionBuilder: (context, value) => Text(value.capitalize()),
        ),
        ShadSelect<String>(
          minWidth: 280,
          focusNode: focusNodes[1],
          onChanged: print,
          enabled: enabled,
          placeholder: const Text('Select a timezone'),
          options: timezones.entries.map(
            (zone) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
                  child: Text(
                    zone.key,
                    style: theme.textTheme.muted.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.popoverForeground,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                ...zone.value.entries.map(
                  (e) => ShadOption(
                    value: e.key,
                    child: Text(e.value),
                  ),
                )
              ],
            ),
          ),
          allowDeselection: allowDeselection,
          selectedOptionBuilder: (context, value) {
            final timezone = timezones.entries
                .firstWhere((element) => element.value.containsKey(value))
                .value[value];
            return Text(timezone!);
          },
        ),
        ShadSelect<String>.withSearch(
          enabled: enabled,
          focusNode: focusNodes[2],
          minWidth: 180,
          maxWidth: 300,
          placeholder: const Text('Select framework...'),
          onSearchChanged: (value) => setState(() => searchValue = value),
          searchHintText: 'Search framework',
          options: [
            if (filteredFrameworks.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text('No framework found'),
              ),
            ...frameworks.entries.map(
              (framework) {
                // this offstage is used to avoid the focus loss when the search results appear again
                // because it keeps the widget in the tree.
                return Offstage(
                  offstage: !filteredFrameworks.containsKey(framework.key),
                  child: ShadOption(
                    value: framework.key,
                    child: Text(framework.value),
                  ),
                );
              },
            )
          ],
          selectedOptionBuilder: (context, value) => Text(frameworks[value]!),
          onChanged: print,
          allowDeselection: allowDeselection,
        ),
        ShadSelect<String>.multiple(
          minWidth: 340,
          onChanged: print,
          enabled: enabled,
          focusNode: focusNodes[3],
          allowDeselection: allowDeselection,
          placeholder: const Text('Select multiple fruits'),
          closeOnSelect: false,
          options: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
              child: Text(
                'Fruits',
                style: theme.textTheme.large,
                textAlign: TextAlign.start,
              ),
            ),
            ...fruits.entries.map(
              (e) => ShadOption(
                value: e.key,
                child: Text(e.value),
              ),
            ),
          ],
          selectedOptionsBuilder: (context, values) =>
              Text(values.map((v) => v.capitalize()).join(', ')),
        ),
      ],
    );
  }
}
