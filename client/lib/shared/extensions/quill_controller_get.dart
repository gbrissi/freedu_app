import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';

extension QuillControllerGet on QuillController {
  String get() => jsonEncode(document.toDelta().toJson());
}
