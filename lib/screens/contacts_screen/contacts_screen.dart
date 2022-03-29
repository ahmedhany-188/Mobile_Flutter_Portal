import 'dart:core';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/contacts_screen_bloc/contacts_bloc_states.dart';
import '../../bloc/contacts_screen_bloc/contacts_cubit.dart';
import '../../data/models/contacts_related_models/filters_categories.dart';
import '../../screens/contacts_screen/search_for_contacts.dart';
import '../../widgets/filters/dialog_contact_filter.dart';
import '../../screens/contacts_screen/contacts_widget.dart';

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

  _showDialogAndGetFiltersResults(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => DialogContactFilter(contactListFromApi),
      useRootNavigator: true,
    ).then((result) {
      setState(() {
        filtersDataSavedFromDialog = result;
        filtersCategoriesObject.companiesFilter = result[0];
        filtersCategoriesObject.projectsFilter = result[1];
        filtersCategoriesObject.departmentFilter = result[2];
        filtersCategoriesObject.titleFilter = result[3];

        contactSearchResultsList = SearchForContacts().setSearchForFilters(
          query: filtersCategoriesObject.companiesFilter[0],
          listKeyForCondition: 'companyName',
          listFromApi: contactListFromApi,
        );
      });
    });
  }

  var contactListFromApi = [];
  List<dynamic> contactSearchResultsList = [];

  @override
  Widget build(BuildContext context) {
    contactListFromApi = ContactsCubit.get(context).contacts;
    var deviceSize = MediaQuery.of(context).size;
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
                            print(filtersDataSavedFromDialog);
                            setState(() {});
                          },
                          onChanged: (_) {
                            setState(() {
                              contactSearchResultsList =
                                  SearchForContacts().setSearchFromApiList(
                                query: textController.text,
                                listKeyForCondition: 'name',
                                listFromApi: contactSearchResultsList,
                              );
                              (textController.text.toString().isEmpty)
                                  ? isTypingFilterSet = false
                                  : isTypingFilterSet = true;
                            });
                          },
                          decoration: const InputDecoration(
                              labelText: "Search contact",
                              hintText: "Search contact",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)))),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: (state is BlocGetContactsLoadingState)
                                ? null
                                : () {
                                    setState(() {
                                      _showDialogAndGetFiltersResults(context);
                                    });
                                  },
                            label: const Text('Filter Contacts'),
                            icon: const Icon(
                              Icons.filter_list_alt,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: isTypingFilterSet ||
                                    filtersDataSavedFromDialog.isNotEmpty
                                ? () {
                                    setState(() {
                                      textController.clear();
                                      searchTextFieldFocusNode.unfocus();
                                      filtersDataSavedFromDialog.clear();

                                      filtersCategoriesObject.companiesFilter
                                          .clear();
                                      filtersCategoriesObject.projectsFilter
                                          .clear();
                                      filtersCategoriesObject.departmentFilter
                                          .clear();
                                      filtersCategoriesObject.titleFilter
                                          .clear();
                                      contactSearchResultsList.clear();

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
                        child: (textController.text.isEmpty &&
                                filtersDataSavedFromDialog.isEmpty)
                            ? ContactsWidget(contactListFromApi)
                            : ContactsWidget(contactSearchResultsList),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
