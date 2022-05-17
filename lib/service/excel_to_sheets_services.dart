import 'dart:io';
import 'package:excel/excel.dart';
import 'package:gsheets/gsheets.dart';

import '../credential.dart';

class ExcelToSheetsService{
  final _gsheets = GSheets(CredentialSs.credentials);
  late final Worksheet? _teste;




}