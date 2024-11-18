import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/buttons.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomHourPicker extends StatefulWidget {
  const CustomHourPicker({
    super.key,
    this.hour = 0,
    this.minute = 0,
    required this.hourChanged,
    required this.minuteChanged,
    required this.onSaved,
    required this.onCancelled,
  });
  final int hour;
  final int minute;

  final void Function(int val) hourChanged;
  final void Function(int val) minuteChanged;
  final void Function() onSaved;
  final void Function() onCancelled;

  @override
  State<CustomHourPicker> createState() => _CustomHourPickerState();
}

class _CustomHourPickerState extends State<CustomHourPicker> {
  late int _selectedHour;
  late int _selectedMinute;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.hour; // Initialiser avec la valeur passée
    _selectedMinute = widget.minute; // Initialiser avec la valeur passée
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10.h),
            Text(
              'Régler le temps',
              style: TextStyle(
                color: AppColor.primaryGray,
                fontSize: 19.24.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberPicker(
                    minValue: 0,
                    maxValue: 23,
                    value: _selectedHour,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 65,
                    itemHeight: 60,
                    onChanged: (val) {
                      setState(() {
                        _selectedHour = val;
                      });
                      widget.hourChanged(val);
                    },
                    textStyle: TextStyle(
                      color: AppColor.primaryGray,
                      fontSize: 19.24.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedTextStyle: TextStyle(
                      color: AppColor.primary,
                      fontSize: 19.24.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFF8B8B8B),
                        ),
                        bottom: BorderSide(
                          color: Color(0xFF8B8B8B),
                        ),
                      ),
                    ),
                  ),
                  NumberPicker(
                    minValue: 0,
                    maxValue: 59,
                    value: _selectedMinute,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 65,
                    itemHeight: 60,
                    onChanged: (val) {
                      setState(() {
                        _selectedMinute = val;
                      });
                      widget.minuteChanged(val);
                    },
                    textStyle: TextStyle(
                      color: AppColor.primaryGray,
                      fontSize: 19.24.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedTextStyle: TextStyle(
                      color: AppColor.primary,
                      fontSize: 19.24.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFF8B8B8B),
                        ),
                        bottom: BorderSide(
                          color: Color(0xFF8B8B8B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: PopDialogueButton(
                    backgroundColor: const Color(0xFFDDDDDD),
                    title: 'Annuler',
                    onTap: widget.onCancelled,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: PopDialogueButton(
                    title: 'Sauvegarder',
                    onTap: widget.onSaved,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onSaved,
  });

  final DateTime? selectedDay;

  final void Function() onSaved;

  final void Function(DateTime, DateTime) onDaySelected;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2000, 1, 1),
          lastDay: DateTime.now(),
          focusedDay: _focusedDay,
          locale: 'fr',
          rowHeight: 38.h,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _focusedDay = focusedDay;
                _selectedDay = selectedDay;
              });
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   widget.onDaySelected(selectedDay, _focusedDay);
              // });
              widget.onDaySelected(selectedDay, _focusedDay);
            }
          },
          onPageChanged: (focusedDay) => setState(() {
            _focusedDay = focusedDay;
          }),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: const Color(0xFFF8E9DD),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: Colors.brown, width: 1.5.w),
            ),
            outsideDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.r),
            ),
            rowDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.r),
            ),
            weekendDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.r),
            ),
            defaultDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.r),
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.brown,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.r),
            ),
            todayTextStyle: const TextStyle(
              color: Colors.brown,
            ),
            cellMargin: EdgeInsets.zero,
            cellPadding: EdgeInsets.zero,
            tablePadding: EdgeInsets.zero,
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            headerPadding: EdgeInsets.zero,
            headerMargin: EdgeInsets.zero,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: PopDialogueButton(
                title: 'Annuler',
                backgroundColor: const Color(0xFFDDDDDD),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: SizedBox(
                width: 143.21.w,
                child: PopDialogueButton(
                  onTap: widget.onSaved,
                  title: 'Choisir une date',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
