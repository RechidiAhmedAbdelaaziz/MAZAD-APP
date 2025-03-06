import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/themes/colors.dart';

class KSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final double? width;
  const KSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    this.width,
  });

  @override
  State<KSearchBar> createState() => _KSearchBarState();
}

class _KSearchBarState extends State<KSearchBar> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 800),
      () => widget.onSearch(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: KColors.grey),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: KColors.primary),
          widthSpace(8),
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: _onSearchChanged, // Use debounced onChanged
              decoration: InputDecoration(
                hintText: 'Search'.tr(context),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
