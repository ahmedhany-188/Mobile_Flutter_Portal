import 'package:authentication_repository/authentication_repository.dart';

class MainUserData{
  final User? user;
  final EmployeeData? employeeData;
  const MainUserData({this.employeeData,this.user});

  /// Empty user which represents an unauthenticated user.
  static  const MainUserData empty = MainUserData(employeeData: EmployeeData.empty,user: User.empty);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MainUserData.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MainUserData.empty;
}