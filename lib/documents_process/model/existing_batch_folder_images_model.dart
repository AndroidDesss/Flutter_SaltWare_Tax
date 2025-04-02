class ExistingBatchFolderImagesResponse {
  final String id;
  final String filePath;
  final String batchId;

  ExistingBatchFolderImagesResponse(
      {required this.id, required this.filePath, required this.batchId});

  // Factory method to convert JSON to UserData object
  factory ExistingBatchFolderImagesResponse.fromJson(
      Map<String, dynamic> json) {
    return ExistingBatchFolderImagesResponse(
        id: json['id'], filePath: json['file_path'], batchId: json['batch_id']);
  }
}
