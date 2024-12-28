part of 'account_button_bloc.dart';

sealed class AccountButtonEvent extends Equatable {
  const AccountButtonEvent();

  @override
  List<Object> get props => [];
}

final class ButtonsFetched extends AccountButtonEvent {
  const ButtonsFetched(this.type);
  final String type;

  @override
  List<Object> get props => [type];
}