import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yumprint/data_layer/db/sqlite_db.dart';
import 'package:yumprint/presentation_layer/setting_page/event/sqlite_event.dart';
import 'package:yumprint/presentation_layer/setting_page/state/sqlite_state_update.dart';

class SqliteBloc extends Bloc<SqliteEvent,SqliteStateUpdate> {
  SqliteBloc():super(SqliteInitialState()){
    on<SqliteUpdateEvent>((event, emit) async {
      print('update_event_triggered.');
      final list = await SqliteDb.sqliteDb.getListItem();
      emit(OnSqliteUpdated(path: base64Decode(list[0].userImage.toString()), userName: list[0].userName.toString()));
    },);
  }
}