part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.status = LogStatus.initial,
  });
  final LogStatus status;

  AppState copyWith({
    LogStatus? status,
  }) {
    return AppState(
      status: status ?? this.status
    );
  }
  
  @override
  List<Object> get props => [status];
}

enum LogStatus { initial, unauthenticated, authenticated, unknown }

extension LogStausX on LogStatus {
  bool get isInitial => this == LogStatus.initial;
  bool get isUnauthenticated => this == LogStatus.unauthenticated;
  bool get isAuthenticated => this == LogStatus.authenticated;
  bool get isFailure => this == LogStatus.unknown;
}