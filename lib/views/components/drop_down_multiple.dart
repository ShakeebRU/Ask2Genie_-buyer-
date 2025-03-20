import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class StyledDropdownMultiple<T> extends StatefulWidget {
  final String hintText;
  final String icon;
  final List<T> selectedItems;
  final List<T> items;
  final ValueChanged<List<T>>? onChanged;
  final String Function(T)? itemLabelBuilder;

  const StyledDropdownMultiple({
    super.key,
    required this.hintText,
    required this.icon,
    required this.items,
    required this.selectedItems,
    this.onChanged,
    this.itemLabelBuilder,
  });

  @override
  _StyledDropdownMultipleState<T> createState() =>
      _StyledDropdownMultipleState<T>();
}

class _StyledDropdownMultipleState<T> extends State<StyledDropdownMultiple<T>> {
  final GlobalKey _dropdownKey = GlobalKey();

  void _openMultiSelectDialog() async {
    final List<T>? selectedItems = await showDialog<List<T>>(
      context: context,
      builder: (context) {
        return MultiSelectDialog<T>(
          items: widget.items,
          selectedItems: widget.selectedItems,
          itemLabelBuilder: widget.itemLabelBuilder,
        );
      },
    );
    if (selectedItems != null) {
      widget.onChanged?.call(selectedItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Constants.secondaryColor,
          width: 0,
          strokeAlign: 0,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: _openMultiSelectDialog,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: widget.selectedItems.isEmpty ? null : widget.hintText,
            labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontFamily: GoogleFonts.antic().fontFamily),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 12.0),
            suffixIcon: SizedBox(
              width: 35,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF333333), Color(0xFF747474)],
                    ),
                    border:
                        Border.all(color: const Color(0xFF333333), width: 0),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    widget.icon,
                    height: 40,
                    width: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          child: widget.selectedItems.isEmpty
              ? Text(
                  widget.hintText,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontFamily: GoogleFonts.antic().fontFamily),
                )
              : Text(
                  widget.selectedItems
                      .map((e) => widget.itemLabelBuilder != null
                          ? widget.itemLabelBuilder!(e)
                          : e.toString())
                      .join(', '),
                  style: TextStyle(
                      fontSize: 13, fontFamily: GoogleFonts.antic().fontFamily),
                ),
        ),
      ),
    );
  }
}

class MultiSelectDialog<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T)? itemLabelBuilder;

  const MultiSelectDialog({
    required this.items,
    required this.selectedItems,
    this.itemLabelBuilder,
  });

  @override
  _MultiSelectDialogState<T> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  late List<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Items'),
      content: SingleChildScrollView(
        child: Column(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: _selectedItems.contains(item),
              title: Text(
                widget.itemLabelBuilder != null
                    ? widget.itemLabelBuilder!(item)
                    : item.toString(),
                style: TextStyle(
                    fontSize: 13, fontFamily: GoogleFonts.antic().fontFamily),
              ),
              onChanged: (isSelected) {
                setState(() {
                  if (isSelected == true) {
                    _selectedItems.add(item);
                  } else {
                    _selectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedItems);
          },
          child: const Text('Done'),
        ),
      ],
    );
  }
}
