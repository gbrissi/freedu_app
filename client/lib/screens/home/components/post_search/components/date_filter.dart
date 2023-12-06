import 'package:client/screens/home/components/post_search/models/date_range.dart';
import 'package:client/shared/components/custom_app_bar/components/leading_builder.dart';
import 'package:client/shared/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class DateFilter extends StatefulWidget {
  const DateFilter({
    super.key,
    required this.value,
  });
  final DateRange value;

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  void _getDateRange() => context.pop(_dateRange);
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Duration _dayLimit = const Duration(
    hours: 23,
    minutes: 59,
    seconds: 59,
  );

  late final DateRange _dateRange = DateRange(
    start: widget.value.start,
    end: widget.value.end,
  );

  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  void _onDaySelected(selectedDay, focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _dateRange.clear();
      });
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _dateRange.update(
        start,
        end?.add(
          _dayLimit,
        ),
      );
      // _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  void _onFormatChanged(format) {
    if (_calendarFormat != format) {
      setState(() {
        _calendarFormat = format;
      });
    }
  }

  bool _isRangeInitialValue() {
    bool isSameStart = widget.value.start == _dateRange.start;
    bool isSameEnd = widget.value.end == _dateRange.end;

    return isSameStart && isSameEnd;
  }

  Future<bool> _onWillPop() async {
    if (!_isRangeInitialValue()) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Desejas descartar suas alterações?",
            ),
            actions: [
              TextButton(
                onPressed: context.pop,
                child: const Text(
                  "Cancelar",
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                  context.pop();
                },
                child: const Text(
                  "Confirmar",
                ),
              )
            ],
          );
        },
      );
    } else {
      _getDateRange();
    }

    return Future.delayed(
      Duration.zero,
      () => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar.custom(
          leading: LeadingBuilder(
            tooltip: "Retornar data",
            onTap: _onWillPop,
            icon: Icons.arrow_back,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth ~/ 7 * 7,
              child: TableCalendar(
                locale: 'pt_BR',
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _dateRange.start,
                rangeEndDay: _dateRange.end,
                rangeSelectionMode: _rangeSelectionMode,
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
                onFormatChanged: _onFormatChanged,
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _getDateRange,
          child: const Icon(
            Icons.done,
          ),
        ),
      ),
    );
  }
}
