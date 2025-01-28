import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'widgets_event.dart';
part 'widgets_state.dart';

class WidgetsBloc extends Bloc<WidgetsEvent, WidgetsState> {
  WidgetsBloc({
    required HiveRepository hiveRepository,
  }) : _hiveRepository = hiveRepository,
  super(const WidgetsState()) {
    on<WidgetsFetched>(_onWidgetsFetched);
    on<UserIdFetched>(_onUserIdFetched);
    on<ExtraWidgetFetched>(_onExtraWidgetFetched);
    on<DynamicWidgetsValueChanged>(_onDynamicWidgetsValueChanged);
    on<ExtraWidgetsValueChanged>(_onExtraWidgetValueChanged);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }
  final HiveRepository _hiveRepository;

  // fetched the user id from aws
  Future<void> _onUserIdFetched(UserIdFetched event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(userIdStatus: Status.loading));
    try {
      final user = await Amplify.Auth.getCurrentUser();
      emit(state.copyWith(userIdStatus: Status.success, uid: user.userId));
    } on AuthException catch (e) {
      emit(state.copyWith(userIdStatus: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(userIdStatus: Status.failure, message: e.toString()));
    }
  }

  // 'button' is the parent of the 'widget' on the dynamic display
  Future<void> _onWidgetsFetched(WidgetsFetched event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(widgetStatus: Status.loading));
    try {
      final request = ModelQueries.list(DynamicWidget.classType, where: DynamicWidget.BUTTON.eq(event.id));
      final response = await Amplify.API.query(request: request).response;
      final data = response.data?.items;

      if (data != null && data.isNotEmpty) {
        List<DynamicWidget> widgetList = data.whereType<DynamicWidget>().toList();
        bool hasData = await _dropdownHasData(widgetList);
        // get the button widget
        final buttonWidget = widgetList.firstWhere((e) => e.widgetType == 'button');
        // get the non button widgets
        final otherWidget = widgetList.where((e) => e.widgetType != 'button').toList();
        // sort widgets base on the [position]
        otherWidget.sort((a, b) => a.position!.compareTo(b.position!));
        // combine all the lists, put the button widget at the end of the list.
        final sortedWidgets = [...otherWidget, buttonWidget];
        // emit state
        emit(state.copyWith(widgetStatus: Status.success, widgetList: sortedWidgets, dropdownHasData: hasData));
      } else {
        emit(state.copyWith(widgetStatus: Status.failure, message: TextString.empty));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(widgetStatus: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(widgetStatus: Status.failure, message: TextString.empty));
    }
  }

  // fetch extra widget
  void _onExtraWidgetFetched(ExtraWidgetFetched event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(extraWidgetStatus: Status.loading));
    try {
      // get the extra widgets base on the institution dropdown selection
      final request = ModelQueries.list(DynamicWidget.classType, where: DynamicWidget.INSTITUTIONEXTRAWIDGET.eq(event.id));
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;

      if(items != null && items.isNotEmpty) {
        final extraWidgetList = items.whereType<DynamicWidget>().toList();
        extraWidgetList.sort((a, b) => a.position!.compareTo(b.position!));
        emit(state.copyWith(extraWidgetStatus: Status.success, extraWidgetList: extraWidgetList));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(extraWidgetStatus: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(extraWidgetStatus: Status.failure, message: emptyTextSelectionControls.toString()));
    }
  }

  // dynamic widget value changed
  void _onDynamicWidgetsValueChanged(DynamicWidgetsValueChanged event, Emitter<WidgetsState> emit) {
    // locate the [index] of the widget by matching the id in the widgetList.
    final index = state.widgetList.indexWhere((e) => e.id == event.id);
    // check if a widget with a matching id was found. [-1 means not found] 
    if (index != -1) {
      // create a copy of the current widgetList to update.
      final updatedUserWidget = List<DynamicWidget>.from(state.widgetList);
      // update the widget at the located index with the new content value.
      updatedUserWidget[index] = updatedUserWidget[index].copyWith(content: event.value); 
      emit(state.copyWith(widgetList: updatedUserWidget));
    }
  }

  // extra widget value changed
  void _onExtraWidgetValueChanged(ExtraWidgetsValueChanged event, Emitter<WidgetsState> emit) {
    // locate the [index] of the widget by matching the id in the List.
    final index = state.extraWidgetList.indexWhere((e) => e.id == event.keyId);
    // check if a widget with a matching id was found. [-1 means not found] 
    if (index != -1) {
      // create a copy of the current List
      final updatedExtraWidget = List<DynamicWidget>.from(state.extraWidgetList);
      // update the widget at the located index with the new content value.
      updatedExtraWidget[index] = updatedExtraWidget[index].copyWith(content: event.value); 
      emit(state.copyWith(extraWidgetList: updatedExtraWidget));
    }
  }

