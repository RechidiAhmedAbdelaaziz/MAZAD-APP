import 'package:flutter/material.dart';

extension Responsive on BoxConstraints {
  bool get isMobile => maxWidth < 600;
}
