import 'package:flutter/material.dart';

import '../common/theme.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom(
      {super.key, required this.label, required this.onTap, this.isExpand});

  final String label;
  final Function onTap;
  final bool? isExpand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Align(
            child: Material(
              color: const Color(0xFF00AFFF),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () => onTap(),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: isExpand == null
                      ? null
                      : isExpand!
                          ? double.infinity
                          : null,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 12,
                  ),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: fontRoboto.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
