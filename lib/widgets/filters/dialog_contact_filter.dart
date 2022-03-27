import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/filters_categories.dart';
import 'multi_selection_chips_filters.dart';


class DialogContactFilter extends StatefulWidget {
  static const routeName = 'dialog';
  List<dynamic> contactListFromApi;

  DialogContactFilter(this.contactListFromApi, {Key? key}) : super(key: key);

  @override
  State<DialogContactFilter> createState() => _DialogContactFilterState();
}

class _DialogContactFilterState extends State<DialogContactFilter> {
  List<dynamic> companiesFilterResultsList = [];
  var companiesNamesFromApiMap = <String>{};

  List<dynamic> projectFilterResultsList = [];
  var projectNamesFromApiMap = <String>{};

  List<dynamic> titleFilterResultsList = [];
  var titleNamesFromApiMap = <String>{};

  List<dynamic> departmentFilterResultsList = [];
  var departmentNamesFromApiMap = <String>{};

  void companiesNamesData() {
    companiesFilterResultsList = widget.contactListFromApi
        .where(
            (element) => companiesNamesFromApiMap.add(element['companyName']))
        .toList();
    companiesFilterResultsList = companiesNamesFromApiMap.toList();
  }

  void projectNamesData() {
    projectFilterResultsList = widget.contactListFromApi
        .where((element) => projectNamesFromApiMap.add(element['projectName']))
        .toList();
    projectFilterResultsList = projectNamesFromApiMap.toList();
  }

  void titleNamesData() {
    titleFilterResultsList = widget.contactListFromApi
        .where((element) => titleNamesFromApiMap.add(element['titleName']))
        .toList();
    titleFilterResultsList = titleNamesFromApiMap.toList();
  }

  void departmentNamesData() {
    departmentFilterResultsList = widget.contactListFromApi
        .where((element) =>
            departmentNamesFromApiMap.add(element['mainDepartment']))
        .toList();
    departmentFilterResultsList = departmentNamesFromApiMap.toList();
  }

  @override
  void initState() {
    companiesNamesData();
    projectNamesData();
    titleNamesData();
    departmentNamesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var filtersFromExpandedList = FiltersCategories(
        companiesFilter: [],
        projectsFilter: [],
        departmentFilter: [],
        titleFilter: []);
    return Dialog(
      elevation: 10,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: deviceSize.height * .45,
          width: deviceSize.width,
          color: Theme.of(context).colorScheme.background,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 10,
                  title: const Text(
                    'Filters',
                  ),
                  centerTitle: true,
                  leadingWidth: 80,
                  leading: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context, []);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    splashColor: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.01),
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        /// TODO: Save filters data
                        Navigator.pop(context, [
                          filtersFromExpandedList.companiesFilter,
                          filtersFromExpandedList.projectsFilter,
                          filtersFromExpandedList.departmentFilter,
                          filtersFromExpandedList.titleFilter,
                        ]);
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),
                      ),
                      textColor: Colors.white,
                      splashColor: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.01),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  height: deviceSize.height * .37,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: MultiSelectionChipsFilters(
                            companiesFilterResultsList,
                            'Company',
                            'companyName',
                            filtersFromExpandedList.companiesFilter,
                            filterData: (newFilter) {
                              filtersFromExpandedList.companiesFilter =
                                  newFilter;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: MultiSelectionChipsFilters(
                            projectFilterResultsList,
                            'Project',
                            'projectName',
                            filtersFromExpandedList.projectsFilter,
                            filterData: (newFilter) {
                              filtersFromExpandedList.projectsFilter =
                                  newFilter;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: MultiSelectionChipsFilters(
                            departmentFilterResultsList,
                            'Department',
                            'mainDepartment',
                            filtersFromExpandedList.departmentFilter,
                            filterData: (newFilter) {
                              filtersFromExpandedList.departmentFilter =
                                  newFilter;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: MultiSelectionChipsFilters(
                            titleFilterResultsList,
                            'Title',
                            'titleName',
                            filtersFromExpandedList.titleFilter,
                            filterData: (newFilter) {
                              filtersFromExpandedList.titleFilter = newFilter;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
