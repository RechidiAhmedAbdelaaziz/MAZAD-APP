import 'package:flutter/material.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/number_editingcontroller.dart';

class PaginationDto {
  final IntegerEditingController page;
  final IntegerEditingController limit;
  final TextEditingController keywordController;
  final TextEditingController fields;
  final TextEditingController sort;

  PaginationDto({
    int page = 1,
    int limit = 10,
    String? keyword,
    String? fields,
    String? sort,
  }) : keywordController = TextEditingController(text: keyword),
       fields = TextEditingController(text: fields),
       sort = TextEditingController(text: sort),
       page = IntegerEditingController(page),
       limit = IntegerEditingController(limit);

  Map<String, dynamic> toJson() => {
    'page': page.value,
    'limit': limit.value,
    if (keywordController.text.isNotEmpty)
      'keyword': keywordController.text,
    if (fields.text.isNotEmpty) 'fields': fields.text,
    if (sort.text.isNotEmpty) 'sort': sort.text,
  };


  void dispose() {
    page.dispose();
    limit.dispose();
    keywordController.dispose();
    fields.dispose();
    sort.dispose();
  }

  void nextPage() => page.increment();
  void firstPage() => page.setValue(1);
}
