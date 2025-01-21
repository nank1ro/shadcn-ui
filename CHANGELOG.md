## 0.19.0

- **BREAKING CHANGE**: `ShadInput` placeholder alignment. Removed `placeholder` in favor of `hintText` which is now of type `String`. This applies also to `ShadInputFormField`.
- **BREAKING CHANGE**: Rename `searchPlaceholder` into `searchHintText` in `ShadSelect` and `ShadSelectTheme`.
- **BREAKING CHANGE**: Rename `hourPlaceholder` into `hourHintText`, `minutePlaceholder` into `minuteHintText`, `secondPlaceholder` into `secondHintText` in `ShadTimePicker` and `ShadTimePickerTheme`.
- **FIX**: Add `assert` to prevent `selected` date of `ShadCalendar` to be outside the `fromMonth:toMonth` range.

## 0.18.1

- **FIX**: Set `ShadCard` clipBehavior to `Clip.antialias`, add `clipBehavior` to `ShadCard` and `ShadCardTheme`.
- **FIX**: Use `selectedDecoration` in `ShadTabs` (thanks to @thisisamank)
- **FEAT**: Add colorSelector to the ShadcnUI docs (thanks to @0xharkirat)
- **FEAT**: Add `hourLabel`, `minuteLabel`, `secondLabel`, `periodLabel`, `hourPlaceholder`, `minutePlaceholder`, `secondPlaceholder` and `periodPlaceholder` to `ShadTimePickerTheme`.

## 0.18.0

