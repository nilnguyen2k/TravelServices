import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DynamicScheduleWidget extends StatefulWidget {
  
  final TextEditingController timeController = TextEditingController();
  final TextEditingController perController = TextEditingController();
  
  DynamicScheduleWidget({Key? key}) : super(key: key);

  @override
  State<DynamicScheduleWidget> createState() => _DynamicScheduleWidgetState();
}

class _DynamicScheduleWidgetState extends State<DynamicScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          TextFormField(
            controller: widget.timeController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              label: const Text(
                "Time",
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context, 
                    initialTime: const TimeOfDay(hour: 00, minute: 00)
                  );
                  if (newTime == null) {
                    return;
                  }
                  NumberFormat formatter = NumberFormat("00");
                  widget.timeController.text = "${formatter.format(newTime.hour)}:${formatter.format(newTime.minute)}";
                }, 
                icon: const Icon(Icons.schedule)
              )
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 25),
          TextFormField(
            controller: widget.perController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              label: const Text(
                "Quantity Per Day",
              ),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    ); 
  }
}
  



