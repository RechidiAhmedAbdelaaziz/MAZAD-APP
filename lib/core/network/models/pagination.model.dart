part of 'api_response.model.dart';

class Pagination {
  final int? page;
  final int? length;
  final int? next;
  final int? prev;

  const Pagination({
    this.page,
    this.length,
    this.next,
    this.prev,
  });

  int get pageBegin => (page! - 1) * length!;
  int get pageEnd => (page! - 1) * length! + length!;

  factory Pagination.fromJson(Map<String, dynamic>? json) {
    return Pagination(
      page: json?['page'],
      length: json?['length'],
      next: json?['next'],
      prev: json?['prev'],
    );
  }
}
