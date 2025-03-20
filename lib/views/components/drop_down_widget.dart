// import 'package:flutter/material.dart';
// import 'package:asktogenie/utils/constants.dart';

// class StyledDropdown<T> extends StatelessWidget {
//   final String hintText;
//   final String icon;
//   final T? value;
//   final List<T> items;
//   final ValueChanged<T?>? onChanged;
//   final String Function(T)? itemLabelBuilder;
//   final String? Function(T?)? validator;

//   const StyledDropdown({
//     super.key,
//     required this.hintText,
//     required this.icon,
//     required this.items,
//     this.value,
//     this.onChanged,
//     this.itemLabelBuilder,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: Constants.secondaryColor,
//           width: 0,
//           strokeAlign: 0,
//         ),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(0),
//           bottomRight: Radius.circular(10),
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black,
//             blurRadius: 4,
//             spreadRadius: 1,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: DropdownButtonFormField<T>(
//         value: value,
//         validator: validator,
//         onChanged: onChanged,
//         style: const TextStyle(fontSize: 13, color: Colors.black),
//         decoration: InputDecoration(
//           labelText: hintText,
//           labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),
//           border: const OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: Colors.white, width: 1, strokeAlign: 0.5),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(0),
//               bottomRight: Radius.circular(10),
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//             ),
//           ),
//           errorBorder: const OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: Colors.red, width: 1, strokeAlign: 0.5),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(0),
//               bottomRight: Radius.circular(10),
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//             ),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: Colors.blue, width: 1, strokeAlign: 0.5),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(0),
//               bottomRight: Radius.circular(10),
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//             ),
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: Colors.white, width: 1, strokeAlign: 0.5),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(0),
//               bottomRight: Radius.circular(10),
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//             ),
//           ),
//           disabledBorder: const OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: Colors.white, width: 1, strokeAlign: 0.5),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(0),
//               bottomRight: Radius.circular(10),
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//             ),
//           ),
//           contentPadding: const EdgeInsets.only(left: 12.0),
//           suffixIconColor: Colors.white,
//           suffixIcon: SizedBox(
//             width: 35,
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 width: 30,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [Color(0xFF333333), Color(0xFF747474)],
//                   ),
//                   border: Border.all(color: const Color(0xFF333333), width: 0),
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(10),
//                     bottomRight: Radius.circular(10),
//                     topLeft: Radius.circular(0),
//                     topRight: Radius.circular(10),
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(5.0),
//                 child: Image.asset(
//                   icon,
//                   height: 40,
//                   width: 30,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         items: items.map((item) {
//           return DropdownMenuItem<T>(
//             value: item,
//             child: Text(
//               itemLabelBuilder != null
//                   ? itemLabelBuilder!(item)
//                   : item.toString(),
//               style: const TextStyle(fontSize: 13),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class StyledDropdown<T> extends StatefulWidget {
  final String hintText;
  final String icon;
  final T? value;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemLabelBuilder;
  final String? Function(T?)? validator;

  const StyledDropdown({
    super.key,
    required this.hintText,
    required this.icon,
    required this.items,
    this.value,
    this.onChanged,
    this.itemLabelBuilder,
    this.validator,
  });

  @override
  _StyledDropdownState<T> createState() => _StyledDropdownState<T>();
}

class _StyledDropdownState<T> extends State<StyledDropdown<T>> {
  final GlobalKey _dropdownKey = GlobalKey();
  bool _isDropdownOpened = false;

  void _toggleDropdown() {
    if (_dropdownKey.currentContext != null) {
      setState(() {
        _isDropdownOpened = !_isDropdownOpened;
      });
      GestureDetector? dropdownGestureDetector =
          _findGestureDetector(_dropdownKey.currentContext!);
      dropdownGestureDetector?.onTap!();
    }
  }

  GestureDetector? _findGestureDetector(BuildContext context) {
    // Search for the GestureDetector in the widget tree
    RenderObject? renderObject = context.findRenderObject();
    if (renderObject != null && renderObject.parent is RenderProxyBox) {
      RenderProxyBox proxyBox = renderObject.parent as RenderProxyBox;
      return proxyBox.child?.debugCreator as GestureDetector?;
    }
    return null;
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
      child: DropdownButtonFormField<T>(
        key: _dropdownKey,
        value: widget.value,
        validator: widget.validator,
        onChanged: widget.onChanged,
        style: TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontFamily: GoogleFonts.antic().fontFamily),
        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontFamily: GoogleFonts.antic().fontFamily),
          border: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.white, width: 1, strokeAlign: 0.5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 12.0),
          suffixIcon: GestureDetector(
            onTap: _toggleDropdown,
            child: SizedBox(
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
        ),
        icon: const SizedBox.shrink(), // Remove default dropdown arrow
        items: widget.items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              widget.itemLabelBuilder != null
                  ? widget.itemLabelBuilder!(item)
                  : item.toString(),
              style: TextStyle(
                  fontSize: 13, fontFamily: GoogleFonts.antic().fontFamily),
            ),
          );
        }).toList(),
      ),
    );
  }
}
