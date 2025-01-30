import 'package:example/common/app_bar.dart';
import 'package:example/pages/accordion.dart';
import 'package:example/pages/alert.dart';
import 'package:example/pages/avatar.dart';
import 'package:example/pages/badge.dart';
import 'package:example/pages/button.dart';
import 'package:example/pages/calendar.dart';
import 'package:example/pages/card.dart';
import 'package:example/pages/checkbox.dart';
import 'package:example/pages/checkbox_form_field.dart';
import 'package:example/pages/context_menu.dart';
import 'package:example/pages/date_picker.dart';
import 'package:example/pages/date_picker_form_field.dart';
import 'package:example/pages/dialog.dart';
import 'package:example/pages/input.dart';
import 'package:example/pages/input_form_field.dart';
import 'package:example/pages/input_otp.dart';
import 'package:example/pages/input_otp_form_field.dart';
import 'package:example/pages/menubar.dart';
import 'package:example/pages/popover.dart';
import 'package:example/pages/progress.dart';
import 'package:example/pages/radio_group.dart';
import 'package:example/pages/radio_group_form_field.dart';
import 'package:example/pages/resizable.dart';
import 'package:example/pages/select.dart';
import 'package:example/pages/select_form_field.dart';
import 'package:example/pages/sheet.dart';
import 'package:example/pages/slider.dart';
import 'package:example/pages/switch.dart';
import 'package:example/pages/switch_form_field.dart';
import 'package:example/pages/tabs.dart';
import 'package:example/pages/table.dart';
import 'package:example/pages/time_picker.dart';
import 'package:example/pages/time_picker_form_field.dart';
import 'package:example/pages/toast.dart';
import 'package:example/pages/tooltip.dart';
import 'package:example/pages/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';

import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  SolidartConfig.devToolsEnabled = false;
  runApp(const App());
}

// Maps the routes to the specific widget page.
final routes = <String, WidgetBuilder>{
  '/accordion': (_) => const AccordionPage(),
  '/alert': (_) => const AlertPage(),
  '/avatar': (_) => const AvatarPage(),
  '/badge': (_) => const BadgePage(),
  '/button': (_) => const ButtonPage(),
  '/calendar': (_) => const CalendarPage(),
  '/card': (_) => const CardPage(),
  '/checkbox': (_) => const CheckboxPage(),
  '/checkbox-form-field': (_) => const CheckboxFormFieldPage(),
  '/context-menu': (_) => const ContextMenuPage(),
  '/date-picker': (_) => const DatePickerPage(),
  '/date-picker-form-field': (_) => const DatePickerFormFieldPage(),
  '/dialog': (_) => const DialogPage(),
  '/input': (_) => const InputPage(),
  '/input-OTP': (_) => const InputOTPPage(),
  '/input-OTP-form-field': (_) => const InputOTPFormFieldPage(),
  '/input-form-field': (_) => const InputFormFieldPage(),
  '/menubar': (_) => const MenubarPage(),
  '/popover': (_) => const PopoverPage(),
  '/progress': (_) => const ProgressPage(),
  '/radio-group': (_) => const RadioPage(),
  '/radio-group-form-field': (_) => const RadioGroupFormFieldPage(),
  '/resizable': (_) => const ResizablePage(),
  '/select': (_) => const SelectPage(),
  '/select-form-field': (_) => const SelectFormFieldPage(),
  '/sheet': (_) => const SheetPage(),
  '/slider': (_) => const SliderPage(),
  '/switch': (_) => const SwitchPage(),
  '/switch-form-field': (_) => const SwitchFormFieldPage(),
  '/table': (_) => const TablePage(),
  '/tabs': (_) => const TabsPage(),
  '/time-picker': (_) => const TimePickerPage(),
  '/time-picker-form-field': (_) => const TimePickerFormFieldPage(),
  '/toast': (_) => const ToastPage(),
  '/tooltip': (_) => const TooltipPage(),
  '/typography': (_) => const TypographyPage(),
};
final routeToNameRegex = RegExp('(?:^/|-)([a-zA-Z])');

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Solid(
      providers: [
        Provider<Signal<ThemeMode>>(create: () => Signal(ThemeMode.light)),
      ],
      builder: (context) {
        final themeMode = context.observe<ThemeMode>();
        // Custom App example
        // return ShadApp.custom(
        //   themeMode: themeMode,
        //   appBuilder: (context, theme) => GetMaterialApp(
        //     routes: routes,
        //     themeMode: themeMode,
        //     theme: theme,
        //     home: const MainPage(),
        //     builder: (context, child) {
        //       return ShadToaster(child: child!);
        //     },
        //   ),
        // );
        return ShadApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          routes: routes,
          theme: ShadThemeData(
            brightness: Brightness.light,
            colorScheme: const ShadZincColorScheme.light(),
            // Example with google fonts
            // textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.poppins),

            // Example of custom font family
            // textTheme: ShadTextTheme(family: 'UbuntuMono'),

            // Example to disable the secondary border
            // disableSecondaryBorder: true,
          ),
          darkTheme: ShadThemeData(
            brightness: Brightness.dark,
            colorScheme: const ShadZincColorScheme.dark(),
            // Example of custom font family
            // textTheme: ShadTextTheme(family: 'UbuntuMono'),
          ),
          home: const MainPage(),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final search = Signal('');

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleWidget: ShadInput(
          placeholder: const Text('Search ShadcnUI component'),
          onChanged: search.set,
        ),
      ),
      body: SignalBuilder(
        signal: search,
        builder: (context, searchString, child) {
          final filteredRoutes = {
            for (final k in routes.keys.where(
                (k) => k.toLowerCase().contains(searchString.toLowerCase())))
              k: routes[k]!
          };

          return ListView.builder(
            itemCount: filteredRoutes.length,
            itemBuilder: (BuildContext context, int index) {
              final route = filteredRoutes.keys.elementAt(index);

              final name = route.replaceAllMapped(
                routeToNameRegex,
                (match) => match.group(0)!.substring(1).toUpperCase(),
              );

              return Material(
                child: ListTile(
                  title: Text(name),
                  onTap: () {
                    Navigator.of(context).pushNamed(route);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
