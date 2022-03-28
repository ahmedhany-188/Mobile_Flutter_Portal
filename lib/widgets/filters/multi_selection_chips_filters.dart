import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectionChipsFilters extends StatefulWidget {
  List<dynamic> selectedFilterForRemove = [];
  List<dynamic> filtersList;
  String filterName;
  String listKey;
  List<dynamic> initialValue;
  ValueSetter<List<dynamic>>? filterData;

  MultiSelectionChipsFilters(
      this.filtersList, this.filterName, this.listKey, this.initialValue,
      {Key? key, this.filterData})
      : super(key: key);

  @override
  State<MultiSelectionChipsFilters> createState() =>
      _ExpandedListViewForFilters();
}

class _ExpandedListViewForFilters extends State<MultiSelectionChipsFilters> {
  @override
  Widget build(BuildContext context) {
    final _items = widget.filtersList
        .map((String) => MultiSelectItem(String, String))
        .toList();

    return MultiSelectBottomSheetField(
      items: _items,
      onSaved: (itemsListSelected) {},
      title: Text(widget.filterName.toUpperCase()),
      searchable: true,
      listType: MultiSelectListType.CHIP,
      chipDisplay: MultiSelectChipDisplay(
        scrollBar: HorizontalScrollBar(isAlwaysShown: true),
        scroll: true,
        onTap: (item) {
          setState(() {
            widget.selectedFilterForRemove.remove(item);
          });
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.red,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          width: 2,
        ),
      ),
      buttonIcon: const Icon(
        Icons.filter_list_alt,
      ),
      buttonText: Text(
        "Filter by ${widget.filterName.toLowerCase()}...",
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      onConfirm: (selectedFilters) {
        widget.selectedFilterForRemove = selectedFilters;
        if (selectedFilters.isNotEmpty) {
          widget.filterData!(selectedFilters);
        } else {}
      },
      initialValue: widget.initialValue,
    );
  }
}
