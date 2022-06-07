import '../../data/models/contacts_related_models/contacts_data_from_api.dart';

class SearchForContacts {
  List<ContactsDataFromApi> contactSearchResultsList = [];

  List<ContactsDataFromApi> setSearchFromApiList({
    required String query,
    required String listKeyForCondition,
    required List<ContactsDataFromApi> listFromApi,
  }) {
    var splitQuery = query.toLowerCase().trim().split(' ');
    return contactSearchResultsList = listFromApi
        .where((contactElement) => splitQuery.every(
              (singleSplitElement) => contactElement.name
                  .toString()
                  .toLowerCase()
                  .trim()
                  .contains(singleSplitElement),
            ))
        .toList()
      ..sort((a, b) {
        int indexOfSearchQueryA =
            a.name.toString().toLowerCase().trim().indexOf(query.trim());
        int indexOfSearchQueryB =
            b.name.toString().toLowerCase().trim().indexOf(query.trim());
        if (indexOfSearchQueryA > indexOfSearchQueryB) {
          return -1;
        } else if (indexOfSearchQueryA == indexOfSearchQueryB &&
            a.name.toString().toLowerCase().trim().hashCode <=
                b.name.toString().toLowerCase().trim().hashCode) {
          return -1;
        }
        return 1;
      });
  }

  // List<ContactsDataFromApi> setSearchForFilters({
  //   required String query,
  //   required String listKeyForCondition,
  //   required List<ContactsDataFromApi> listFromApi,
  // }) {
  //   var splitQuery = query.toLowerCase().trim().split('');
  //   return contactSearchResultsList = listFromApi
  //       .where((contactElement) => splitQuery.every(
  //             (singleSplitElement) => contactElement.titleName
  //                 .toString()
  //                 .toLowerCase()
  //                 .trim()
  //                 .contains(singleSplitElement),
  //           ))
  //       .toList();
  // }

  List<ContactsDataFromApi> setSearchForFilters({
    required String? query,
    required int listKeyForCondition,
    required List<ContactsDataFromApi> listFromApi,
  }) {
    var splitQuery = query!.toLowerCase().trim().split('');

    return contactSearchResultsList = listFromApi
        .where((contactElement) => splitQuery.every((singleSplitElement) {
              switch (listKeyForCondition) {
                case 0:
                  return (contactElement.companyName)
                      .toString()
                      .toLowerCase()
                      .trim()
                      .contains(singleSplitElement);
                case 1:
                  return (contactElement.projectName)
                      .toString()
                      .toLowerCase()
                      .trim()
                      .contains(singleSplitElement);
                case 2:
                  return (contactElement.mainDepartment)
                      .toString()
                      .toLowerCase()
                      .trim()
                      .contains(singleSplitElement);
                case 3:
                  return (contactElement.titleName)
                      .toString()
                      .toLowerCase()
                      .trim()
                      .contains(singleSplitElement);
              }
              return false;
            }))
        .toList();
  }
}
