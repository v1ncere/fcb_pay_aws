/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the AccountButton type in your schema. */
class AccountButton extends amplify_core.Model {
  static const classType = const _AccountButtonModelType();
  final String? _type;
  final List<Button>? _buttons;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => modelIdentifier.serializeAsString();
  
  AccountButtonModelIdentifier get modelIdentifier {
    try {
      return AccountButtonModelIdentifier(
        type: _type!
      );
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get type {
    try {
      return _type!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Button>? get buttons {
    return _buttons;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const AccountButton._internal({required type, buttons, createdAt, updatedAt}): _type = type, _buttons = buttons, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory AccountButton({required String type, List<Button>? buttons}) {
    return AccountButton._internal(
      type: type,
      buttons: buttons != null ? List<Button>.unmodifiable(buttons) : buttons);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountButton &&
      _type == other._type &&
      DeepCollectionEquality().equals(_buttons, other._buttons);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("AccountButton {");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  AccountButton copyWith({List<Button>? buttons}) {
    return AccountButton._internal(
      type: type,
      buttons: buttons ?? this.buttons);
  }
  
  AccountButton copyWithModelFieldValues({
    ModelFieldValue<List<Button>?>? buttons
  }) {
    return AccountButton._internal(
      type: type,
      buttons: buttons == null ? this.buttons : buttons.value
    );
  }
  
  AccountButton.fromJson(Map<String, dynamic> json)  
    : _type = json['type'],
      _buttons = json['buttons']  is Map
        ? (json['buttons']['items'] is List
          ? (json['buttons']['items'] as List)
              .where((e) => e != null)
              .map((e) => Button.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['buttons'] is List
          ? (json['buttons'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Button.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'type': _type, 'buttons': _buttons?.map((Button? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'type': _type,
    'buttons': _buttons,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<AccountButtonModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<AccountButtonModelIdentifier>();
  static final TYPE = amplify_core.QueryField(fieldName: "type");
  static final BUTTONS = amplify_core.QueryField(
    fieldName: "buttons",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Button'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "AccountButton";
    modelSchemaDefinition.pluralName = "AccountButtons";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["type"], name: null)
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: AccountButton.TYPE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: AccountButton.BUTTONS,
      isRequired: false,
      ofModelName: 'Button',
      associatedKey: Button.ACCOUNTBUTTON
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _AccountButtonModelType extends amplify_core.ModelType<AccountButton> {
  const _AccountButtonModelType();
  
  @override
  AccountButton fromJson(Map<String, dynamic> jsonData) {
    return AccountButton.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'AccountButton';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [AccountButton] in your schema.
 */
class AccountButtonModelIdentifier implements amplify_core.ModelIdentifier<AccountButton> {
  final String type;

  /** Create an instance of AccountButtonModelIdentifier using [type] the primary key. */
  const AccountButtonModelIdentifier({
    required this.type});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'type': type
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'AccountButtonModelIdentifier(type: $type)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is AccountButtonModelIdentifier &&
      type == other.type;
  }
  
  @override
  int get hashCode =>
    type.hashCode;
}