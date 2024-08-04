import 'package:flutter/material.dart';

void nav(Widget destination, context) => Navigator.push(
    context,
    PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) => destination));

void back(context) => Navigator.pop(context);
