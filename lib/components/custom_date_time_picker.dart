import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatetimePicker extends FormField<DateTime> {
  CustomDatetimePicker({
    super.key,
    required String labelText,
    required void Function(DateTime?)? onDatePicked,
    required String hintText,
    super.validator,
    super.initialValue,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    TextStyle? labelStyle,
    bool isFilled = true,
    Color? hintTextColor,
    bool hasContainer = false,
    double? height,
    FontWeight? fontWeight,
    bool isRequired = false,
    bool readOnly = false,
    String? dateFormat,
  }) : super(
          onSaved: onDatePicked,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (FormFieldState<DateTime> state) {
            debugPrint('Initial date $initialDate');

            debugPrint('${state.value}');

            return Builder(builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (labelText.isNotEmpty) ...[
                    Row(
                      children: [
                        Text(
                          labelText,
                          style: labelStyle ??
                              const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                        ),
                        isRequired
                            ? const Text(
                                ' *',
                                style: TextStyle(color: Colors.red),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                  SizedBox(
                    height: height ?? (hasContainer ? 34 : 50),
                    child: dateTimeButton(context,
                        state: state,
                        isFilled: isFilled,
                        lastDate: lastDate,
                        initialDate: initialDate,
                        firstDate: firstDate,
                        hintText: hintText,
                        hintTextColor: hintTextColor,
                        hasSide: hasContainer,
                        hasSuffixIcon: hasContainer,
                        fontWeight: fontWeight,
                        dateFormat: dateFormat,
                        readOnly: readOnly),
                  ),
                  state.hasError
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8.0,
                          ),
                          child: Text(
                            state.errorText ?? "",
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Container()
                ],
              );
            });
          },
        );
}

Widget dateTimeButton(
  BuildContext context, {
  required FormFieldState<DateTime> state,
  bool isFilled = false,
  Color? hintTextColor,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  FontWeight? fontWeight,
  required String hintText,
  bool hasSide = false,
  String? dateFormat,
  bool hasSuffixIcon = false,
  bool readOnly = false,
}) {
  return Container(
    padding:
        hasSide ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      border: Border.all(),
      // color: Colors.grey.shade400,
      // border: hasSide
      //     ? const Border(
      //         bottom: BorderSide(
      //           color: AppColors.blueColor,
      //         ),
      //       )
      //     : Border.all(
      //         width: 1.4,
      //         color:
      //             state.hasError ? Colors.red.shade600 : AppColors.borderColor,
      //       ),
      borderRadius: hasSide ? null : BorderRadius.circular(10.0),
    ),
    child: InkWell(
      onTap: readOnly
          ? null
          : () async {
              final date = await showDatePicker(
                // selectableDayPredicate: ,
                context: context,
                initialDate: initialDate ?? lastDate ?? DateTime.now(),
                firstDate: firstDate ??
                    DateTime(
                      DateTime.now().year - 100,
                    ),
                lastDate: lastDate ?? DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(colorScheme: Theme.of(context).colorScheme),
                    child: child!,
                  );
                },
              );
              if (date != null) {
                state.didChange(date);
                state.save();
              }
            },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            state.value != null
                ? DateFormat(dateFormat ?? "yyyy-MM-dd").format(state.value!)
                : hintText,
            style: TextStyle(
              color: state.value != null
                  ? Colors.black
                  : hintTextColor ?? Colors.grey,
              fontSize: 14.0,
              fontWeight: fontWeight,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          hasSuffixIcon
              ? const SizedBox()
              : Icon(Icons.calendar_month,
                  color: state.hasError ? Colors.red.shade600 : Colors.grey)
        ],
      ),
    ),
  );
}
