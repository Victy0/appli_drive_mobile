import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:flutter/material.dart';

class IndividualSelection extends StatefulWidget {
  final Function(int) onOptionSelected;
  final int? initialOption;

  const IndividualSelection({
    super.key,
    required this.onOptionSelected,
    this.initialOption,
  });

  @override
  State<IndividualSelection> createState() => IndividualSelectionState();
}

class IndividualSelectionState extends State<IndividualSelection> {
  final List<String> _options = [
    "purpose",
    "determination",
    "change",
    "conclusion",
    "understanding",
  ];

  int? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalization.of(context).translate("pages.firstSetupPage.whatYouAreLookinFor"),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _selectedOption,
              dropdownColor: Colors.grey[900],
              iconEnabledColor: Colors.white,
              isExpanded: true,
              items: List.generate(_options.length, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      AppLocalization.of(context).translate("pages.firstSetupPage.options.${_options[index]}"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
              onChanged: (int? newIndex) {
                if (newIndex != null) {
                  setState(() {
                    _selectedOption = newIndex;
                  });
                  widget.onOptionSelected(newIndex);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
