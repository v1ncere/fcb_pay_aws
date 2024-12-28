part of 'widgets_bloc.dart';

class WidgetsState extends Equatable {
  const WidgetsState({
    this.widgetList = const <DynamicWidget>[],
    this.extraWidgetList = const <DynamicWidget>[],
    this.uid = '',
    this.userIdStatus = Status.initial,
    this.widgetStatus = Status.initial,
    this.extraWidgetStatus = Status.initial,
    this.submissionStatus = Status.initial,
    this.message = '',
    this.dropdownHasData = true,
  });
  final List<DynamicWidget> widgetList;
  final List<DynamicWidget> extraWidgetList;
  final String uid;
  final Status userIdStatus;
  final Status widgetStatus;
  final Status extraWidgetStatus;
  final Status submissionStatus;
  final String message;
  final bool dropdownHasData;

  WidgetsState copyWith({
    List<DynamicWidget>? widgetList,
    List<DynamicWidget>? extraWidgetList,
    String? uid,
    Status? userIdStatus,
    Status? widgetStatus,
    Status? extraWidgetStatus,
    Status? submissionStatus,
    String? message,
    bool? dropdownHasData,
  }) {
    return WidgetsState(
      widgetList: widgetList ?? this.widgetList,
      widgetStatus: widgetStatus ?? this.widgetStatus,
      uid: uid ?? this.uid,
      userIdStatus: userIdStatus ?? this.userIdStatus,
      extraWidgetList: extraWidgetList ?? this.extraWidgetList,
      extraWidgetStatus: extraWidgetStatus ?? this.extraWidgetStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      message: message ?? this.message,
      dropdownHasData: dropdownHasData ?? this.dropdownHasData,
    );
  }
  
  @override
  List<Object?> get props => [
    widgetList,
    extraWidgetList,
    uid,
    userIdStatus,
    widgetStatus,
    extraWidgetStatus,
    submissionStatus,
    dropdownHasData,
  ];
}