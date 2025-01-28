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


/** This is an auto generated class representing the Button type in your schema. */
class Button extends amplify_core.Model {
  static const classType = const _ButtonModelType();
  final String id;
  final String? _backgroundColor;
  final String? _icon;
  final String? _iconColor;
  final int? _position;
  final String? _title;
  final String? _titleColor;
  final String? _type;
  final AccountButton? _accountButton;
  final DynamicRoute? _dynamicRoute;
  final List<DynamicWidget>? _widgets;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ButtonModelIdentifier get modelIdentifier {
      return ButtonModelIdentifier(
        id: id
      );
  }
  
  String? get backgroundColor {
    return _backgroundColor;
  }
  
  String? get icon {
    return _icon;
  }
  
  String? get iconColor {
    return _iconColor;
  }
  
  int? get position {
    return _position;
  }
  
  String? get title {
    return _title;
  }
  
  String? get titleColor {
    return _titleColor;
  }
  
  String? get type {
    return _type;
  }
  
  AccountButton? get accountButton {
    return _accountButton;
  }
  
  DynamicRoute? get dynamicRoute {
    return _dynamicRoute;
  }
  
  List<DynamicWidget>? get widgets {
    return _widgets;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Button._internal({required this.id, backgroundColor, icon, iconColor, position, title, titleColor, type, accountButton, dynamicRoute, widgets, createdAt, updatedAt}): _backgroundColor = backgroundColor, _icon = icon, _iconColor = iconColor, _position = position, _title = title, _titleColor = titleColor, _type = type, _accountButton = accountButton, _dynamicRoute = dynamicRoute, _widgets = widgets, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Button({String? id, String? backgroundColor, String? icon, String? iconColor, int? position, String? title, String? titleColor, String? type, AccountButton? accountButton, DynamicRoute? dynamicRoute, List<DynamicWidget>? widgets}) {
    return Button._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      backgroundColor: backgroundColor,
      icon: icon,
      iconColor: iconColor,
      position: position,
      title: title,
      titleColor: titleColor,
      type: type,
      accountButton: accountButton,
      dynamicRoute: dynamicRoute,
      widgets: widgets != null ? List<DynamicWidget>.unmodifiable(widgets) : widgets);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Button &&
      id == other.id &&
      _backgroundColor == other._backgroundColor &&
      _icon == other._icon &&
      _iconColor == other._iconColor &&
      _position == other._position &&
      _title == other._title &&
      _titleColor == other._titleColor &&
      _type == other._type &&
      _accountButton == other._accountButton &&
      _dynamicRoute == other._dynamicRoute &&
      DeepCollectionEquality().equals(_widgets, other._widgets);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Button {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("backgroundColor=" + "$_backgroundColor" + ", ");
    buffer.write("icon=" + "$_icon" + ", ");
    buffer.write("iconColor=" + "$_iconColor" + ", ");
    buffer.write("position=" + (_position != null ? _position!.toString() : "null") + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("titleColor=" + "$_titleColor" + ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("accountButton=" + (_accountButton != null ? _accountButton!.toString() : "null") + ", ");
    buffer.write("dynamicRoute=" + (_dynamicRoute != null ? _dynamicRoute!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Button copyWith({String? backgroundColor, String? icon, String? iconColor, int? position, String? title, String? titleColor, String? type, AccountButton? accountButton, DynamicRoute? dynamicRoute, List<DynamicWidget>? widgets}) {
    return Button._internal(
      id: id,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      position: position ?? this.position,
      title: title ?? this.title,
      titleColor: titleColor ?? this.titleColor,
      type: type ?? this.type,
      accountButton: accountButton ?? this.accountButton,
      dynamicRoute: dynamicRoute ?? this.dynamicRoute,
      widgets: widgets ?? this.widgets);
  }
  
  Button copyWithModelFieldValues({
    ModelFieldValue<String?>? backgroundColor,
    ModelFieldValue<String?>? icon,
    ModelFieldValue<String?>? iconColor,
    ModelFieldValue<int?>? position,
    ModelFieldValue<String?>? title,
    ModelFieldValue<String?>? titleColor,
    ModelFieldValue<String?>? type,
    ModelFieldValue<AccountButton?>? accountButton,
    ModelFieldValue<DynamicRoute?>? dynamicRoute,
    ModelFieldValue<List<DynamicWidget>?>? widgets
  }) {
    return Button._internal(
      id: id,
      backgroundColor: backgroundColor == null ? this.backgroundColor : backgroundColor.value,
      icon: icon == null ? this.icon : icon.value,
      iconColor: iconColor == null ? this.iconColor : iconColor.value,
      position: position == null ? this.position : position.value,
      title: title == null ? this.title : title.value,
      titleColor: titleColor == null ? this.titleColor : titleColor.value,
      type: type == null ? this.type : type.value,
      accountButton: accountButton == null ? this.accountButton : accountButton.value,
      dynamicRoute: dynamicRoute == null ? this.dynamicRoute : dynamicRoute.value,
      widgets: widgets == null ? this.widgets : widgets.value
    );
  }
  
  Button.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _backgroundColor = json['backgroundColor'],
      _icon = json['icon'],
      _iconColor = json['iconColor'],
      _position = (json['position'] as num?)?.toInt(),
      _title = json['title'],
      _titleColor = json['titleColor'],
      _type = json['type'],
      _accountButton = json['accountButton'] != null
        ? json['accountButton']['serializedData'] != null
          ? AccountButton.fromJson(new Map<String, dynamic>.from(json['accountButton']['serializedData']))
          : AccountButton.fromJson(new Map<String, dynamic>.from(json['accountButton']))
        : null,
      _dynamicRoute = json['dynamicRoute'] != null
        ? json['dynamicRoute']['serializedData'] != null
          ? DynamicRoute.fromJson(new Map<String, dynamic>.from(json['dynamicRoute']['serializedData']))
          : DynamicRoute.fromJson(new Map<String, dynamic>.from(json['dynamicRoute']))
        : null,
      _widgets = json['widgets']  is Map
        ? (json['widgets']['items'] is List
          ? (json['widgets']['items'] as List)
              .where((e) => e != null)
              .map((e) => DynamicWidget.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['widgets'] is List
          ? (json['widgets'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => DynamicWidget.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'backgroundColor': _backgroundColor, 'icon': _icon, 'iconColor': _iconColor, 'position': _position, 'title': _title, 'titleColor': _titleColor, 'type': _type, 'accountButton': _accountButton?.toJson(), 'dynamicRoute': _dynamicRoute?.toJson(), 'widgets': _widgets?.map((DynamicWidget? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'backgroundColor': _backgroundColor,
    'icon': _icon,
    'iconColor': _iconColor,
    'position': _position,
    'title': _title,
    'titleColor': _titleColor,
    'type': _type,
    'accountButton': _accountButton,
    'dynamicRoute': _dynamicRoute,
    'widgets': _widgets,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ButtonModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ButtonModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final BACKGROUNDCOLOR = amplify_core.QueryField(fieldName: "backgroundColor");
  static final ICON = amplify_core.QueryField(fieldName: "icon");
  static final ICONCOLOR = amplify_core.QueryField(fieldName: "iconColor");
  static final POSITION = amplify_core.QueryField(fieldName: "position");
  static final TITLE = amplify_core.QueryField(fieldName: "title");
  static final TITLECOLOR = amplify_core.QueryField(fieldName: "titleColor");
  static final TYPE = amplify_core.QueryField(fieldName: "type");
  static final ACCOUNTBUTTON = amplify_core.QueryField(
    fieldName: "accountButton",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'AccountButton'));
  static final DYNAMICROUTE = amplify_core.QueryField(
    fieldName: "dynamicRoute",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'DynamicRoute'));
  static final WIDGETS = amplify_core.QueryField(
    fieldName: "widgets",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'DynamicWidget'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Button";
    modelSchemaDefinition.pluralName = "Buttons";
    
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
      key: Button.BACKGROUNDCOLOR,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Button.ICON,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Button.ICONCOLOR,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Button.POSITION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Button.TITLE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Button.TITLECOLOR,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Button.TYPE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Button.ACCOUNTBUTTON,
      isRequired: false,
      targetNames: ['accountButtonId'],
      ofModelName: 'AccountButton'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Button.DYNAMICROUTE,
      isRequired: false,
      targetNames: ['dynamicRouteId'],
      ofModelName: 'DynamicRoute'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Button.WIDGETS,
      isRequired: false,
      ofModelName: 'DynamicWidget',
      associatedKey: DynamicWidget.BUTTON
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

class _ButtonModelType extends amplify_core.ModelType<Button> {
  const _ButtonModelType();
  
  @override
  Button fromJson(Map<String, dynamic> jsonData) {
    return Button.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Button';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Button] in your schema.
 */
class ButtonModelIdentifier implements amplify_core.ModelIdentifier<Button> {
  final String id;

  /** Create an instance of ButtonModelIdentifier using [id] the primary key. */
  const ButtonModelIdentifier({
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
  String toString() => 'ButtonModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ButtonModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}