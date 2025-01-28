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


/** This is an auto generated class representing the PublicAccount type in your schema. */
class PublicAccount extends amplify_core.Model {
  static const classType = const _PublicAccountModelType();
  final String? _accountNumber;
  final bool? _isExisted;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => modelIdentifier.serializeAsString();
  
  PublicAccountModelIdentifier get modelIdentifier {
    try {
      return PublicAccountModelIdentifier(
        accountNumber: _accountNumber!
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
  
  String get accountNumber {
    try {
      return _accountNumber!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get isExisted {
    try {
      return _isExisted!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const PublicAccount._internal({required accountNumber, required isExisted, createdAt, updatedAt}): _accountNumber = accountNumber, _isExisted = isExisted, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory PublicAccount({required String accountNumber, required bool isExisted}) {
    return PublicAccount._internal(
      accountNumber: accountNumber,
      isExisted: isExisted);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicAccount &&
      _accountNumber == other._accountNumber &&
      _isExisted == other._isExisted;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("PublicAccount {");
    buffer.write("accountNumber=" + "$_accountNumber" + ", ");
    buffer.write("isExisted=" + (_isExisted != null ? _isExisted!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  PublicAccount copyWith({bool? isExisted}) {
    return PublicAccount._internal(
      accountNumber: accountNumber,
      isExisted: isExisted ?? this.isExisted);
  }
  
  PublicAccount copyWithModelFieldValues({
    ModelFieldValue<bool>? isExisted
  }) {
    return PublicAccount._internal(
      accountNumber: accountNumber,
      isExisted: isExisted == null ? this.isExisted : isExisted.value
    );
  }
  
  PublicAccount.fromJson(Map<String, dynamic> json)  
    : _accountNumber = json['accountNumber'],
      _isExisted = json['isExisted'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'accountNumber': _accountNumber, 'isExisted': _isExisted, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'accountNumber': _accountNumber,
    'isExisted': _isExisted,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<PublicAccountModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<PublicAccountModelIdentifier>();
  static final ACCOUNTNUMBER = amplify_core.QueryField(fieldName: "accountNumber");
  static final ISEXISTED = amplify_core.QueryField(fieldName: "isExisted");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "PublicAccount";
    modelSchemaDefinition.pluralName = "PublicAccounts";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        provider: amplify_core.AuthRuleProvider.IAM,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["accountNumber"], name: null)
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PublicAccount.ACCOUNTNUMBER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PublicAccount.ISEXISTED,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
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

class _PublicAccountModelType extends amplify_core.ModelType<PublicAccount> {
  const _PublicAccountModelType();
  
  @override
  PublicAccount fromJson(Map<String, dynamic> jsonData) {
    return PublicAccount.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'PublicAccount';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [PublicAccount] in your schema.
 */
class PublicAccountModelIdentifier implements amplify_core.ModelIdentifier<PublicAccount> {
  final String accountNumber;

  /** Create an instance of PublicAccountModelIdentifier using [accountNumber] the primary key. */
  const PublicAccountModelIdentifier({
    required this.accountNumber});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'accountNumber': accountNumber
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'PublicAccountModelIdentifier(accountNumber: $accountNumber)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is PublicAccountModelIdentifier &&
      accountNumber == other.accountNumber;
  }
  
  @override
  int get hashCode =>
    accountNumber.hashCode;
}