  // 
  FutureOr<void> _onButtonSubmitted(ButtonSubmitted event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(submissionStatus: Status.loading));
    if(_areWidgetsValid(state.widgetList) && _areWidgetsValid(state.extraWidgetList)) {
      try {
        String dynamicWidget = _widgetDataMap(state.widgetList).entries.map((e) { // all entries from the map
          return "${e.key}:${e.value.replaceAll(',', '')}"; // return formatted entries into <key>:<value> pair
        }).join(','); // join all entries into a string separated by a comma (",")

        String extraWidget = _widgetDataMap(state.extraWidgetList).entries.map((e) { // transform list into map
          return "${e.key}:${e.value.replaceAll(',', '')}"; // return  into key value pair
        }).join(','); // join all entries into a string separated by comma

        final dynamicWidgetsResult = _containsWidget(state.widgetList) ? '|$dynamicWidget' : '';
        final extraWidgetsResult = _containsWidget(state.extraWidgetList) ? '|$extraWidget' : '';

        // request title, 
        final reqTitle = event.title.trim().replaceAll(' ', '_').toLowerCase();

        // data send to the api
        final data = '$reqTitle$dynamicWidgetsResult$extraWidgetsResult';
        
        final request = ModelMutations.create(Request(
          data: data,
          details: reqTitle,
          verifier: hashSha1(encryption('$data$reqTitle${state.uid}')),
          owner: state.uid,
        ));
        final response = await Amplify.API.mutate(request: request).response;
        
        if(response.hasErrors) {
          emit(state.copyWith(submissionStatus: Status.failure, message: response.errors.first.message));
        } else {
          // id saved into local storage [hive] to locate receipt
          _hiveRepository.addId(response.data!.id);
          emit(state.copyWith(submissionStatus: Status.success));
        }
      } on ApiException catch (e) {
        emit(state.copyWith(submissionStatus: Status.failure, message: e.message));
      } catch (e) {
        emit(state.copyWith(submissionStatus: Status.failure, message: e.toString()));
      }
    } else {
      emit(state.copyWith(submissionStatus: Status.failure, message: TextString.incompleteForm));
    }
    emit(state.copyWith(submissionStatus: Status.initial));
  }

  // UTILITY FUNCTIONS =========================================================
  
  // check if list contains 'textfield' or 'dropdown' widget
  bool _containsWidget<T extends dynamic>(List<T> list) {
    return list.any((e) => e.widget == 'textfield' || e.widget == 'dropdown');
  }

  // check all widgets if valid
  bool _areWidgetsValid<T extends dynamic>(List<T> list) {
    // regex for validating an [int] or [double with 2 decimal points]
    final regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');
    // [STRING TEXTFIELD] match in the list
    final stringTextfield = list.where((e) => e.widget == 'textfield' && e.dataType == 'string');
    // [DOUBLE TEXTFIELD] match in the list
    final intTextfield = list.where((e) => e.widget == 'textfield' && e.dataType == 'int');
    // [STRING DROPDOWN] match in the list
    final stringDropdown = list.where((e) => e.widget == 'dropdown' && e.dataType == 'string');
    // [INT DROPDOWN] match in the list
    final intDropdown = list.where((e) => e.widget == 'dropdown' && e.dataType == 'int');
    // [STRING TEXTFIELD] exists [OR] contains data
    final isStringTextfieldValid = stringTextfield.isEmpty || stringTextfield.every((e) => e.content?.isNotEmpty == true);
    // [DOUBLE TEXTFIELD] exists [OR] contains data [AND] is valid [int/double]
    final isIntTextfieldValid = intTextfield.isEmpty || intTextfield.every((e) => e.content?.isNotEmpty == true && regex.hasMatch(e.content!));
    // [STRING DROPDOWN] exists [OR] contains data
    final isStringDropdownValid = stringDropdown.isEmpty || stringDropdown.every((e) => e.content?.isNotEmpty == true);
    // [INT DROPDOWN] exists [OR] contains data
    final isIntDropdownValid = intDropdown.isEmpty || intDropdown.every((e) => e.content?.isNotEmpty == true);
    // RETURN RESULT
    return isStringTextfieldValid && isIntTextfieldValid && isStringDropdownValid && isIntDropdownValid;
  }

  // formatting dynamic list [content] into Map
  Map<String, String> _widgetDataMap<T extends dynamic>(List<T> list) {
    final Map<String, String> map = {};
    for (final e in list) {
      if (e.widget == 'textfield' || e.widget == 'dropdown' || e.widget == 'multitextfield') {
        map[e.title] = e.content!; // store content into map
      }
    }
    return map;
  }

  // check for empty dropdown data
  Future<bool> _dropdownHasData(List<DynamicWidget> widgetList) async {
    // mapped the widgetList for dropdown && not user_account
    final dropdownList = widgetList.where((e) {
      return e.widgetType == 'dropdown' && !e.node!.contains('user_account');
    }).toList();
    //
    if (dropdownList.isNotEmpty) {
      for (final dropdown in dropdownList) {
        final ref = dropdown.node!.replaceAll('{id}', state.uid);
        if(ref.isNotEmpty) {
          final request = ModelQueries.list(Account.classType, where: Account.OWNER.eq(state.uid));
          final response = await Amplify.API.query(request: request).response;
          final data = response.data?.items;

          if(data == null || data.isEmpty) {
            return false;
          }
        }
      }
    }
    return true;
  }
}
