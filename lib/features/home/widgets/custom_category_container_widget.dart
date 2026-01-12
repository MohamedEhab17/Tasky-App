import 'package:flutter/material.dart';

// class CustomCategoryContainerWidget extends StatefulWidget {
//   const CustomCategoryContainerWidget({
//     super.key,
//     required this.title,
//     this.onTapDown,
//     this.hasMenu = false,
//   });

//   final Function(TapDownDetails)? onTapDown;
//   final String title;
//   final bool hasMenu;

//   @override
//   State<CustomCategoryContainerWidget> createState() =>
//       _CustomCategoryContainerWidgetState();
// }

// class _CustomCategoryContainerWidgetState
//     extends State<CustomCategoryContainerWidget> {
//   bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     double turns = _isExpanded ? 0.5 : 0.0;

//     return GestureDetector(
//       onTapDown: (details) {
//         setState(() {
//           _isExpanded = !_isExpanded;
//         });
//         if (widget.onTapDown != null) {
//           widget.onTapDown!(details);
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         margin: const EdgeInsets.only(bottom: 18),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(6),
//           border: Border.all(color: const Color(0xff6E6A7C)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               widget.title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//             ),
//             const SizedBox(width: 8),
//             if (widget.hasMenu)
//               AnimatedRotation(
//                 turns: turns,
//                 duration: const Duration(milliseconds: 250),
//                 child: Icon(
//                   Icons.keyboard_arrow_down_rounded,
//                   color: Theme.of(context).textTheme.bodyLarge?.color,
//                   size: 20,
//                   textDirection: TextDirection.ltr,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class CustomCategoryContainerWidget extends StatelessWidget {
  const CustomCategoryContainerWidget({
    super.key,
    required this.title,
    this.onTapDown,
    this.hasMenu = false,
    this.isMenuOpen = false,
  });

  final Function(TapDownDetails)? onTapDown;
  final String title;
  final bool hasMenu;
  final bool isMenuOpen; 

  @override
  Widget build(BuildContext context) {
    double turns = isMenuOpen ? 0.5 : 0.0;

    return GestureDetector(
      onTapDown: onTapDown,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xff6E6A7C)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            const SizedBox(width: 8),
            if (hasMenu)
              AnimatedRotation(
                turns: turns,
                duration: const Duration(milliseconds: 250),
                child: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  textDirection: TextDirection.ltr, 
                ),
              ),
          ],
        ),
      ),
    );
  }
}