import 'dart:async';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'cloud_storage.service.dart';

class CloudinaryService extends ImageCloudStorageService {
  final String cloudName = "deljic9sr";
  final String apiKey = "248828733121325";
  final String apiSecret = "G2w253r_y0q7i7ardBnPA194Wjs";
  final String uploadPreset = 'learn_flutter';

  @override
  Future<String> upload(XFile file) async {
    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    // Prepare the data for the request
    final request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset;

    // Add the file to the request
    final bytes = await file.readAsBytes();

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        bytes.toList(),
        filename: file.name,
      ),
    );

    // Send the request
    final response = await http.Response.fromStream(
      await request.send(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['secure_url']; // The URL of the uploaded image
    } else {
      throw Exception("Failed to upload image: ${response.body}");
    }
  }
}
