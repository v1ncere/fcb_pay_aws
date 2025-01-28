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

import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'Account.dart';
import 'AccountButton.dart';
import 'Button.dart';
import 'DynamicModel.dart';
import 'DynamicRoute.dart';
import 'DynamicWidget.dart';
import 'Institution.dart';
import 'Notification.dart';
import 'PublicAccount.dart';
import 'Receipt.dart';
import 'Request.dart';
import 'SignupVerify.dart';
import 'SignupVerifyReply.dart';
import 'Transaction.dart';
import 'TransferableUser.dart';

export 'Account.dart';
export 'AccountButton.dart';
export 'Button.dart';
export 'DynamicModel.dart';
export 'DynamicRoute.dart';
export 'DynamicWidget.dart';
export 'Institution.dart';
export 'Notification.dart';
export 'PublicAccount.dart';
export 'Receipt.dart';
export 'Request.dart';
export 'SearchFilter.dart';
export 'SignupVerify.dart';
export 'SignupVerifyReply.dart';
export 'Transaction.dart';
export 'TransferableUser.dart';

class ModelProvider implements amplify_core.ModelProviderInterface {
  @override
  String version = "bd873ce80abc8763f3e133f6a5686440";
  @override
  List<amplify_core.ModelSchema> modelSchemas = [Account.schema, AccountButton.schema, Button.schema, DynamicModel.schema, DynamicRoute.schema, DynamicWidget.schema, Institution.schema, Notification.schema, PublicAccount.schema, Receipt.schema, Request.schema, SignupVerify.schema, SignupVerifyReply.schema, Transaction.schema, TransferableUser.schema];
  @override
  List<amplify_core.ModelSchema> customTypeSchemas = [];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;
  
  amplify_core.ModelType getModelTypeByModelName(String modelName) {
    switch(modelName) {
      case "Account":
        return Account.classType;
      case "AccountButton":
        return AccountButton.classType;
      case "Button":
        return Button.classType;
      case "DynamicModel":
        return DynamicModel.classType;
      case "DynamicRoute":
        return DynamicRoute.classType;
      case "DynamicWidget":
        return DynamicWidget.classType;
      case "Institution":
        return Institution.classType;
      case "Notification":
        return Notification.classType;
      case "PublicAccount":
        return PublicAccount.classType;
      case "Receipt":
        return Receipt.classType;
      case "Request":
        return Request.classType;
      case "SignupVerify":
        return SignupVerify.classType;
      case "SignupVerifyReply":
        return SignupVerifyReply.classType;
      case "Transaction":
        return Transaction.classType;
      case "TransferableUser":
        return TransferableUser.classType;
      default:
        throw Exception("Failed to find model in model provider for model name: " + modelName);
    }
  }
}


class ModelFieldValue<T> {
  const ModelFieldValue.value(this.value);

  final T value;
}
