import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(const DropdownState(status: Status.loading)) {
    on<DropdownFetched>(_onDropdownFetched);
  }

  Future<void> _onDropdownFetched(DropdownFetched event, Emitter<DropdownState> emit) async {
    try {
      final request = ModelQueries.list(DynamicModel.classType, where: DynamicModel.REFERENCE.eq(event.reference));
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;
      
      if (items != null && items.isNotEmpty) {
        final dynamicModels = items.whereType<DynamicModel>().toList();
        final rawData = dynamicModels.first.data;
        // parse the JSON string into a map
        final Map<String, dynamic> parsedData = jsonDecode(rawData);
        // Safely extract string values
        final newData = parsedData.values.whereType<String>().toList();
        emit(state.copyWith(status: Status.success, dropdowns: newData));
      } else {
        emit(state.copyWith(status: Status.failure, message: TextString.empty));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
