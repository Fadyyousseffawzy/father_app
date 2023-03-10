import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EdidPickDate extends StatefulWidget {
  EdidPickDate({
    super.key,
    this.onTap,
    required this.hintText,
    this.onChanged,
    this.labelText,
    required this.controller,
  });

  final void Function()? onTap;
  final String? hintText;
  Function(String)? onChanged;
  final String? labelText;
  TextEditingController controller = TextEditingController();
  @override
  State<EdidPickDate> createState() => _EdidPickDateState();
}

class _EdidPickDateState extends State<EdidPickDate> {
  //final TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          icon: const Icon(Icons.calendar_today_outlined),
          labelText: widget.labelText,
          hintText: widget.hintText,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.greenAccent),
          ),
        ),
        onTap: () async {
          DateTime? pickeddate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1920),
              lastDate: DateTime(2300));

          if (pickeddate != null) {
            widget.controller.text =
                DateFormat('yyyy-MM-dd').format(pickeddate);
          }
          widget.onChanged?.call(widget.controller.text);
        },
      ),
    );
  }
}
