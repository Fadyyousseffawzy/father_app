import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickDate extends StatefulWidget {
  PickDate({
    super.key,
    this.onTap,
    required this.hintText,
    this.onsaved,
    this.onChanged,
    this.labelText,
  });

  final void Function()? onTap;
  final String? hintText;
  Function(String?)? onsaved;
  void Function(String)? onChanged;
  final String? labelText;

  @override
  State<PickDate> createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  final TextEditingController? _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        onSaved: widget.onsaved,
        //onChanged: widget.onChanged,
        controller: _date,
        onChanged: widget.onChanged,
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
            setState(() {
              _date?.text = DateFormat('yyyy-MM-dd').format(pickeddate);
            });
          }
        },
      ),
    );
  }
}
