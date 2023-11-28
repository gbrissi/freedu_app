class DateRange {
  DateTime? start;
  DateTime? end;

  void update(
    DateTime? startValue,
    DateTime? endValue,
  ) {
    start = startValue;
    end = endValue;
  }

  void clear() {
    start = null;
    end = null;
  }

  DateRange({
    required this.start,
    required this.end,
  });

  DateRange.empty();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['start'] = start?.toIso8601String();
    json['end'] = end?.toIso8601String();

    return json;
  }
}
