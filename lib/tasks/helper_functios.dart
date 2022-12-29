import 'package:flutter/material.dart';

Widget buildDiary(Widget child) {
  return Container(
    // height: MediaQuery.of(context).size.height - 259,
    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0))),
    child: Row(children: <Widget>[
      const SizedBox(width: 30),
      Container(width: 8, height: double.maxFinite, color: Colors.black45, child: _buildDots()),
      child,
    ]),
  );
}

Widget _buildDots() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(height: 20, decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle)),
      Container(height: 20, decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle)),
      Container(height: 20, decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle)),
      Container(height: 20, decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle)),
      Container(height: 20, decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle)),
      Container(height: 20, decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle)),
      Container(height: 20, decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle)),
      Container(height: 20, decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle)),
    ],
  );
}

class DateField extends StatelessWidget {
  DateField({super.key, this.validator, required this.onTap, this.date});
  final DateTime? date;
  final void Function(DateTime?) onTap;
  final controller = TextEditingController();
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onTap: () {
        showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2050)).then((value) {
          controller.text = value.toString().substring(0, 10);
          onTap(value);
        });
      },
    );
  }
}
