import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/components/custom_button.dart';
import 'package:notesapp/components/custom_date_time_picker.dart';
import 'package:notesapp/components/custom_textfield.dart';
import 'package:notesapp/utils/validation.dart';

class AddOrEditNotesPage extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  DateTime dateTime;
  AddOrEditNotesPage(
      {required this.onPressed,
      required this.formKey,
      required this.dateTime,
      required this.titleController,
      required this.descriptionController,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      scrollable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      contentPadding: EdgeInsets.zero,
      content: Builder(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    showRequired: true,
                    controller: titleController,
                    labelText: "Title",
                    validator: (p0) => Validators.isRequired(p0),
                    hintText: "Enter title here",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomDatetimePicker(
                      isRequired: true,
                      isFilled: false,
                      labelText: "Date",
                      onDatePicked: (v) {
                        dateTime = v!;
                      },
                      hintText: "Select Date"),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    showRequired: true,
                    controller: descriptionController,
                    labelText: "Description",
                    maxLines: 4,
                    validator: (p0) => Validators.isRequired(p0),
                    hintText: "Enter description here",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomButton(onPressed: onPressed, label: "Save"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
