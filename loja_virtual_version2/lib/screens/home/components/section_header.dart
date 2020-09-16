import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/models/section.dart';

class SectionHeader extends StatelessWidget {

  const SectionHeader(this.section);
  final Section section;

  @override
  Widget build(BuildContext context) {
    debugPrint("build SectionHeader");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        )
      ),
    );
  }
} 