- **BREAKING CHANGE**: Remove `applyIconColorFilter` from `ShadButton`.
- **BREAKING CHANGE**: Remove `ShadImage` component. Prefer using the `Icon` widget for `IconData`, the `Image` widget for normal images, and `SvgPicture` (from the [flutter_svg package](https://pub.dev/packages/flutter_svg) for SVG images. If you want a fallback, use `UniversalImage`.
- **BREAKING CHANGE**: Rename `iconSrc` in `iconData` around components.
- **FIX**: `TimePickerFormField` initial value.

## 0.17.6

- **FIX**: Fix the iconSize of `ShadButton`, add `iconSize` to `ShadButton`.

## 0.17.5

- **FEAT**: New `OrderPolicy`, `LinearOrderPolicy`, `ReverseOrderPolicy` and `CustomOrderPolicy` to update the order policy of the items in a list, this can be very useful to arrange the order of the parts of the shadcn components.
- **FEAT**: Add `orderPolicy` to `ShadOption`, `ShadAlert`, `ShadButton`, `ShadCheckbox`, `ShadCheckboxFormField`, `ShadDatePicker`, `ShadDatePickerFormField`, `ShadDateRangePickerFormField`, `ShadRadio`, `ShadSwitch`, `ShadSwitchFormField`, `ShadToast`.
- **FEAT**: Add `expands` to `ShadButton`, defaults to false. Use it if you want the button's child to expand to fill the available space.

## 0.17.4

- **FIX** `ShadTabs` onChanged runtime exception due to misleading type

## 0.17.3

- **FIX**: `ShadTable` protect `onExit` from setting value after dispose (thanks to @jezell)

## 0.17.2

- **FIX**: Add `allowDeselection` to `ShadCalendar.range`
- **CHORE**: Update dependencies

## 0.17.1

- **FIX**: `ShadInputOTP` text alignment and padding
- **FEAT**: Add `textInputAction` to `ShadInputOTPSlot`

## 0.17.0

- **FEAT**: Add `ShadInputOTP` and `ShadInputOTPFormField` components.
- **BREAKING CHANGE**: The `ShadBorder` no longer has default values, if you want to see the border rendered provide a color and a width greater than 0. This fixes the merge of material borders.
- **FIX**: `ShadTabs` border radius.
- **FIX**: `ShadSlider` focused thumb.
- **FIX**: `ShadResizable` resize when Directionality is RTL.
- **FIX**: Update the `destructive` color on dark mode to be more visible.
- **FIX**: Make inherited widget lookup untyped

## 0.16.3

- **FIX**: `showCursor` default value in `ShadInputFormField`

## 0.16.2

- **FIX**: `ShadTabs` and `ShadResizable` lerp
- **FIX**: `ShadTabs` focused border color in dark mode

## 0.16.1

- **FEAT**: Add parameters to `ShadFocusable`.

## 0.16.0

- **FEAT**: New `ShadTimePicker` and `ShadTimePickerFormField` components.
- **FIX**: `maxLength`, `maxLengthEnforcement` and `showCursor` not working on `ShadInput`
- **FIX**: `ShadCalendar` range day button text style when `disableSecondaryBorder` is `true`.
- **CHORE**: Set minimum Flutter version to `3.24.0`
- **CHORE**: Remove `trackColor` from `ShadSwitch` (thanks to @RaghavTheGreat)
- **FIX**: `ShadSlider` `onChanged` called on every controller update (thanks to @helightdev).

## 0.15.3

- **FIX**: `ShadDialog` and `ShadSheet` children constraints.
- **CHORE**: Replace `flutter_svg_plus` dependency with `flutter_svg` and `vector_graphics_plus` with `vector_graphics`.

## 0.15.2

- **FIX**: `ShadDialog` and `ShadSheet` children constraints.

## 0.15.1

- **FIX**: Decoration merge

## 0.15.0

- **FEAT**: New `ShadDatePicker` component.
- **FEAT**: Add `allowDeselection` property to `ShadCalendar`.
- **FIX**: `ShadSelect` crash when using `optionsBuilder`.
- **FEAT**: Add `itemCount` and `shrinkWrap` to `ShadSelect` and `ShadSelectFormField`.

## 0.14.1

- **FIX**: `ShadApp` scroll behavior.

## 0.14.0

- **BREAKING CHANGE**: Remove `onChangedNullable` from `ShadSelect` and `ShadSelectFormField`. Now the `onChanged` callback will be called with `null` when the user deselects an option if `allowDeselection` is set to `true`. (thanks to @moshOntong-IT)
- **FEAT**: Add click mouse cursor to `ShadTable` when `onRowTap` or `onColumnTap` is provided.

## 0.13.5

- **FIX**: Fix `ShadSelect` initial values on widget creation.

## 0.13.4+1

- **CHORE**: Update svg dependencies

## 0.13.4

- **CHORE**: Update svg dependencies

## 0.13.3

- **FEAT**: Add `ShadApp.custom` for custom _WidgetsApp_ implementation.

## 0.13.2

- **CHORE**: Use forked `flutter_svg` and `vector_graphics` packages.

## 0.13.1

- **CHORE**: Update `ShadImage` import due to WASM.

## 0.13.0

- **FEAT**: New `ShadCalendar` component with the `single`, `multiple` and `range` variants.

## 0.12.0

- **FEAT**: Add `axis`, `spacing`, `runSpacing`, `alignment`, `runAlignment`, `crossAxisAlignment` and `crossAxisAlignment` to `ShadRadioGroup` and `ShadRadioGroupFormField`.

## 0.11.1

- **FEAT**: Add `headers` to `ShadImage` to allow custom headers in the network requests.

## 0.11.0

- **FEAT**: Add `ShadSelect.multiple`, `ShadSelect.multipleWithSearch`, `ShadSelectMultipleFormField` and `ShadSelectMultipleFormField.withSearch` constructors.
- **FEAT**: Add `onChangedNullable` to `ShadSelect` and `ShadSelectFormField`, to allow the deselection of an option.
- Improve the `ShadSelect` focus behavior.
- Improve size of `ShadSelect` options to fit the available space.

## 0.10.0

- __BREAKING CHANGE__: Rename `children` parameter of `ShadContextMenu` and `ShadContextMenuRegion` into `items`.

## 0.9.8

- Improve the `ShadContextMenu` right click behavior on Web.

## 0.9.7

- Remove kind event from `ShadMouseArea`

## 0.9.6

- Fix: the browser context menu has been enabled again, and deactivated only for the `ShadContextMenu` component.

## 0.9.5

- Add text selection toolbar to `ShadInput` (thanks to @moshOntong-IT).

## 0.9.4

- Add gestures recognizers to `ShadTable` for rows and columns.

## 0.9.3

- Fix `ShadSelectFormField` focus when `readOnly` is true.

## 0.9.2

- Add `gap` to `ShadInput` and `ShadInputFormField` (thanks to @moshOntong-IT).

## 0.9.1

- Fix native context menu by disabling it on Web.
- Add `controller` to `ShadContextMenu`.
- Add `onLongPress` to `ShadContextMenuRegion`, defaults to `true` on mobile.

## 0.9.0

- New `ShadContextMenu` component.
- Add `groupId` to `ShadPopover`, to determine if the tap is inside the popover or not.
- Add `onFocusChange` to `ShadFocusable` and `ShadButton`.
- Add `onSecondaryTap` to `ShadButton`.

## 0.8.1

- Fix `ShadTabs` not updating the controller when the value changes.

## 0.8.0

- **BREAKING CHANGE**: Refactor `ShadResizablePanelGroup` in order to react to window resize correctly. The sizes have been normalized. You don't need to provide anymore a pixel size, but a value between 0 and 1 which indicates the percentage of the available space.
- Add `onChanged` to `ShadTabs`.
- Add `onSecondaryTap` to `ShadGestureDetector` and `ShadButton`.
- Fix `maxWidth` missing in `ShadSelectForlField`.

## 0.7.3

- Add `header` and `footer` to `ShadSelect` and `ShadSelectFormField`.
- Add `mainAxisAlignment` and `crossAxisAlignment` to `ShadAlert`.
- Fix unintentional disposal of `controller` in `ShadSelect`.
- Remove assert about `icon` and `iconSrc` in `ShadAlert`, you can avoid using an icon now.
- Fix height of Sheet.

## 0.7.2

- Add `controller` parameter to `ShadSelect` and `ShadSelectFormField`.

## 0.7.1

- Fix performance of `ShadSelect` with the new `optionsBuilder` parameter for a large number of options.
- Fix keyboard appearance of `ShadInput` (thanks to @hieupm2096).
- Add `onPressed` to `ShadBadge`.
- Rename button `text` parameter into `child`.
- Rename dialog `content` parameter into `child`.
- Rename sheet `content` parameter into `child`.
- Rename tab `text` parameter into `child`.

## 0.7.0

- Rename Tabs `defaultValue` parameter into `value`.
- Rename Card `content` parameter into `child`.
- Rename Badge `text` parameter into `child`.
- Rename Input `onTap` parameter into `onPressed`.
- Rename AccordionItem `content` parameter into `child`.
- Add `filter` to Select and Popover in order to blur the background when the popover is open.
- Pass `errorText` to `error` build of Form Fields.
- Add `gap` to Buttons, default to `8`.
- Update type of `src` parameter of Avatar
- Add `Alert.raw` constructor
- Add `Dialog.raw` constructor
- Add `Select.raw` and `SelectFormField.raw` constructors
- Add `TableCell.raw` constructor
- Add `draggable` to Sheet to make it draggable, it works on every side.
- Add `ThemeVariant` to handle the default theme variant, and the one without the secondary border.

## 0.6.5

- Add `textDirection` to `ShadButton`

## 0.6.4

- Make `content` of `ShadTab` optional
- Add `TextSelectionTheme` using shadcn colors
- Add `crossAxisAlignment` to `ShadCheckbox`
- Fix `ShadSelect` popover padding

## 0.6.3

- Fix `FormField`s label not getting the correct style.
- Update the `Popover` animation duration to be faster, the same applies to the `Select` component.
- Remove unused `waitDuration` and `showDuration` from `Popover`.
- Add `effects` and `shadows` to `Select` and `SelectTheme`.

## 0.6.2

- Fix form field error border decoration not working
- Add `ShadAutovalidateMode` to `ShadForm`, with the new `alwaysAfterFirstValidation` mode (the new default)
- Fix: apply Google Font to Material text theme

## 0.6.1

- Remove `ShadButtonSize.icon`. Now by default, when the `icon` is provided and the `text` is not, the button will use the `icon` size.

## 0.6.0

- Add `ShadTabs` component
- Add `ShadColorScheme.fromName` to easily create a color scheme from a name (String)
- Add `package` to `ShadImage` (thanks to @farhanfadila1717)
- Fix `decoration` of form fields
- Fix selection controls of `ShadInput`

## 0.5.7

- Renamed the breakpoints
- Add `context.breakpoint` extension

## 0.5.6

- Fix mismatch of `childAlignment` and `overlayAlignment` in `ShadPortal`
- Remove top padding of `ShadPopover`
- Set default values to `ShadAnchor` and `ShadAnchorAuto`

## 0.5.5

- Remove `inputDecoration` from form fields.
- Fix `ShadApp` default dark theme.

## 0.5.4

- Fix double padding on form fields.

## 0.5.3

- Update dependencies
- Removed deprecated parameters `checkerboard...` from `ShadApp`

## 0.5.2

- Fix `onTap` not working in `ShadInput` and `ShadInputFormField`

## 0.5.1

- Fix `ShadInputFormField` which disposed the controller being passed to it.
- Add `scrollable` and `scrollPadding` to `ShadDialog` and `ShadSheet`. By default, the dialogs and sheets are scrollable and the viewInsets are the default scroll padding.

## 0.5.0

- Add the `ShadSelect.withSearch` constructor to easily add a search input to the select component.

## 0.4.7

- Add `maintainState` to `ShadAccordion` to keep the child in the tree even if the item is closed, defaults to `false`.
- Update `ShadAccordion` to use `effects` instead of `transitionBuilder`.
- Remove `rive` dependency and Rive support in `ShadImage` due to many issues with the package.
- Remove `colorScheme` from `ShadTextTheme`. Now the colors will be automatically derived, unless specified.
- Fix popover position in `ShadSelect` component.
- Refactor `ShadDecoration` to easily change the default borders and add new decoration properties to it. Some properties have been moved from the components to the `decoration` of the component.
- Fix `ShadTable` row indexes when using an `headerBuilder` (thanks to @Kyziq).

## 0.4.6

- Update depencencies versions
- Remove `ShadSameWidthColumn` component
- Remove boxy dependency
- Make components keyboard accessible

## 0.4.5

- Remove `placeholderStyle` and `placeholderAlignment` from `ShadDecoration` and move to `ShadInput` and `ShadInputFormField`
- Add `suffix` and `prefix` to `ShadInput` and `ShadInputFormField`

## 0.4.4

- Add `horizontalScrollPhysics` and `verticalScrollPhysics` to `ShadTable`
- Add `mainAxisAlignment` and `crossAxisAlignment` to `ShadButton`
- Fix `ShadDialog` content adding default text style
- Remove popover asserts and ignore operation if already opened/closed.
- Add `longPressDuration` to `ShadGestureDetector`
- Add `hoverStrategies` to ShadButtonTheme's
- Fix use `strutStyle` in `ShadInput`
- Add `backgroundColor` to `ShadInput` and `ShadInputFormField` (thanks to @Dredayduncan)
- Remove `inputDecoration` from `ShadInput`
- Put `placeholder` on top of `ShadInput`
- Fix text style alignment

## 0.4.3

- Fix `ShadResizable` divider position

## 0.4.2

- Add `ShadGestureDetector` with hover strategies for touchscreens.
- Add `ShadTooltipController` to `ShadTooltip`.
- Increase the divider size in the `ShadResizable` component.

## 0.4.1

- Expose `ShadResizableTheme`.

## 0.4.0

- Add `ShadResizable` component

## 0.3.3

- Improve pub dev score

## 0.3.2

- Fix `preferBelow` default value for `ShadSelect` and `ShadPopover`

## 0.3.1

- Add `ShadAnchorAuto` to `ShadPortal`, to automatically adjust the position of the overlay. This applies to all components that use `ShadPortal`, like `ShadSelect`, `ShadTooltip`, `ShadPopover`.

## 0.3.0

- Add `ShadTable` component
- Improved `ShadInput` placeholder alignment

## 0.2.6

- Fix buttons state not updated correctly
- Remove `ShadAssets` in favor of `LucideIcons`

## 0.2.5

- Add `width` and `height` to `ShadCard`
- Add `leading` and `trailing` to `ShadCard`

## 0.2.4

- Add workaround for google_fonts issue about font weights. see <https://github.com/material-foundation/flutter-packages/issues/35>
- Make `from` of `ShadTextTheme.fromGoogleFont` unnamed.

## 0.2.3

- Expose `ShadTextTheme`
- Fix `ShadTextTheme` to add ability to change font family
- Add `materialThemeBuilder` to default `ShadApp`
- Add `ShadTextTheme.fromGoogleFont` to use a Google Font

## 0.2.2

- Fix lerp of `ShadDecoration` and `ShadBorder`
- Add `ShadDecoration.none` and `ShadBorder.none`

## 0.2.1

- Fix export of color schemes (thanks to @Pietervdw)

## 0.2.0

- Add `materialThemeBuilder` and `cupertinoThemeBuilder` to `ShadApp`
- Fix `readOnly` for `ShadInput`
- Fix `initialValue` for `ShadInputFormField`
- Rename `AnimatedShadTheme` into `ShadAnimatedTheme`

## 0.1.0

- new `ShadProgress` component
- new `ShadAccordion` component
- new `ShadSheet` component
- add `onLongPress` to buttons
- add `ShadStatesController` to buttons
- update `showShadDialog`
- set toast default animations based on alignment
- change toast default offset
- add Material and Cupertino constructors in `ShadApp`

## 0.0.1-dev1

- First development release

## 0.0.0

- Initial commit
