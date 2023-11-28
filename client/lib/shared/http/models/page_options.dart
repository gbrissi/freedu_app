import 'package:client/screens/home/components/post_search/models/date_range.dart';

class PageOptions {
  final int limit;
  final int page;
  final List<String>? tags;
  final String? search;
  final DateRange? dateRange;

  PageOptions({
    required this.limit,
    required this.page,
    this.tags,
    this.search,
    this.dateRange,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['limit'] = limit;
    json['page'] = page;
    json['tags'] = tags;
    json['search'] = search;
    json['dateRange'] = dateRange?.toJson();

    return json;
  }
}
