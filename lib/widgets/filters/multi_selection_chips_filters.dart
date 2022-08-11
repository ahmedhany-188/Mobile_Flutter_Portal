import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectionChipsFilters extends StatelessWidget {
  final List<String> filtersList;
  final String filterName;
  final List<String> initialValue;
  final Function(List<Object?>) onConfirm;
  final Function(Object?) onTap;

  const MultiSelectionChipsFilters({
    Key? key,
    required this.filtersList,
    required this.filterName,
    required this.initialValue,
    required this.onConfirm,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items =
        filtersList.map((string) => MultiSelectItem(string, string)).toList();

    return MultiSelectBottomSheetField(
      key: GlobalKey(),
      items: items,
      searchTextStyle: const TextStyle(color: Colors.white),
      searchIcon: const Icon(Icons.search, color: Colors.white),
      closeSearchIcon: const Icon(Icons.close, color: Colors.white),
      onConfirm: onConfirm,
      confirmText: const Text(
        'OK',
        style: TextStyle(color: Colors.white),
      ),
      cancelText: const Text(
        'CANCEL',
        style: TextStyle(color: Colors.white),
      ),
      searchHintStyle: const TextStyle(color: Colors.white),
      unselectedColor: Colors.white,
      selectedColor: ConstantsColors.bottomSheetBackground,
      initialValue: initialValue,
      searchable: true,
      backgroundColor: ConstantsColors.bottomSheetBackground,
      listType: MultiSelectListType.LIST,
      title: Text(filterName.toUpperCase(),
          style: const TextStyle(color: Colors.white)),
      itemsTextStyle: const TextStyle(color: Colors.white),
      selectedItemsTextStyle:
          const TextStyle(color: ConstantsColors.greenAttendance),
      chipDisplay: MultiSelectChipDisplay(
        scrollBar: HorizontalScrollBar(isAlwaysShown: true),
        scroll: true,
        chipColor: ConstantsColors.greenAttendance,
        textStyle: const TextStyle(color: Colors.black),
        onTap: onTap,
        icon: const Icon(
          Icons.clear,
          color: Colors.red,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 1, color: Colors.white),
      ),
      buttonIcon: const Icon(
        Icons.filter_list_alt,
        color: Colors.white,
      ),
      buttonText: Text(
        "Filter by ${filterName.toLowerCase()}...",
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }
}
