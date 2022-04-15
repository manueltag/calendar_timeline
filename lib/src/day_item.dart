import 'package:flutter/material.dart';

/// Creates a Widget representing the day.
class DayItem extends StatelessWidget {
  final int dayNumber;
  final String shortName;
  final bool isSelected;
  final bool isWeekDay;
  final Function onTap;
  final Color? dayColor;
  final Color? activeDayColor;
  final Color? activeDayBackgroundColor;
  final bool available;
  final bool showDots;
  final Color? dotsColor;
  final Color? dayNameColor;
  final bool showDayName;
  final Color? unselectedDayNameColor;
  final Color? weekendDayNameColor;

  const DayItem({
    Key? key,
    required this.dayNumber,
    required this.shortName,
    required this.onTap,
    this.isSelected = false,
    this.isWeekDay = false,
    this.dayColor,
    this.activeDayColor,
    this.activeDayBackgroundColor,
    this.available = true,
    this.showDots = true,
    this.dotsColor,
    this.dayNameColor,
    this.showDayName = false,
    this.unselectedDayNameColor,
    this.weekendDayNameColor,
  }) : super(key: key);

  final double height = 70.0;
  final double width = 60.0;
  final double dotsContainerHeight = 14.0;
  final double dayContainerHeight = 20.0;

  _buildDay(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: available
            ? dayColor ?? Theme.of(context).colorScheme.secondary
            : dayColor?.withOpacity(0.5) ?? Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        fontSize: 26,
        fontWeight: FontWeight.normal);

    if (isWeekDay) {
      textStyle = textStyle.copyWith(
        color: weekendDayNameColor ?? textStyle.color,
      );
    }

    final selectedStyle = TextStyle(
      color: activeDayColor ?? Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    );

    TextStyle dayNameTextStyle = isSelected
        ? TextStyle(
            color: dayNameColor ?? activeDayColor ?? Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          )
        : TextStyle(
            color: unselectedDayNameColor ?? Colors.white,
            fontSize: 14,
          );

    if (isWeekDay && !isSelected) {
      dayNameTextStyle = dayNameTextStyle.copyWith(
        color: weekendDayNameColor ?? dayNameTextStyle.color,
      );
    }

    return GestureDetector(
      onTap: available ? onTap as void Function()? : null,
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                color: activeDayBackgroundColor ?? Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12.0),
              )
            : const BoxDecoration(color: Colors.transparent),
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            showDots
                ? SizedBox(
                    height: dotsContainerHeight,
                    child: isSelected && showDots ? _buildDots() : const SizedBox(),
                  )
                : const SizedBox(),
            SizedBox(
              height: height - dotsContainerHeight - dayContainerHeight,
              child: Center(
                child: Text(
                  dayNumber.toString(),
                  style: isSelected ? selectedStyle : textStyle,
                ),
              ),
            ),
            SizedBox(
              height: dayContainerHeight,
              child: isSelected || showDayName
                  ? Text(
                      shortName,
                      style: dayNameTextStyle,
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDots() {
    final dot = Container(
      height: 5,
      width: 5,
      decoration: BoxDecoration(
        color: dotsColor ?? activeDayColor ?? Colors.white,
        shape: BoxShape.circle,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [dot, dot],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDay(context);
  }
}
