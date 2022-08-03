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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ProductAsset type in your schema. */
@immutable
class ProductAsset {
  final ProductAssetUri? _thumbnail;
  final ProductAssetUri? _full;
  final ProductAssetUri? _master;

  ProductAssetUri get thumbnail {
    try {
      return _thumbnail!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  ProductAssetUri get full {
    try {
      return _full!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  ProductAssetUri get master {
    try {
      return _master!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const ProductAsset._internal({required thumbnail, required full, required master}): _thumbnail = thumbnail, _full = full, _master = master;
  
  factory ProductAsset({required ProductAssetUri thumbnail, required ProductAssetUri full, required ProductAssetUri master}) {
    return ProductAsset._internal(
      thumbnail: thumbnail,
      full: full,
      master: master);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductAsset &&
      _thumbnail == other._thumbnail &&
      _full == other._full &&
      _master == other._master;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ProductAsset {");
    buffer.write("thumbnail=" + (_thumbnail != null ? _thumbnail!.toString() : "null") + ", ");
    buffer.write("full=" + (_full != null ? _full!.toString() : "null") + ", ");
    buffer.write("master=" + (_master != null ? _master!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ProductAsset copyWith({ProductAssetUri? thumbnail, ProductAssetUri? full, ProductAssetUri? master}) {
    return ProductAsset._internal(
      thumbnail: thumbnail ?? this.thumbnail,
      full: full ?? this.full,
      master: master ?? this.master);
  }
  
  ProductAsset.fromJson(Map<String, dynamic> json)  
    : _thumbnail = json['thumbnail']?['serializedData'] != null
        ? ProductAssetUri.fromJson(new Map<String, dynamic>.from(json['thumbnail']['serializedData']))
        : null,
      _full = json['full']?['serializedData'] != null
        ? ProductAssetUri.fromJson(new Map<String, dynamic>.from(json['full']['serializedData']))
        : null,
      _master = json['master']?['serializedData'] != null
        ? ProductAssetUri.fromJson(new Map<String, dynamic>.from(json['master']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'thumbnail': _thumbnail?.toJson(), 'full': _full?.toJson(), 'master': _master?.toJson()
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ProductAsset";
    modelSchemaDefinition.pluralName = "ProductAssets";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'thumbnail',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'ProductAssetUri')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'full',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'ProductAssetUri')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'master',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'ProductAssetUri')
    ));
  });
}