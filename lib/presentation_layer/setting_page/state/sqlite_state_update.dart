import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SqliteStateUpdate extends Equatable {

}

class SqliteInitialState extends SqliteStateUpdate {
  SqliteInitialState();
  @override
  List<Object?> get props => [];
}

class OnSqliteUpdated extends SqliteStateUpdate {
  final Uint8List path;
  final String userName;
  OnSqliteUpdated({required this.path,required this.userName});

  @override
  List<Object?> get props => [path,userName];
}