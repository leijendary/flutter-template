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


/** This is an auto generated class representing the Product type in your schema. */
@immutable
class Product extends Model {
  static const classType = const _ProductModelType();
  final String id;
  final String? _name;
  final int? _code;
  final int? _ordinal;
  final Menu? _menu;
  final ProductCategory? _category;
  final ProductAvailability? _availability;
  final ProductAsset? _asset;
  final List<String>? _sizes;
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
  
  int get code {
    try {
      return _code!;
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
  
  Menu get menu {
    try {
      return _menu!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  ProductCategory? get category {
    return _category;
  }
  
  ProductAvailability get availability {
    try {
      return _availability!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  ProductAsset get asset {
    try {
      return _asset!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String> get sizes {
    try {
      return _sizes!;
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
  
  const Product._internal({required this.id, required name, required code, required ordinal, required menu, category, required availability, required asset, required sizes, required typeName, createdAt, updatedAt}): _name = name, _code = code, _ordinal = ordinal, _menu = menu, _category = category, _availability = availability, _asset = asset, _sizes = sizes, _typeName = typeName, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Product({String? id, required String name, required int code, required int ordinal, required Menu menu, ProductCategory? category, required ProductAvailability availability, required ProductAsset asset, required List<String> sizes, required String typeName}) {
    return Product._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      code: code,
      ordinal: ordinal,
      menu: menu,
      category: category,
      availability: availability,
      asset: asset,
      sizes: sizes != null ? List<String>.unmodifiable(sizes) : sizes,
      typeName: typeName);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Product &&
      id == other.id &&
      _name == other._name &&
      _code == other._code &&
      _ordinal == other._ordinal &&
      _menu == other._menu &&
      _category == other._category &&
      _availability == other._availability &&
      _asset == other._asset &&
      DeepCollectionEquality().equals(_sizes, other._sizes) &&
      _typeName == other._typeName;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Product {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("code=" + (_code != null ? _code!.toString() : "null") + ", ");
    buffer.write("ordinal=" + (_ordinal != null ? _ordinal!.toString() : "null") + ", ");
    buffer.write("menu=" + (_menu != null ? _menu!.toString() : "null") + ", ");
    buffer.write("category=" + (_category != null ? enumToString(_category)! : "null") + ", ");
    buffer.write("availability=" + (_availability != null ? enumToString(_availability)! : "null") + ", ");
    buffer.write("asset=" + (_asset != null ? _asset!.toString() : "null") + ", ");
    buffer.write("sizes=" + (_sizes != null ? _sizes!.toString() : "null") + ", ");
    buffer.write("typeName=" + "$_typeName" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Product copyWith({String? id, String? name, int? code, int? ordinal, Menu? menu, ProductCategory? category, ProductAvailability? availability, ProductAsset? asset, List<String>? sizes, String? typeName}) {
    return Product._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      ordinal: ordinal ?? this.ordinal,
      menu: menu ?? this.menu,
      category: category ?? this.category,
      availability: availability ?? this.availability,
      asset: asset ?? this.asset,
      sizes: sizes ?? this.sizes,
      typeName: typeName ?? this.typeName);
  }
  
  Product.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _code = (json['code'] as num?)?.toInt(),
      _ordinal = (json['ordinal'] as num?)?.toInt(),
      _menu = json['menu']?['serializedData'] != null
        ? Menu.fromJson(new Map<String, dynamic>.from(json['menu']['serializedData']))
        : null,
      _category = enumFromString<ProductCategory>(json['category'], ProductCategory.values),
      _availability = enumFromString<ProductAvailability>(json['availability'], ProductAvailability.values),
      _asset = json['asset']?['serializedData'] != null
        ? ProductAsset.fromJson(new Map<String, dynamic>.from(json['asset']['serializedData']))
        : null,
      _sizes = json['sizes']?.cast<String>(),
      _typeName = json['typeName'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'code': _code, 'ordinal': _ordinal, 'menu': _menu?.toJson(), 'category': enumToString(_category), 'availability': enumToString(_availability), 'asset': _asset?.toJson(), 'sizes': _sizes, 'typeName': _typeName, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField CODE = QueryField(fieldName: "code");
  static final QueryField ORDINAL = QueryField(fieldName: "ordinal");
  static final QueryField MENU = QueryField(
    fieldName: "menu",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Menu).toString()));
  static final QueryField CATEGORY = QueryField(fieldName: "category");
  static final QueryField AVAILABILITY = QueryField(fieldName: "availability");
  static final QueryField ASSET = QueryField(fieldName: "asset");
  static final QueryField SIZES = QueryField(fieldName: "sizes");
  static final QueryField TYPENAME = QueryField(fieldName: "typeName");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Product";
    modelSchemaDefinition.pluralName = "Products";
    
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
      key: Product.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.CODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.ORDINAL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Product.MENU,
      isRequired: true,
      targetName: "menuId",
      ofModelName: (Menu).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.CATEGORY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.AVAILABILITY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'asset',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'ProductAsset')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.SIZES,
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.TYPENAME,
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

class _ProductModelType extends ModelType<Product> {
  const _ProductModelType();
  
  @override
  Product fromJson(Map<String, dynamic> jsonData) {
    return Product.fromJson(jsonData);
  }
}