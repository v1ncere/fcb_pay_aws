import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  UpdatePasswordBloc() : super(const UpdatePasswordState()) {
    on<UpdateCurrentPasswordChanged>(_onUpdateCurrentPasswordChanged);
    on<UpdateNewPasswordChanged>(_onUpdateNewPasswordChanged);
    on<UpdateConfirmNewPasswordChanged>(_onUpdateConfirmNewPasswordChanged);
    on<UpdateCurrentPasswordObscured>(_onUpdateCurrentPasswordObscured);
    on<UpdateNewPasswordObscured>(_onUpdateNewPasswordObscured);
    on<UpdateConfirmNewPasswordObscured>(_onUpdateConfirmNewPasswordObscured);
    on<PasswordUpdateSubmitted>(_onPasswordUpdateSubmitted);
  }

  void _onUpdateCurrentPasswordChanged(UpdateCurrentPasswordChanged event, Emitter<UpdatePasswordState> emit) {
    final currentPassword = Password.dirty(event.currentPassword);
    emit(state.copyWith(currentPassword: currentPassword));
  }

  void _onUpdateNewPasswordChanged(UpdateNewPasswordChanged event, Emitter<UpdatePasswordState> emit) {
    final newPassword = Password.dirty(event.newPassword);
    emit(state.copyWith(newPassword: newPassword));
  }

  void _onUpdateConfirmNewPasswordChanged(UpdateConfirmNewPasswordChanged event, Emitter<UpdatePasswordState> emit) {
    final confirmPassword = ConfirmedPassword.dirty(password: state.newPassword.value, value: event.confirmPassword);
    emit(state.copyWith(confirmNewPassword: confirmPassword));
  }

  void _onUpdateCurrentPasswordObscured(UpdateCurrentPasswordObscured event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isCurrentPasswordObscure: !state.isCurrentPasswordObscure));
  }

  void _onUpdateNewPasswordObscured(UpdateNewPasswordObscured event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isNewPasswordObscure: !state.isNewPasswordObscure));
  }

  void _onUpdateConfirmNewPasswordObscured(UpdateConfirmNewPasswordObscured event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isConfirmNewPasswordObscure: !state.isConfirmNewPasswordObscure));
  }

  Future<void> _onPasswordUpdateSubmitted(PasswordUpdateSubmitted event, Emitter<UpdatePasswordState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    if (state.isValid) {
      try {
        await Amplify.Auth.updatePassword(oldPassword: state.currentPassword.value, newPassword: state.newPassword.value);
      } on AuthException catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure,  message: e.message));
      }
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        message: 'Please complete all required fields before submitting your form. Thank you!'
      ));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }
}
