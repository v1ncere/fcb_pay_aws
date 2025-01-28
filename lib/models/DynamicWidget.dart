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


/** This is an auto generated class representing the DynamicWidget type in your schema. */
class DynamicWidget extends amplify_core.Model {
  static const classType = const _DynamicWidgetModelType();
  final String id;
  final bool? _hasExtra;
  final String? _content;
  final String? _dataType;
  final String? _node;
  final int? _position;
  final String? _title;
  final String? _widgetType;
  final Button? _button;
  final Institution? _institutionWidget;
  final Institution? _institutionExtraWidget;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  DynamicWidgetModelIdentifier get modelIdentifier {
      return DynamicWidgetModelIdentifier(
        id: id
      );
  }
  
  bool? get hasExtra {
    return _hasExtra;
  }
  
  String? get content {
    return _content;
  }
  
  String? get dataType {
    return _dataType;
  }
  
  String? get node {
    return _node;
  }
  
  int? get position {
    return _position;
  }
  
  String? get title {
    return _title;
  }
  
  String? get widgetType {
    return _widgetType;
  }
  
  Button? get button {
    return _button;
  }
  
  Institution? get institutionWidget {
    return _institutionWidget;
  }
  
  Institution? get institutionExtraWidget {
    return _institutionExtraWidget;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const DynamicWidget._internal({required this.id, hasExtra, content, dataType, node, position, title, widgetType, button, institutionWidget, institutionExtraWidget, createdAt, updatedAt}): _hasExtra = hasExtra, _content = content, _dataType = dataType, _node = node, _position = position, _title = title, _widgetType = widgetType, _button = button, _institutionWidget = institutionWidget, _institutionExtraWidget = institutionExtraWidget, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory DynamicWidget({String? id, bool? hasExtra, String? content, String? dataType, String? node, int? position, String? title, String? widgetType, Button? button, Institution? institutionWidget, Institution? institutionExtraWidget}) {
    return DynamicWidget._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      hasExtra: hasExtra,
      content: content,
      dataType: dataType,
      node: node,
      position: position,
      title: title,
      widgetType: widgetType,
      button: button,
      institutionWidget: institutionWidget,
      institutionExtraWidget: institutionExtraWidget);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DynamicWidget &&
      id == other.id &&
      _hasExtra == other._hasExtra &&
      _content == other._content &&
      _dataType == other._dataType &&
      _node == other._node &&
      _position == other._position &&
      _title == other._title &&
      _widgetType == other._widgetType &&
      _button == other._button &&
      _institutionWidget == other._institutionWidget &&
      _institutionExtraWidget == other._institutionExtraWidget;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("DynamicWidget {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("hasExtra=" + (_hasExtra != null ? _hasExtra!.toString() : "null") + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("dataType=" + "$_dataType" + ", ");
    buffer.write("node=" + "$_node" + ", ");
    buffer.write("position=" + (_position != null ? _position!.toString() : "null") + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("widgetType=" + "$_widgetType" + ", ");
    buffer.write("button=" + (_button != null ? _button!.toString() : "null") + ", ");
    buffer.write("institutionWidget=" + (_institutionWidget != null ? _institutionWidget!.toString() : "null") + ", ");
    buffer.write("institutionExtraWidget=" + (_institutionExtraWidget != null ? _institutionExtraWidget!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  DynamicWidget copyWith({bool? hasExtra, String? content, String? dataType, String? node, int? position, String? title, String? widgetType, Button? button, Institution? institutionWidget, Institution? institutionExtraWidget}) {
    return DynamicWidget._internal(
      id: id,
      hasExtra: hasExtra ?? this.hasExtra,
      content: content ?? this.content,
      dataType: dataType ?? this.dataType,
      node: node ?? this.node,
      position: position ?? this.position,
      title: title ?? this.title,
      widgetType: widgetType ?? this.widgetType,
      button: button ?? this.button,
      institutionWidget: institutionWidget ?? this.institutionWidget,
      institutionExtraWidget: institutionExtraWidget ?? this.institutionExtraWidget);
  }
  
  DynamicWidget copyWithModelFieldValues({
    ModelFieldValue<bool?>? hasExtra,
    ModelFieldValue<String?>? content,
    ModelFieldValue<String?>? dataType,
    ModelFieldValue<String?>? node,
    ModelFieldValue<int?>? position,
    ModelFieldValue<String?>? title,
    ModelFieldValue<String?>? widgetType,
    ModelFieldValue<Button?>? button,
    ModelFieldValue<Institution?>? institutionWidget,
    ModelFieldValue<Institution?>? institutionExtraWidget
  }) {
    return DynamicWidget._internal(
      id: id,
      hasExtra: hasExtra == null ? this.hasExtra : hasExtra.value,
      content: content == null ? this.content : content.value,
      dataType: dataType == null ? this.dataType : dataType.value,
      node: node == null ? this.node : node.value,
      position: position == null ? this.position : position.value,
      title: title == null ? this.title : title.value,
      widgetType: widgetType == null ? this.widgetType : widgetType.value,
      button: button == null ? this.button : button.value,
      institutionWidget: institutionWidget == null ? this.institutionWidget : institutionWidget.value,
      institutionExtraWidget: institutionExtraWidget == null ? this.institutionExtraWidget : institutionExtraWidget.value
    );
  }
  
  DynamicWidget.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _hasExtra = json['hasExtra'],
      _content = json['content'],
      _dataType = json['dataType'],
      _node = json['node'],
      _position = (json['position'] as num?)?.toInt(),
      _title = json['title'],
      _widgetType = json['widgetType'],
      _button = json['button'] != null
        ? json['button']['serializedData'] != null
          ? Button.fromJson(new Map<String, dynamic>.from(json['button']['serializedData']))
          : Button.fromJson(new Map<String, dynamic>.from(json['button']))
        : null,
      _institutionWidget = json['institutionWidget'] != null
        ? json['institutionWidget']['serializedData'] != null
          ? Institution.fromJson(new Map<String, dynamic>.from(json['institutionWidget']['serializedData']))
          : Institution.fromJson(new Map<String, dynamic>.from(json['institutionWidget']))
        : null,
      _institutionExtraWidget = json['institutionExtraWidget'] != null
        ? json['institutionExtraWidget']['serializedData'] != null
          ? Institution.fromJson(new Map<String, dynamic>.from(json['institutionExtraWidget']['serializedData']))
          : Institution.fromJson(new Map<String, dynamic>.from(json['institutionExtraWidget']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'hasExtra': _hasExtra, 'content': _content, 'dataType': _dataType, 'node': _node, 'position': _position, 'title': _title, 'widgetType': _widgetType, 'button': _button?.toJson(), 'institutionWidget': _institutionWidget?.toJson(), 'institutionExtraWidget': _institutionExtraWidget?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'hasExtra': _hasExtra,
    'content': _content,
    'dataType': _dataType,
    'node': _node,
    'position': _position,
    'title': _title,
    'widgetType': _widgetType,
    'button': _button,
    'institutionWidget': _institutionWidget,
    'institutionExtraWidget': _institutionExtraWidget,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<DynamicWidgetModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<DynamicWidgetModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final HASEXTRA = amplify_core.QueryField(fieldName: "hasExtra");
  static final CONTENT = amplify_core.QueryField(fieldName: "content");
  static final DATATYPE = amplify_core.QueryField(fieldName: "dataType");
  static final NODE = amplify_core.QueryField(fieldName: "node");
  static final POSITION = amplify_core.QueryField(fieldName: "position");
  static final TITLE = amplify_core.QueryField(fieldName: "title");
  static final WIDGETTYPE = amplify_core.QueryField(fieldName: "widgetType");
  static final BUTTON = amplify_core.QueryField(
    fieldName: "button",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Button'));
  static final INSTITUTIONWIDGET = amplify_core.QueryField(
    fieldName: "institutionWidget",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Institution'));
  static final INSTITUTIONEXTRAWIDGET = amplify_core.QueryField(
    fieldName: "institutionExtraWidget",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Institution'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "DynamicWidget";
    modelSchemaDefinition.pluralName = "DynamicWidgets";
    
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DynamicWidget.HASEXTRA,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DynamicWidget.CONTENT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DynamicWidget.DATATYPE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DynamicWidget.NODE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DynamicWidget.POSITION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DynamicWidget.TITLE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DynamicWidget.WIDGETTYPE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: DynamicWidget.BUTTON,
      isRequired: false,
      targetNames: ['buttonId'],
      ofModelName: 'Button'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: DynamicWidget.INSTITUTIONWIDGET,
      isRequired: false,
      targetNames: ['institutionWidgetId'],
      ofModelName: 'Institution'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: DynamicWidget.INSTITUTIONEXTRAWIDGET,
      isRequired: false,
      targetNames: ['institutionExtraId'],
      ofModelName: 'Institution'
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

class _DynamicWidgetModelType extends amplify_core.ModelType<DynamicWidget> {
  const _DynamicWidgetModelType();
  
  @override
  DynamicWidget fromJson(Map<String, dynamic> jsonData) {
    return DynamicWidget.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'DynamicWidget';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [DynamicWidget] in your schema.
 */
class DynamicWidgetModelIdentifier implements amplify_core.ModelIdentifier<DynamicWidget> {
  final String id;

  /** Create an instance of DynamicWidgetModelIdentifier using [id] the primary key. */
  const DynamicWidgetModelIdentifier({
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
  String toString() => 'DynamicWidgetModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is DynamicWidgetModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}