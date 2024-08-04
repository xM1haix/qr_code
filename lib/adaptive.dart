import 'package:flutter/material.dart';

double adaptive(x, context) => x * MediaQuery.of(context).size.width / 235;
