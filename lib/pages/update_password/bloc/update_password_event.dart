part of 'update_password_bloc.dart';

sealed class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object> get props => [];
}

final class UpdateCurrentPasswordChanged extends UpdatePasswordEvent {
  const UpdateCurrentPasswordChanged(this.currentPassword);
  final String currentPassword;

  @override
  List<Object> get props => [currentPassword];
}

final class UpdateNewPasswordChanged extends UpdatePasswordEvent {
  const UpdateNewPasswordChanged(this.newPassword);
  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

final class UpdateConfirmNewPasswordChanged extends UpdatePasswordEvent {
  const UpdateConfirmNewPasswordChanged(this.confirmPassword);
  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

final class UpdateCurrentPasswordObscured extends UpdatePasswordEvent {}

final class UpdateNewPasswordObscured extends UpdatePasswordEvent {}

final class UpdateConfirmNewPasswordObscured extends UpdatePasswordEvent {}

final class PasswordUpdateSubmitted extends UpdatePasswordEvent {}