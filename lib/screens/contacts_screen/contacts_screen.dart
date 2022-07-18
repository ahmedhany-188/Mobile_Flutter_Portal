import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/contacts_screen_bloc/contacts_filters_cubit.dart';
import '../../screens/contacts_screen/contacts_widget.dart';
import '../../bloc/contacts_screen_bloc/contacts_cubit.dart';
import '../../widgets/filters/multi_selection_chips_filters.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  // static final UniqueKey uniqueKey = UniqueKey();
  TextEditingController textController = TextEditingController();
  FocusNode textFoucus = FocusNode();

  _showDialogAndGetFiltersResults(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (c) => BlocProvider<ContactsFiltersCubit>.value(
        value: ContactsFiltersCubit.get(context),
        child: Dialog(
          elevation: 10,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
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
                      leadingWidth: 110,
                      leading: MaterialButton(
                        onPressed: () {
                          ContactsFiltersCubit.get(context).onClearDialog();
                        },
                        splashColor: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.01),
                        child: const Text(
                          'Clear Filters',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      actions: [
                        MaterialButton(
                          onPressed: () {
                            ContactsFiltersCubit.get(context).checkAllFilters();
                            Navigator.pop(context);
                          },
                          textColor: Colors.white,
                          splashColor: Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.01),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          child: const Text(
                            'Done',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    // BlocBuilder<ContactsFiltersCubit, ContactsFiltersInitial>(
                    //   builder: (context, state) {
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BlocBuilder<ContactsFiltersCubit,
                              ContactsFiltersInitial>(
                            buildWhen: (previous, current) {
                              return previous.chosenCompaniesFilter !=
                                  current.chosenCompaniesFilter;
                            },
                            builder: (cubitContext, state) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: MultiSelectionChipsFilters(
                                  filtersList: ContactsCubit.get(context)
                                      .state
                                      .companiesFilter,
                                  filterName: 'Company',
                                  initialValue: state.chosenCompaniesFilter,
                                  onTap: (item) {
                                    ContactsFiltersCubit.get(cubitContext)
                                        .chosenCompaniesOptions([
                                      ...state.chosenCompaniesFilter
                                    ]..remove(item));
                                  },
                                  onConfirm: (selectedFilters) {
                                    ContactsFiltersCubit.get(context)
                                        .chosenCompaniesOptions(selectedFilters
                                            .map((e) => e.toString())
                                            .toList());
                                  },
                                ),
                              );
                            },
                          ),
                          BlocBuilder<ContactsFiltersCubit,
                              ContactsFiltersInitial>(
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: MultiSelectionChipsFilters(
                                  filtersList: ContactsCubit.get(context)
                                      .state
                                      .projectsFilter,
                                  filterName: 'Project',
                                  onConfirm: (selectedFilters) {
                                    ContactsFiltersCubit.get(context)
                                        .chosenProjectsOptions(selectedFilters
                                            .map((e) => e.toString())
                                            .toList());
                                  },
                                  initialValue: state.chosenProjectsFilter,
                                  onTap: (item) {
                                    ContactsFiltersCubit.get(context)
                                        .chosenProjectsOptions([
                                      ...state.chosenProjectsFilter
                                    ]..remove(item));
                                  },
                                ),
                              );
                            },
                          ),
                          BlocBuilder<ContactsFiltersCubit,
                              ContactsFiltersInitial>(
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: MultiSelectionChipsFilters(
                                  filtersList: ContactsCubit.get(context)
                                      .state
                                      .departmentFilter,
                                  filterName: 'Department',
                                  initialValue: state.chosenDepartmentFilter,
                                  onConfirm: (selectedFilters) {
                                    ContactsFiltersCubit.get(context)
                                        .chosenDepartmentsOptions(
                                            selectedFilters
                                                .map((e) => e.toString())
                                                .toList());
                                  },
                                  onTap: (item) {
                                    ContactsFiltersCubit.get(context)
                                        .chosenDepartmentsOptions([
                                      ...state.chosenDepartmentFilter
                                    ]..remove(item));
                                  },
                                ),
                              );
                            },
                          ),
                          BlocBuilder<ContactsFiltersCubit,
                              ContactsFiltersInitial>(
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: MultiSelectionChipsFilters(
                                  filtersList: ContactsCubit.get(context)
                                      .state
                                      .titleFilter,
                                  filterName: 'Title',
                                  onConfirm: (selectedFilters) {
                                    ContactsFiltersCubit.get(context)
                                        .chosenTitlesOptions(selectedFilters
                                            .map((e) => e.toString())
                                            .toList());
                                  },
                                  initialValue: state.chosenTitleFilter,
                                  onTap: (item) {
                                    ContactsFiltersCubit.get(context)
                                        .chosenTitlesOptions([
                                      ...state.chosenTitleFilter
                                    ]..remove(item));
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(textController.text.isEmpty){
      ContactsCubit.get(context).getAllContacts();
    }
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: BlocProvider<ContactsCubit>.value(
        value: ContactsCubit.get(context),
        child: BlocBuilder<ContactsCubit, ContactCubitStates>(
          builder: (context, state) {
            if (state.contactStates == ContactsEnumStates.success ||
                state.contactStates == ContactsEnumStates.filtered) {
              return BlocProvider(
                create: (filtersContext) => ContactsFiltersCubit(
                  ContactsCubit.get(context).state.listContacts,
                ),
                child: SizedBox(
                  height: deviceSize.height,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(
                          parent: NeverScrollableScrollPhysics()),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      dragStartBehavior: DragStartBehavior.down,
                      child: Column(
                        children: [
                          BlocConsumer<ContactsFiltersCubit,
                              ContactsFiltersInitial>(
                            listener: (filtersCubitContext, filtersCubitState) {
                              if (filtersCubitState.isFiltered) {
                                ContactsCubit.get(context).updateContacts(
                                    filtersCubitState.listContacts);
                              }
                            },
                            builder: (ctx, state) {

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      focusNode: textFoucus,
                                      // key: uniqueKey,
                                      controller: textController,
                                      onChanged: (text) {
                                        ContactsFiltersCubit.get(ctx)
                                            .writenTextSearch(text);
                                      },
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(10),
                                          isCollapsed: true,
                                          filled: true,
                                          labelText: "Search contact",
                                          hintText: "Search contact",
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide.none)),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          ContactsFiltersCubit.get(ctx)
                                              .updateFilters();
                                          _showDialogAndGetFiltersResults(ctx);
                                        },
                                        label: const Text('Filter Contacts'),
                                        icon: const Icon(
                                          Icons.filter_list_alt,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton.icon(
                                        onPressed: (state.isFiltered == false &&
                                                textController.text.isEmpty)
                                            ? null
                                            : () {
                                                ContactsFiltersCubit.get(ctx)
                                                    .onClearData();
                                                textController.clear();
                                                textFoucus.unfocus();
                                              },
                                        label: const Text('Clear Filters'),
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          Scrollbar(
                            child:
                                BlocBuilder<ContactsCubit, ContactCubitStates>(
                              builder: (context, state) {
                                return SizedBox(
                                  height: deviceSize.height * 0.64,
                                  child: (state.contactStates ==
                                          ContactsEnumStates.success)
                                      ? ContactsWidget(state.listContacts)
                                      : ContactsWidget(state.tempList),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
