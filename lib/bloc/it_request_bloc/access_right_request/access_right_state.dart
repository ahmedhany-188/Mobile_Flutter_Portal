part of 'access_right_cubit.dart';

@immutable
abstract class AccessRightState extends Equatable{

  const AccessRightState();

  const AccessRightState.copyWith({
    required RequestDate requestItems,required FormzStatus status,required });
}

class AccessRightInitial extends Equatable {
  const AccessRightInitial({
    this.requestStatus = RequestStatus.newRequest,
    this.requestDate = const RequestDate.pure(),
    this.requestType = 1,
    this.requestItems = const RequestDate.pure(),
    this.requestItemsList = const [],
    this.fromDate = const RequestDate.pure(),
    this.toDate = const RequestDate.pure(),
    this.permanent = false,
    this.usbException = false,
    this.vpnAccount = false,
    this.ipPhone = false,
    this.localAdmin = false,
    this.comments = "",
    this.filePDF = "",
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.takeActionStatus,
    this.statusAction,
    this.requesterData = EmployeeData.empty,
    this.actionComment = "",
    this.extension = "",
    this.chosenFileName = "",
    this.fileResult = const FilePickerResult([]),

  });

  final RequestDate requestDate;
  final int requestType;
  final RequestDate requestItems;
  final List<String> requestItemsList;
  final RequestDate fromDate;
  final RequestDate toDate;
  final bool permanent;
  final bool usbException;
  final bool vpnAccount;
  final bool ipPhone;
  final bool localAdmin;

  final String comments;
  final String filePDF;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;
  final RequestStatus? requestStatus;
  final TakeActionStatus? takeActionStatus;
  final String? statusAction;

  final EmployeeData requesterData;
  final String actionComment;

  final String extension;
  final String chosenFileName;
  final FilePickerResult fileResult;


  @override
  List<Object> get props =>
      [
        requestDate,
        requestItems,
        fromDate,
        toDate,
        status,
        requestType,
        permanent,
        usbException,
        localAdmin,
        vpnAccount,
        ipPhone,
        comments,
        requestItemsList,
        requesterData,
        actionComment,
        extension,
        chosenFileName,
        fileResult,
      ];

  AccessRightInitial copyWith({
    RequestDate ?requestDate,
    int ?requestType,
    RequestDate ?requestItems,
    List<String> ?requestItemsList,
    RequestDate ?fromDate,
    RequestDate ?toDate,
    bool ?permanent,
    bool ?usbException,
    bool ?vpnAccount,
    bool ?ipPhone,
    bool ?localAdmin,
    String ?comments,
    String ?filePDF,
    FormzStatus ?status,
    String? errorMessage,
    String? successMessage,
    TakeActionStatus? takeActionStatus,
    RequestStatus? requestStatus,
    String? statusAction,
    EmployeeData? requesterData,
    String? actionComment,
    String? extension,
    String? chosenFileName,
    FilePickerResult? fileResult,


  }) {
    return AccessRightInitial(
      requestDate: requestDate ?? this.requestDate,
      requestType: requestType ?? this.requestType,
      requestItems: requestItems ?? this.requestItems,
      requestItemsList: requestItemsList ?? this.requestItemsList,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      permanent: permanent ?? this.permanent,
      usbException: usbException ?? this.usbException,
      vpnAccount: vpnAccount ?? this.vpnAccount,
      ipPhone: ipPhone ?? this.ipPhone,
      localAdmin: localAdmin ?? this.localAdmin,
      comments: comments ?? this.comments,
      filePDF: filePDF ?? this.filePDF,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      requestStatus: requestStatus ?? this.requestStatus,
      takeActionStatus: takeActionStatus ?? this.takeActionStatus,
      statusAction: statusAction ?? this.statusAction,
      requesterData: requesterData ?? this.requesterData,
      actionComment: actionComment ?? this.actionComment,
      extension: extension ?? this.extension,
      chosenFileName: chosenFileName ?? this.chosenFileName,
      fileResult: fileResult ?? this.fileResult,


    );
  }

}
