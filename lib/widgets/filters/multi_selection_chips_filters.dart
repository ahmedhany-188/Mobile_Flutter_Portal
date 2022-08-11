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
      searchTextStyle: TextStyle(color: Colors.white),
      searchIcon: Icon(Icons.search,color: Colors.white),
      closeSearchIcon: Icon(Icons.close,color: Colors.white),
      onConfirm: onConfirm,
      initialValue: initialValue,
      searchable: true,
      backgroundColor: ConstantsColors.bottomSheetBackground,
      listType: MultiSelectListType.LIST,
      title:
          Text(filterName.toUpperCase(), style: TextStyle(color: Colors.white)),
      itemsTextStyle: TextStyle(color: Colors.white),
      selectedItemsTextStyle: TextStyle(color: ConstantsColors.greenAttendance),
      chipDisplay: MultiSelectChipDisplay(
        scrollBar: HorizontalScrollBar(isAlwaysShown: true),
        scroll: true,
        chipColor: ConstantsColors.greenAttendance,
        textStyle: TextStyle(color: Colors.black),
        onTap: onTap,
        icon: const Icon(
          Icons.clear,
          color: Colors.red,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 2, color: Colors.white),
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
