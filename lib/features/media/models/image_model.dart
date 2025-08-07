import 'dart:typed_data';
import 'package:admin_panel/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';

class ImageModel {
  // Define properties and methods for the ImageModel
  String id;
  final String url;
  final String folder;
  final int? sizedBytes;
  String mediaCategory;
  final String fileName;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not Mapped
  final File? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;
  ImageModel(
      {this.id = '',
      required this.url,
      required this.folder,
      required this.fileName,
      this.sizedBytes,
      this.mediaCategory = '',
      this.fullPath,
      this.createdAt,
      this.updatedAt,
      this.file,
      this.contentType,
      this.localImageToDisplay});
  static ImageModel empty() {
    return ImageModel(
      url: '',
      folder: '',
      fileName: '',
    );
  }

  String get createAtFormatted => TFormatter.formatDate(createdAt);

  String get updatedAtFormatted => TFormatter.formatDate(updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'folder': folder,
      'sizedBox': sizedBytes,
      'mediaCategory': mediaCategory,
      'fileName': fileName,
      'fullpath': fullPath,
      'createdAt': createdAt?.toUtc(),
      'contentType': contentType,
    };
  }

  factory ImageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return ImageModel(
        id: document.id,
        url: data?['url'] ?? '',
        folder: data?['folder'] ?? '',
        sizedBytes: data?['sizedBytes'] ?? 0,
        mediaCategory: data?['mediaCategory'],
        fileName: data?['fileName'] ?? '',
        fullPath: data?['fullPath'],
        createdAt: data?['createdAt'] != null
            ? (data!['createdAt'] as Timestamp).toDate()
            : null,
        updatedAt: data?['updatedAt'] != null
            ? (data!['updatedAt'] as Timestamp).toDate()
            : null,
        contentType: data?['contentType'] ?? '',
      );
    } else {
      return ImageModel.empty();
    }
  }

  factory ImageModel.fromFirebaseMetaData(FullMetadata metadata, String folder,
      String filename, String downloadUrl) {
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      fileName: filename,
      sizedBytes: metadata.size,
      updatedAt: metadata.updated,
      fullPath: metadata.fullPath,
      createdAt: metadata.timeCreated,
      contentType: metadata.contentType,
    );
  }

  // Add methods to handle image data if necessary
}
