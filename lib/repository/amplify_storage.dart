import 'package:amplify_flutter/amplify_flutter.dart';

class AmplifyStorage {
  
  Future<StorageUploadFileResult<StorageItem>> uploadFile({
    required AWSFile localFile,
    required StoragePath path,
    void Function(StorageTransferProgress)? onProgress,
    StorageUploadFileOptions? options,
  }) async {
    try {
      return await Amplify.Storage.uploadFile(
        localFile: localFile,
        path: path,
        onProgress: onProgress,
        options: options,
      ).result;
    } on StorageException catch (e) {
      throw Exception(e.message);
    }
  }
}