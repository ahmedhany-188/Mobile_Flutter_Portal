import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

import '../../bloc/contacts_screen_bloc/contacts_cubit.dart';
import '../../bloc/contacts_screen_bloc/contacts_filters_cubit.dart';
import '../../screens/contacts_screen/contacts_widget.dart';
import '../../widgets/filters/multi_selection_chips_filters.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);
  static const routeName = 'contacts-screen';

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen>
    with TickerProviderStateMixin {
  TextEditingController textController = TextEditingController();
  FocusNode textFoucus = FocusNode();

  _showDialogAndGetFiltersResults(BuildContext context) {
    showBottomSheet(
      context: context,
      enableDrag: true,
      clipBehavior: Clip.none,
      backgroundColor: Colors.transparent,
      transitionAnimationController:
          BottomSheet.createAnimationController(this),
      builder: (_) => BlocProvider<ContactsFiltersCubit>.value(
        value: ContactsFiltersCubit.get(context),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
              color: ConstantsColors.bottomSheetBackgroundDark,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    'Filters',
                  ),
                  centerTitle: true,
                  leadingWidth: 130,
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
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                BlocBuilder<ContactsFiltersCubit, ContactsFiltersInitial>(
                  buildWhen: (previous, current) {
                    return previous.chosenCompaniesFilter !=
                        current.chosenCompaniesFilter;
                  },
                  builder: (cubitContext, state) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MultiSelectionChipsFilters(
                        filtersList:
                            ContactsCubit.get(context).state.companiesFilter,
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
                BlocBuilder<ContactsFiltersCubit, ContactsFiltersInitial>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MultiSelectionChipsFilters(
                        filtersList:
                            ContactsCubit.get(context).state.projectsFilter,
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
                BlocBuilder<ContactsFiltersCubit, ContactsFiltersInitial>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MultiSelectionChipsFilters(
                        filtersList:
                            ContactsCubit.get(context).state.departmentFilter,
                        filterName: 'Department',
                        initialValue: state.chosenDepartmentFilter,
                        onConfirm: (selectedFilters) {
                          ContactsFiltersCubit.get(context)
                              .chosenDepartmentsOptions(selectedFilters
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
                BlocBuilder<ContactsFiltersCubit, ContactsFiltersInitial>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MultiSelectionChipsFilters(
                        filtersList:
                            ContactsCubit.get(context).state.titleFilter,
                        filterName: 'Title',
                        onConfirm: (selectedFilters) {
                          ContactsFiltersCubit.get(context).chosenTitlesOptions(
                              selectedFilters
                                  .map((e) => e.toString())
                                  .toList());
                        },
                        initialValue: state.chosenTitleFilter,
                        onTap: (item) {
                          ContactsFiltersCubit.get(context).chosenTitlesOptions(
                              [...state.chosenTitleFilter]..remove(item));
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Contacts List'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: BlocProvider<ContactsCubit>.value(
            value: ContactsCubit.get(context),
            child: BlocBuilder<ContactsCubit, ContactCubitStates>(
              buildWhen: (pre, curr) {
                if (curr.contactStates == ContactsEnumStates.success ||
                    curr.contactStates == ContactsEnumStates.filtered) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state.contactStates == ContactsEnumStates.success ||
                    state.contactStates == ContactsEnumStates.filtered) {
                return BlocProvider(
                  create: (filtersContext) => ContactsFiltersCubit(
                    ContactsCubit.get(context).state.listContacts,
                  ),
                  child: Column(
                    children: [
                      BlocConsumer<ContactsFiltersCubit,
                          ContactsFiltersInitial>(
                        listener: (filtersCubitContext, filtersCubitState) {
                          if (filtersCubitState.isFiltered) {
                            ContactsCubit.get(context).updateContacts(
                                filtersCubitState.listContacts);
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                              if(filtersCubitState.listContacts.length > 1){
                                ContactsWidget.scrollToTop();
                              }
                            });

                          }
                        },
                        builder: (ctx, state) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  focusNode: textFoucus,
                                  // key: uniqueKey,
                                  controller: textController,

                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  onChanged: (text) {
                                    ContactsFiltersCubit.get(ctx)
                                        .writenTextSearch(text);
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.all(10),
                                      filled: true,
                                      focusColor: Colors.white,
                                      fillColor: Colors.grey.shade400
                                          .withOpacity(0.4),
                                      // labelText: "Search contact",
                                      hintText: 'Name or HR Code',
                                      hintStyle: const TextStyle(
                                          color: Colors.white),
                                      prefixIcon: const Icon(Icons.search,
                                          color: Colors.white),
                                      border: const OutlineInputBorder(
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
                                    style: ElevatedButton.styleFrom(
                                      disabledForegroundColor: Colors.white70,
                                    ),
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
                      Expanded(
                        child: Scrollbar(
                          child:
                              BlocBuilder<ContactsCubit, ContactCubitStates>(
                            builder: (context, state) {
                              return
                              //   (state.contactStates == ContactsEnumStates.initial)?
                              // const Center(child: CircularProgressIndicator(color: Colors.white),):
                                (ContactsFiltersCubit.get(context)
                                        .state
                                        .isFiltered)
                                    ? ContactsWidget(state.tempList)
                                    : ContactsWidget(state.listContacts);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.white70,));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
