import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repository/repository.dart';
import '../../../utils/utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends HydratedBloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AmplifyAuth amplifyAuth,
    required AmplifyStorage amplifyStorage,
  }) : _amplifyAuth = amplifyAuth,
  _amplifyStorage = amplifyStorage,
  super(SignUpState(
    emailController: TextEditingController(),
    firstNameController: TextEditingController(),
    lastNameController: TextEditingController(),
    mobileController: TextEditingController(),
    usernameController: TextEditingController(),
    passwordController: TextEditingController(),
    confirmPasswordController: TextEditingController(),
  )) {
    on<EmailChanged>(_onEmailChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<UserImageChanged>(_onUserImageChanged);
    //
    on<LostDataRetrieved>(_onLostDataRetrieved);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    //
    on<EmailTextErased>(_onEmailTextErased);
    on<FirstNameTextErased>(_onFirstNameTextErased);
    on<LastNameTextErased>(_onLastNameTextErased);
    on<MobileTextErased>(_onMobileTextErased);
    on<UsernameTextErased>(_onUsernameTextErased);
    on<PasswordTextErased>(_onPasswordTextErased);
    on<ConfirmPasswordTextErased>(_onConfirmPasswordTextErased);
    //
    on<PasswordObscured>(_onPasswordObscured);
    on<ConfirmPasswordObscured>(_onConfirmPasswordObscured);
    //
    on<FormSubmitted>(_onFormSubmitted);
    on<HandleSignUp>(_onHandleSignUp);
    on<HandleSignupResult>(_onHandleSignupResult);
    on<ImageUploadProgressed>(_onImageUploadProgressed);
    on<AuthSignupStepConfirmed>(_onAuthSignupStepConfirmed);
    on<AuthSignupStepDone>(_onAuthSignupStepDone);
    on<HydrateStateChanged>(_onHydrateStateChanged);
  }
  final TextRecognizer textRecognizer = TextRecognizer();
  final ImagePicker _picker = ImagePicker();
  final AmplifyAuth _amplifyAuth;
  final AmplifyStorage _amplifyStorage;

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: Email.dirty(event.email)));
  }
  
  void _onFirstNameChanged(FirstNameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(firstName: Name.dirty(event.firstName)));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(lastName: Name.dirty(event.lastName)));
  }

  void _onMobileNumberChanged(MobileNumberChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(mobile: MobileNumber.dirty(event.mobile)));
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(username: Username.dirty(event.username)));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: Password.dirty(event.password)));
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(confirmPassword: ConfirmedPassword.dirty(password: event.password, value: event.confirmPassword)));
  }

  Future<void> _onUserImageChanged(UserImageChanged event, Emitter<SignUpState> emit) async {
    try {
      emit(state.copyWith(imageStatus: Status.loading));
      if (await _isScannedTextExists(event.image)) {
        emit(state.copyWith(imageStatus: Status.success, userImage: event.image));
      } else {
        emit(state.copyWith(imageStatus: Status.failure, message: TextString.imageError));
      }
    } catch (e) {
      emit(state.copyWith(imageStatus: Status.failure, message: TextString.error));
    }
  }

  Future<void> _onLostDataRetrieved(LostDataRetrieved events, Emitter<SignUpState> emit) async {
    try {
      final response = await _picker.retrieveLostData();
      if (response.isEmpty) {
        return;
      }
      //
      emit(state.copyWith(imageStatus: Status.loading));
      final file = response.file;
      if (file != null) {
        if (await _isScannedTextExists(file)) {
          emit(state.copyWith(imageStatus: Status.success, userImage: file));
        } else {
          emit(state.copyWith(imageStatus: Status.failure, message: TextString.invalidImage));
        }
      } else {
        emit(state.copyWith(imageStatus: Status.failure, message: response.exception!.code));
      }
    } catch (e) {
      emit(state.copyWith(imageStatus: Status.failure, message: TextString.error));
    }
  }

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(accountNumber: event.accountNumber));
  }

  void _onEmailTextErased(EmailTextErased event, Emitter<SignUpState> emit) {
    state.emailController.clear();
    emit(state.copyWith(email: const Email.pure()));
  }

  void _onFirstNameTextErased(FirstNameTextErased event, Emitter<SignUpState> emit) {
    state.firstNameController.clear();
    emit(state.copyWith(firstName: const Name.pure()));
  }

  void _onLastNameTextErased(LastNameTextErased event, Emitter<SignUpState> emit) {
    state.lastNameController.clear();
    emit(state.copyWith(lastName: const Name.pure()));
  }

  void _onMobileTextErased(MobileTextErased event, Emitter<SignUpState> emit) {
    state.mobileController.clear();
    emit(state.copyWith(mobile: const MobileNumber.pure()));
  }
  
  void _onUsernameTextErased(UsernameTextErased event, Emitter<SignUpState> emit) {
    state.usernameController.clear();
    emit(state.copyWith(username: const Username.pure()));
  }

  void _onPasswordTextErased(PasswordTextErased event, Emitter<SignUpState> emit) {
    state.passwordController.clear();
    emit(state.copyWith(password: const Password.pure()));
  }

  void _onConfirmPasswordTextErased(ConfirmPasswordTextErased event, Emitter<SignUpState> emit) {
    state.confirmPasswordController.clear();
    emit(state.copyWith(confirmPassword: const ConfirmedPassword.pure(password: '')));
  }

  void _onPasswordObscured(PasswordObscured event, Emitter<SignUpState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onConfirmPasswordObscured(ConfirmPasswordObscured event, Emitter<SignUpState> emit) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword)); 
  }

  // ====================================================================================
  void _onImageUploadProgressed(ImageUploadProgressed event, Emitter<SignUpState> emit) {
    emit(state.copyWith(progress: event.progress));
  } 

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<SignUpState> emit) async {
    try {
      final image = state.userImage;
      if (image == null) {
        return;
      }
      // emit loading
      emit(state.copyWith(status: Status.loading));
      final result = await _amplifyStorage.uploadFile(
        localFile: AWSFile.fromPath(image.path),
        path: StoragePath.fromString('picture-submission/${_fileName(image)}'), // path must be edited in resource
        onProgress: (progress) {
          emit(state.copyWith(status: Status.progress));
          final total = progress.transferredBytes / progress.totalBytes;
          add(ImageUploadProgressed(total));
        }
      );
      // handle sign-up
      add(HandleSignUp(result.uploadedItem.path));
    } on StorageException catch (e) {
      _emitErrorAndReset(emit, e.message);
    } catch (e) {
      _emitErrorAndReset(emit, TextString.error);
    }
  }

  Future<void> _onHandleSignUp(HandleSignUp event, Emitter<SignUpState> emit) async {
    try {
      // emit progress
      emit(state.copyWith(status: Status.loading));
      final result = await _amplifyAuth.signUpUser(
        username: state.email.value.trim(),
        password: state.password.value.trim(),
        userAttributes: {
          AuthUserAttributeKey.email: state.email.value.trim(),
          AuthUserAttributeKey.phoneNumber: '+63${state.mobile.value.trim()}',
          AuthUserAttributeKey.familyName: state.lastName.value.trim(),
          AuthUserAttributeKey.givenName: state.firstName.value.trim(),
          AuthUserAttributeKey.profile: event.url,
        }
      );
      if (result != null) {
        add(const HydrateStateChanged(isHydrated: false));
        add(HandleSignupResult(result));
      } else {
        _emitErrorAndReset(emit, TextString.error);
      }
    } on AuthException catch (e) {
      _emitErrorAndReset(emit, e.message);
    } catch (e) {
      _emitErrorAndReset(emit, TextString.error);
    }
  }

  Future<void> _onHandleSignupResult(HandleSignupResult event, Emitter<SignUpState> emit) async {
    final steps = event.result.nextStep.signUpStep;
    switch(steps) {
      case AuthSignUpStep.confirmSignUp:
        add(AuthSignupStepConfirmed(event.result));
        break;
      case AuthSignUpStep.done:
        add(AuthSignupStepDone(event.result));
        break;
    }
  }

  void _onAuthSignupStepConfirmed(AuthSignupStepConfirmed event, Emitter<SignUpState> emit) {
    final details = event.result.nextStep.codeDeliveryDetails!;
    emit(state.copyWith(
      status: Status.canceled,
      message: 'A confirmation code has been sent to ${details.destination}. '
      'Please check your ${details.deliveryMedium.name} for the code.'
    ));
  }

  void _onAuthSignupStepDone(AuthSignupStepDone event, Emitter<SignUpState> emit) {
    emit(state.copyWith(status: Status.success, message: 'Sign up is complete'));
  }

  void _onHydrateStateChanged(HydrateStateChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(isHydrated: event.isHydrated));
  }

  // UTILITY METHODS ===========================================================
  // ===========================================================================
  void _emitErrorAndReset(Emitter<SignUpState> emit, String message) {
    emit(state.copyWith(status: Status.failure, message: message));
    emit(state.copyWith(status: Status.initial));
  }

  String _fileName(XFile image) {
    final type = image.path.split('.').last;
    final email = state.email.value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    final username = state.username.value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    return "$email-$username.$type";
  }

  Future<bool> _isScannedTextExists(XFile image) async {
    final recognizedText = await textRecognizer.processImage(InputImage.fromFilePath(image.path));
    await textRecognizer.close();
    final fcb = _isTextExist(recognizedText, 'FIRST CONSOLIDATED BANK');
    final pitakard = _isTextExist(recognizedText, 'PITAKArd');
    // final account = _isTextExist(recognizedText, '6064 29');
    final account = _isTextExist(recognizedText, state.accountNumber);
    return fcb && pitakard && account;
  }

  bool _isTextExist(RecognizedText recognized, String text) {
    for (TextBlock block in recognized.blocks) {
      for (TextLine line in block.lines) {
        if (line.text.contains(text)) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Future<void> close() async {
    state.emailController.dispose();
    state.firstNameController.dispose();
    state.lastNameController.dispose();
    state.mobileController.dispose();
    state.usernameController.dispose();
    state.passwordController.dispose();
    state.confirmPasswordController.dispose();
    return super.close();
  }
  
  @override
  SignUpState? fromJson(Map<String, dynamic> json) {
    final isHydrated = json['hydrate'] as bool;
    return isHydrated
    ? state.copyWith(
        emailController: TextEditingController()..text = json['email'] as String,
        firstNameController: TextEditingController()..text = json['first_name'] as String,
        lastNameController: TextEditingController()..text = json['last_name'] as String,
        mobileController: TextEditingController()..text = json['mobile_number'] as String,
        usernameController: TextEditingController()..text = json['user_name'] as String,
        passwordController: TextEditingController()..text = json['password'] as String,
        confirmPasswordController:TextEditingController()..text = json['confirm_password'] as String,
        //
        email: Email.dirty(json['email'] as String),
        firstName: Name.dirty(json['first_name'] as String),
        lastName:  Name.dirty(json['last_name'] as String),
        mobile: MobileNumber.dirty(json['mobile_number'] as String),
        username: Username.dirty(json['user_name'] as String),
        password: Password.dirty(json['password'] as String),
        confirmPassword: ConfirmedPassword.dirty(password: json['password'] as String, value: json['confirm_password'] as String),
        isHydrated: isHydrated
      )
    : state.copyWith(isHydrated: false);
  }
  
  @override
  Map<String, dynamic>? toJson(SignUpState state) {
    return state.isHydrated
    ? {
        'email': state.email.value,
        'first_name': state.firstName.value,
        'last_name': state.lastName.value,
        'mobile_number': state.mobile.value,
        'user_name': state.username.value,
        'password': state.password.value,
        'confirm_password': state.confirmPassword.value,
        'hydrate': state.isHydrated
      }
    : { 'hydrate': false };
  }
}
