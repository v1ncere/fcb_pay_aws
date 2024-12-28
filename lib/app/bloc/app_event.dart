part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class LoginChecked extends AppEvent {}

final class LoggedOut extends AppEvent {}