class SearchForContacts {
  List<dynamic> contactSearchResultsList = [];

  List<dynamic> setSearchFromApiList({
    required String query,
    required String listKeyForCondition,
    required List<dynamic> listFromApi,
  }) {
    var splitQuery = query.toLowerCase().trim().split(' ');
    return contactSearchResultsList = listFromApi
        .where((contactElement) => splitQuery.every(
              (singleSplitElement) => contactElement[listKeyForCondition]
                  .toString()
                  .toLowerCase()
                  .trim()
                  .contains(singleSplitElement),
            ))
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

  List<dynamic> setSearchForFilters({
    required String query,
    required String listKeyForCondition,
    required List<dynamic> listFromApi,
  }) {
    var splitQuery = query.toLowerCase().trim().split('');
    return contactSearchResultsList = listFromApi
        .where((contactElement) => splitQuery.every(
              (singleSplitElement) => contactElement[listKeyForCondition]
                  .toString()
                  .toLowerCase()
                  .trim()
                  .contains(singleSplitElement),
            ))
        .toList();
  }
}
