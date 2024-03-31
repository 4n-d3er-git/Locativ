import 'package:flutter/material.dart';

Column paidstats(snap) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Prix:",
        style: TextStyle(color: Colors.grey[600]),
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        "${snap!['prix']}",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    ],
  );
}
