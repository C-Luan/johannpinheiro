import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/work.dart';

class WorkRepository {
  static Future<List<Work>> loadWorks() async {
    final raw = await rootBundle.loadString('assets/works.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    return (data['works'] as List)
        .map((e) => Work.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
