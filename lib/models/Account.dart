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


/** This is an auto generated class representing the Account type in your schema. */
class Account extends amplify_core.Model {
  static const classType = const _AccountModelType();
  final String? _accountNumber;
  final double? _balance;
  final String? _category;
  final double? _creditLimit;
  final amplify_core.TemporalDateTime? _expiry;
  final String? _type;
  final String? _ownerName;
  final String? _owner;
  final List<Transaction>? _transactions;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => modelIdentifier.serializeAsString();
  
  AccountModelIdentifier get modelIdentifier {
    try {
      return AccountModelIdentifier(
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
  
  double? get balance {
    return _balance;
  }
  
  String? get category {
    return _category;
  }
  
  double? get creditLimit {
    return _creditLimit;
  }
  
  amplify_core.TemporalDateTime? get expiry {
    return _expiry;
  }
  
  String? get type {
    return _type;
  }
  
  String? get ownerName {
    return _ownerName;
  }
  
  String? get owner {
    return _owner;
  }
  
  List<Transaction>? get transactions {
    return _transactions;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Account._internal({required accountNumber, balance, category, creditLimit, expiry, type, ownerName, owner, transactions, createdAt, updatedAt}): _accountNumber = accountNumber, _balance = balance, _category = category, _creditLimit = creditLimit, _expiry = expiry, _type = type, _ownerName = ownerName, _owner = owner, _transactions = transactions, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Account({required String accountNumber, double? balance, String? category, double? creditLimit, amplify_core.TemporalDateTime? expiry, String? type, String? ownerName, String? owner, List<Transaction>? transactions}) {
    return Account._internal(
      accountNumber: accountNumber,
      balance: balance,
      category: category,
      creditLimit: creditLimit,
      expiry: expiry,
      type: type,
      ownerName: ownerName,
      owner: owner,
      transactions: transactions != null ? List<Transaction>.unmodifiable(transactions) : transactions);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Account &&
      _accountNumber == other._accountNumber &&
      _balance == other._balance &&
      _category == other._category &&
      _creditLimit == other._creditLimit &&
      _expiry == other._expiry &&
      _type == other._type &&
      _ownerName == other._ownerName &&
      _owner == other._owner &&
      DeepCollectionEquality().equals(_transactions, other._transactions);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Account {");
    buffer.write("accountNumber=" + "$_accountNumber" + ", ");
    buffer.write("balance=" + (_balance != null ? _balance!.toString() : "null") + ", ");
    buffer.write("category=" + "$_category" + ", ");
    buffer.write("creditLimit=" + (_creditLimit != null ? _creditLimit!.toString() : "null") + ", ");
    buffer.write("expiry=" + (_expiry != null ? _expiry!.format() : "null") + ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("ownerName=" + "$_ownerName" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Account copyWith({double? balance, String? category, double? creditLimit, amplify_core.TemporalDateTime? expiry, String? type, String? ownerName, String? owner, List<Transaction>? transactions}) {
    return Account._internal(
      accountNumber: accountNumber,
      balance: balance ?? this.balance,
      category: category ?? this.category,
      creditLimit: creditLimit ?? this.creditLimit,
      expiry: expiry ?? this.expiry,
      type: type ?? this.type,
      ownerName: ownerName ?? this.ownerName,
      owner: owner ?? this.owner,
      transactions: transactions ?? this.transactions);
  }
  
  Account copyWithModelFieldValues({
    ModelFieldValue<double?>? balance,
    ModelFieldValue<String?>? category,
    ModelFieldValue<double?>? creditLimit,
    ModelFieldValue<amplify_core.TemporalDateTime?>? expiry,
    ModelFieldValue<String?>? type,
    ModelFieldValue<String?>? ownerName,
    ModelFieldValue<String?>? owner,
    ModelFieldValue<List<Transaction>?>? transactions
  }) {
    return Account._internal(
      accountNumber: accountNumber,
      balance: balance == null ? this.balance : balance.value,
      category: category == null ? this.category : category.value,
      creditLimit: creditLimit == null ? this.creditLimit : creditLimit.value,
      expiry: expiry == null ? this.expiry : expiry.value,
      type: type == null ? this.type : type.value,
      ownerName: ownerName == null ? this.ownerName : ownerName.value,
      owner: owner == null ? this.owner : owner.value,
      transactions: transactions == null ? this.transactions : transactions.value
    );
  }
  
  Account.fromJson(Map<String, dynamic> json)  
    : _accountNumber = json['accountNumber'],
      _balance = (json['balance'] as num?)?.toDouble(),
      _category = json['category'],
      _creditLimit = (json['creditLimit'] as num?)?.toDouble(),
      _expiry = json['expiry'] != null ? amplify_core.TemporalDateTime.fromString(json['expiry']) : null,
      _type = json['type'],
      _ownerName = json['ownerName'],
      _owner = json['owner'],
      _transactions = json['transactions']  is Map
        ? (json['transactions']['items'] is List
          ? (json['transactions']['items'] as List)
              .where((e) => e != null)
              .map((e) => Transaction.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['transactions'] is List
          ? (json['transactions'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Transaction.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'accountNumber': _accountNumber, 'balance': _balance, 'category': _category, 'creditLimit': _creditLimit, 'expiry': _expiry?.format(), 'type': _type, 'ownerName': _ownerName, 'owner': _owner, 'transactions': _transactions?.map((Transaction? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'accountNumber': _accountNumber,
    'balance': _balance,
    'category': _category,
    'creditLimit': _creditLimit,
    'expiry': _expiry,
    'type': _type,
    'ownerName': _ownerName,
    'owner': _owner,
    'transactions': _transactions,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<AccountModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<AccountModelIdentifier>();
  static final ACCOUNTNUMBER = amplify_core.QueryField(fieldName: "accountNumber");
  static final BALANCE = amplify_core.QueryField(fieldName: "balance");
  static final CATEGORY = amplify_core.QueryField(fieldName: "category");
  static final CREDITLIMIT = amplify_core.QueryField(fieldName: "creditLimit");
  static final EXPIRY = amplify_core.QueryField(fieldName: "expiry");
  static final TYPE = amplify_core.QueryField(fieldName: "type");
  static final OWNERNAME = amplify_core.QueryField(fieldName: "ownerName");
  static final OWNER = amplify_core.QueryField(fieldName: "owner");
  static final TRANSACTIONS = amplify_core.QueryField(
    fieldName: "transactions",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Transaction'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Account";
    modelSchemaDefinition.pluralName = "Accounts";
    
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
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["accountNumber"], name: null)
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Account.ACCOUNTNUMBER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Account.BALANCE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Account.CATEGORY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Account.CREDITLIMIT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Account.EXPIRY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Account.TYPE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Account.OWNERNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Account.OWNER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Account.TRANSACTIONS,
      isRequired: false,
      ofModelName: 'Transaction',
      associatedKey: Transaction.ACCOUNT
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

class _AccountModelType extends amplify_core.ModelType<Account> {
  const _AccountModelType();
  
  @override
  Account fromJson(Map<String, dynamic> jsonData) {
    return Account.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Account';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Account] in your schema.
 */
class AccountModelIdentifier implements amplify_core.ModelIdentifier<Account> {
  final String accountNumber;

  /** Create an instance of AccountModelIdentifier using [accountNumber] the primary key. */
  const AccountModelIdentifier({
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
  String toString() => 'AccountModelIdentifier(accountNumber: $accountNumber)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is AccountModelIdentifier &&
      accountNumber == other.accountNumber;
  }
  
  @override
  int get hashCode =>
    accountNumber.hashCode;
}