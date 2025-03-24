import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cabeleleila/app/theme.dart';
import 'package:flutter/material.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context, initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final List<String> list = ['Developer', 'Designer', 'Consultant', 'Student'];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.0,
          children: [
            CustomDropdown<String>(
              decoration: CustomDropdownDecoration(
                listItemDecoration: ListItemDecoration(),
                closedBorder: Border.all(width: 3, color: ColorSchemeManagerClass.colorPrimary),
                expandedBorder: Border.all(width: 3, color: ColorSchemeManagerClass.colorPrimary),
                headerStyle: TextStyle(color: ColorSchemeManagerClass.colorBlack),
                listItemStyle: TextStyle(color: ColorSchemeManagerClass.colorBlack),
                expandedBorderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Select job role',
              items: list,
              initialItem: list[0],
              excludeSelected: false,
              onChanged: (value) {},
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text('Adicionar outro serviço')
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  selectedDate == null
                      ? 'Selecionar data'
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                ),
                trailing: Icon(Icons.calendar_month_outlined),
              ),
            ),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  selectedTime == null ? 'Selecionar horário' : selectedTime!.format(context),
                ),
                trailing: Icon(Icons.timer_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
