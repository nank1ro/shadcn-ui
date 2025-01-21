import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum SelectVariant {
  fruits,
  timezone,
  frameworks,
  multiple,
}

final fruits = {
  'apple': 'Apple',
  'banana': 'Banana',
  'blueberry': 'Blueberry',
  'grapes': 'Grapes',
  'pineapple': 'Pineapple',
};

final timezones = {
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

class SelectPage extends StatelessWidget {
  const SelectPage({
    super.key,
    required this.variant,
  });

  final SelectVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Align(
          alignment: Alignment.topCenter,
          child: switch (variant) {
            SelectVariant.fruits => ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 180),
                child: ShadSelect<String>(
                  placeholder: const Text('Select a fruit'),
                  options: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
                      child: Text(
                        'Fruits',
                        style: theme.textTheme.muted.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.popoverForeground,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    ...fruits.entries.map(
                        (e) => ShadOption(value: e.key, child: Text(e.value))),
                  ],
                  selectedOptionBuilder: (context, value) =>
                      Text(fruits[value]!),
                  onChanged: print,
                ),
              ),
            SelectVariant.timezone => ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 280),
                child: ShadSelect<String>(
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
                        ...zone.value.entries.map((e) =>
                            ShadOption(value: e.key, child: Text(e.value)))
                      ],
                    ),
                  ),
                  onChanged: print,
                  selectedOptionBuilder: (context, value) {
                    final timezone = timezones.entries
                        .firstWhere(
                            (element) => element.value.containsKey(value))
                        .value[value];
                    return Text(timezone!);
                  },
                ),
              ),
            SelectVariant.frameworks => const SelectWithSearch(),
            SelectVariant.multiple => const SelectMultiple(),
          },
        ),
      ),
    );
  }
}

const frameworks = {
  'nextjs': 'Next.js',
  'svelte': 'SvelteKit',
  'nuxtjs': 'Nuxt.js',
  'remix': 'Remix',
  'astro': 'Astro',
};

class SelectWithSearch extends StatefulWidget {
  const SelectWithSearch({super.key});

  @override
  State<SelectWithSearch> createState() => _SelectWithSearchState();
}

class _SelectWithSearchState extends State<SelectWithSearch> {
  var searchValue = '';

  Map<String, String> get filteredFrameworks => {
        for (final framework in frameworks.entries)
          if (framework.value.toLowerCase().contains(searchValue.toLowerCase()))
            framework.key: framework.value
      };

  @override
  Widget build(BuildContext context) {
    return ShadSelect<String>.withSearch(
      minWidth: 180,
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
    );
  }
}

class SelectMultiple extends StatelessWidget {
  const SelectMultiple({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadSelect<String>.multiple(
      minWidth: 340,
      onChanged: print,
      allowDeselection: true,
      closeOnSelect: false,
      placeholder: const Text('Select multiple fruits'),
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
    );
  }
}
