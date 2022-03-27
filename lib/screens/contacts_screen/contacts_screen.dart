import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/contacts_screen_bloc/contacts_bloc_states.dart';
import 'package:hassanallamportalflutter/bloc/contacts_screen_bloc/contacts_cubit.dart';
import 'package:hassanallamportalflutter/data/models/filters_categories.dart';
import 'package:hassanallamportalflutter/widgets/filters/dialog_contact_filter.dart';

import 'contacts_widget.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  FocusNode searchTextFieldFocusNode = FocusNode();
  TextEditingController textController = TextEditingController();

  bool isTypingFilterSet = false;
  List<dynamic> filtersDataSavedFromDialog = [];

  FiltersCategories filtersCategoriesObject = FiltersCategories(
      companiesFilter: [],
      projectsFilter: [],
      departmentFilter: [],
      titleFilter: []);

  @override
  void initState() {
    contactListFromApi;
    textController;
    searchTextFieldFocusNode;
    contactSearchResultsList;
    super.initState();
  }

  _showDialogAndGetFiltersResults(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: false,
          builder: (context) => DialogContactFilter(contactListFromApi)),
    );
    // showDialog(
    //   context: context,
    //   barrierDismissible: true,
    //   builder: (context) =>DialogContactFilter(contactListFromApi),
    //   useRootNavigator: true,
    // );
    setState(() {
      filtersDataSavedFromDialog = result;
      filtersCategoriesObject.companiesFilter = result[0];
      filtersCategoriesObject.projectsFilter = result[1];
      filtersCategoriesObject.departmentFilter = result[2];
      filtersCategoriesObject.titleFilter = result[3];
      print(filtersCategoriesObject.companiesFilter);


    });

    return DialogContactFilter(contactListFromApi);
  }

  var contactListFromApi = [];
  List<dynamic> contactSearchResultsList = [];

  void setSearchFromApiList(
    String query,
    String listKeyForCondition,
    List<dynamic> listFromApi, {
    String? searchFilterCompanyName,
    String? searchFilterTitleName,
    List<dynamic>? searchFilterProjectName,
    List<dynamic>? searchFilterDepartmentName,
  }) {
    var splitQuery = query.toLowerCase().trim().split(' ');

    contactSearchResultsList = listFromApi
        .where((contactElement) => splitQuery.every((singleSplitElement) =>
            contactElement[listKeyForCondition]
                .toString()
                .toLowerCase()
                .trim()
                .contains(singleSplitElement)))
        .toList()
      ..sort((a, b) {
        int indexOfSearchQueryA = a[listKeyForCondition]
            .toString()
            .toLowerCase()
            .trim()
            .indexOf(query.trim());
        int indexOfSearchQueryB = b[listKeyForCondition]
            .toString()
            .toLowerCase()
            .trim()
            .indexOf(query.trim());
        if (indexOfSearchQueryA > indexOfSearchQueryB) {
          return -1;
        } else if (indexOfSearchQueryA == indexOfSearchQueryB &&
            a[listKeyForCondition].toString().toLowerCase().trim().hashCode <=
                b[listKeyForCondition]
                    .toString()
                    .toLowerCase()
                    .trim()
                    .hashCode) {
          return -1;
        }
        return 1;
      });
  }

  @override
  Widget build(BuildContext context) {
    contactListFromApi = ContactsCubit.get(context).contacts;
    var deviceSize = MediaQuery.of(context).size;
    // filtersDataSavedFromDialog = [];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocProvider<ContactsCubit>(
        create: (context) => ContactsCubit()..getContacts(),
        child: BlocConsumer<ContactsCubit, ContactsBlocStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return SizedBox(
                height: deviceSize.height,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: NeverScrollableScrollPhysics()),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    dragStartBehavior: DragStartBehavior.down,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            focusNode: searchTextFieldFocusNode,
                            controller: textController,
                            onSubmitted: (searchValue) {
                              searchTextFieldFocusNode.unfocus();
                              setState(() {
                                print(filtersDataSavedFromDialog);
                              });
                            },
                            onChanged: (_) {
                              setState(() {
                                setSearchFromApiList(
                                  textController.text,
                                  'name',
                                  contactListFromApi,
                                );
                                (textController.text.isEmpty)
                                    ? isTypingFilterSet = false
                                    : isTypingFilterSet = true;
                              });
                            },
                            decoration: const InputDecoration(
                                labelText: "Search contact",
                                hintText: "Search contact",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0)))),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                (state is BlocGetContactsLoadingState)
                                    ? null
                                    : _showDialogAndGetFiltersResults(context);
                                // showDialog(
                                //     context: context,
                                //     barrierDismissible: true,
                                //     builder: (context) =>
                                //         DialogContactFilter(
                                //             contactListFromApi),
                                //   );
                              },
                              label: const Text('Filter Contacts'),
                              icon: const Icon(
                                Icons.filter_list_alt,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed: isTypingFilterSet ||
                                      filtersDataSavedFromDialog.isNotEmpty
                                  ? () {
                                      setState(() {
                                        textController.clear();
                                        filtersDataSavedFromDialog.clear();
                                        isTypingFilterSet = false;
                                      });
                                    }
                                  : null,
                              label: const Text('Clear Filters'),
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: deviceSize.height * 0.64,
                          child: textController.text.isEmpty
                              ? ContactsWidget(contactListFromApi)
                              : ContactsWidget(contactSearchResultsList),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
