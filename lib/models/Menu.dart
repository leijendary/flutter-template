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

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Menu type in your schema. */
@immutable
class Menu extends Model {
  static const classType = const _MenuModelType();
  final String id;
  final String? _name;
  final int? _ordinal;
  final Menu? _parent;
  final List<Menu>? _children;
  final List<Product>? _products;
  final String? _typeName;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get ordinal {
    try {
      return _ordinal!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Menu? get parent {
    return _parent;
  }
  
  List<Menu> get children {
    try {
      return _children!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Product> get products {
    try {
      return _products!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get typeName {
    try {
      return _typeName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Menu._internal({required this.id, required name, required ordinal, parent, required children, required products, required typeName, createdAt, updatedAt}): _name = name, _ordinal = ordinal, _parent = parent, _children = children, _products = products, _typeName = typeName, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Menu({String? id, required String name, required int ordinal, Menu? parent, required List<Menu> children, required List<Product> products, required String typeName}) {
    return Menu._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      ordinal: ordinal,
      parent: parent,
      children: children != null ? List<Menu>.unmodifiable(children) : children,
      products: products != null ? List<Product>.unmodifiable(products) : products,
      typeName: typeName);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Menu &&
      id == other.id &&
      _name == other._name &&
      _ordinal == other._ordinal &&
      _parent == other._parent &&
      DeepCollectionEquality().equals(_children, other._children) &&
      DeepCollectionEquality().equals(_products, other._products) &&
      _typeName == other._typeName;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Menu {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("ordinal=" + (_ordinal != null ? _ordinal!.toString() : "null") + ", ");
    buffer.write("parent=" + (_parent != null ? _parent!.toString() : "null") + ", ");
    buffer.write("typeName=" + "$_typeName" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Menu copyWith({String? id, String? name, int? ordinal, Menu? parent, List<Menu>? children, List<Product>? products, String? typeName}) {
    return Menu._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      ordinal: ordinal ?? this.ordinal,
      parent: parent ?? this.parent,
      children: children ?? this.children,
      products: products ?? this.products,
      typeName: typeName ?? this.typeName);
  }
  
  Menu.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _ordinal = (json['ordinal'] as num?)?.toInt(),
      _parent = json['parent']?['serializedData'] != null
        ? Menu.fromJson(new Map<String, dynamic>.from(json['parent']['serializedData']))
        : null,
      _children = json['children'] is List
        ? (json['children'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Menu.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _products = json['products'] is List
        ? (json['products'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Product.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _typeName = json['typeName'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'ordinal': _ordinal, 'parent': _parent?.toJson(), 'children': _children?.map((Menu? e) => e?.toJson()).toList(), 'products': _products?.map((Product? e) => e?.toJson()).toList(), 'typeName': _typeName, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ORDINAL = QueryField(fieldName: "ordinal");
  static final QueryField PARENT = QueryField(
    fieldName: "parent",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Menu).toString()));
  static final QueryField CHILDREN = QueryField(
    fieldName: "children",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Menu).toString()));
  static final QueryField PRODUCTS = QueryField(
    fieldName: "products",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Product).toString()));
  static final QueryField TYPENAME = QueryField(fieldName: "typeName");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Menu";
    modelSchemaDefinition.pluralName = "Menus";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.GROUPS,
        groupClaim: "cognito:groups",
        groups: [ "Administrator" ],
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ]),
      AuthRule(
        authStrategy: AuthStrategy.PRIVATE,
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.READ
        ]),
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        provider: AuthRuleProvider.IAM,
        operations: [
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Menu.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Menu.ORDINAL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Menu.PARENT,
      isRequired: false,
      targetName: "parentId",
      ofModelName: (Menu).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Menu.CHILDREN,
      isRequired: true,
      ofModelName: (Menu).toString(),
      associatedKey: Menu.PARENT
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Menu.PRODUCTS,
      isRequired: true,
      ofModelName: (Product).toString(),
      associatedKey: Product.MENU
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Menu.TYPENAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _MenuModelType extends ModelType<Menu> {
  const _MenuModelType();
  
  @override
  Menu fromJson(Map<String, dynamic> jsonData) {
    return Menu.fromJson(jsonData);
  }
}