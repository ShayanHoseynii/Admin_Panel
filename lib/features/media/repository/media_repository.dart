import 'dart:io';

import 'package:admin_panel/features/media/models/image_model.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload any Image using Uint8List (compatible with DropzoneFileInterface)
  Future<ImageModel> uploadImageFileInStorage(
      {required Uint8List fileData,
      required String mimeType,
      required String path,
      required String imageName}) async {
    try {
      // Reference to the storage location
      final Reference ref = _storage.ref('$path/$imageName');
      // Upload file using Uint8List
      final UploadTask uploadTask =
          ref.putData(fileData, SettableMetadata(contentType: mimeType));
      // Wait for the upload to complete
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      // Get download URL
      final String downloadURL = await snapshot.ref.getDownloadURL();
      // Fetch metadata
      final FullMetadata metadata = await ref.getMetadata();
      return ImageModel.fromFirebaseMetaData(
          metadata, path, imageName, downloadURL);
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('Images')
          .add(image.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ImageModel>> fetchImagesFromDatabase(
      MediaCategory mediaCategory, int loadCount) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt', descending: true)
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ImageModel>> loadMoreImagesFromDatabase(
      MediaCategory mediaCategory,
      int loadCount,
      DateTime lastFetchedDate) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .startAfter([lastFetchedDate])
          .orderBy('createdAt', descending: true)
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteFileFromStorage(ImageModel image) async {
    try {
      await FirebaseStorage.instance.ref(image.fullPath).delete();
      await FirebaseFirestore.instance
          .collection('Images')
          .doc(image.id)
          .delete();

          
    } on FirebaseException catch (e) {
      throw e.message ?? 'Something went wrong while deleting image.';
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

}
