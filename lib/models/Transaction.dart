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


/** This is an auto generated class representing the Transaction type in your schema. */
class Transaction extends amplify_core.Model {
  static const classType = const _TransactionModelType();
  final String id;
  final String? _accountNumber;
  final String? _accountType;
  final String? _details;
  final String? _owner;
  final Account? _account;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TransactionModelIdentifier get modelIdentifier {
      return TransactionModelIdentifier(
        id: id
      );
  }
  
  String? get accountNumber {
    return _accountNumber;
  }
  
  String? get accountType {
    return _accountType;
  }
  
  String? get details {
    return _details;
  }
  
  String? get owner {
    return _owner;
  }
  
  Account? get account {
    return _account;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Transaction._internal({required this.id, accountNumber, accountType, details, owner, account, createdAt, updatedAt}): _accountNumber = accountNumber, _accountType = accountType, _details = details, _owner = owner, _account = account, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Transaction({String? id, String? accountNumber, String? accountType, String? details, String? owner, Account? account}) {
    return Transaction._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      accountNumber: accountNumber,
      accountType: accountType,
      details: details,
      owner: owner,
      account: account);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Transaction &&
      id == other.id &&
      _accountNumber == other._accountNumber &&
      _accountType == other._accountType &&
      _details == other._details &&
      _owner == other._owner &&
      _account == other._account;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Transaction {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("accountNumber=" + "$_accountNumber" + ", ");
    buffer.write("accountType=" + "$_accountType" + ", ");
    buffer.write("details=" + "$_details" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("account=" + (_account != null ? _account!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Transaction copyWith({String? accountNumber, String? accountType, String? details, String? owner, Account? account}) {
    return Transaction._internal(
      id: id,
      accountNumber: accountNumber ?? this.accountNumber,
      accountType: accountType ?? this.accountType,
      details: details ?? this.details,
      owner: owner ?? this.owner,
      account: account ?? this.account);
  }
  
  Transaction copyWithModelFieldValues({
    ModelFieldValue<String?>? accountNumber,
    ModelFieldValue<String?>? accountType,
    ModelFieldValue<String?>? details,
    ModelFieldValue<String?>? owner,
    ModelFieldValue<Account?>? account
  }) {
    return Transaction._internal(
      id: id,
      accountNumber: accountNumber == null ? this.accountNumber : accountNumber.value,
      accountType: accountType == null ? this.accountType : accountType.value,
      details: details == null ? this.details : details.value,
      owner: owner == null ? this.owner : owner.value,
      account: account == null ? this.account : account.value
    );
  }
  
  Transaction.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _accountNumber = json['accountNumber'],
      _accountType = json['accountType'],
      _details = json['details'],
      _owner = json['owner'],
      _account = json['account'] != null
        ? json['account']['serializedData'] != null
          ? Account.fromJson(new Map<String, dynamic>.from(json['account']['serializedData']))
          : Account.fromJson(new Map<String, dynamic>.from(json['account']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'accountNumber': _accountNumber, 'accountType': _accountType, 'details': _details, 'owner': _owner, 'account': _account?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'accountNumber': _accountNumber,
    'accountType': _accountType,
    'details': _details,
    'owner': _owner,
    'account': _account,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<TransactionModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<TransactionModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final ACCOUNTNUMBER = amplify_core.QueryField(fieldName: "accountNumber");
  static final ACCOUNTTYPE = amplify_core.QueryField(fieldName: "accountType");
  static final DETAILS = amplify_core.QueryField(fieldName: "details");
  static final OWNER = amplify_core.QueryField(fieldName: "owner");
  static final ACCOUNT = amplify_core.QueryField(
    fieldName: "account",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Account'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Transaction";
    modelSchemaDefinition.pluralName = "Transactions";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.ACCOUNTNUMBER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.ACCOUNTTYPE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.DETAILS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.OWNER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Transaction.ACCOUNT,
      isRequired: false,
      targetNames: ['accountId'],
      ofModelName: 'Account'
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

class _TransactionModelType extends amplify_core.ModelType<Transaction> {
  const _TransactionModelType();
  
  @override
  Transaction fromJson(Map<String, dynamic> jsonData) {
    return Transaction.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Transaction';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Transaction] in your schema.
 */
class TransactionModelIdentifier implements amplify_core.ModelIdentifier<Transaction> {
  final String id;

  /** Create an instance of TransactionModelIdentifier using [id] the primary key. */
  const TransactionModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'TransactionModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TransactionModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}