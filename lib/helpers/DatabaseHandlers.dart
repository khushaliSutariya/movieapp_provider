import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Database? db;

  Future<Database> create_db() async {
    if (db != null) {
      return db!;
    } else {
      Directory dir = await getApplicationDocumentsDirectory();
      String dbpath = join(dir.path, "review_db");
      var db = await openDatabase(dbpath, version: 1, onCreate: create_tables);
      return db;
    }
  }

  create_tables(Database db, int version) {
    //create Table
    db.execute(
        "create table review (rid integer primary key autoincrement,addtitle text,addreview text,addrating double, product_id integer)");
    print("Table Created");
  }

  Future<int> insertreview(
      addtitle, addreview, addrating, int productId) async {
    //create db
    var sdb = await create_db();
    print("insert table");
    var iid = await sdb.rawInsert(
        "insert into review (addtitle,addreview,addrating,product_id) values (?,?,?,?)",
        [addtitle, addreview, addrating, productId]);
    return iid;
  }

  Future<List> viewreview(int rId) async {
    var idb = await create_db();
    var data =
        await idb.rawQuery("select * from review where product_id=?",[rId]);
    // print(data.toList());
    return data.toList();
  }

  Future<int> deletereview(int rId) async {
    //create db
    var sdb = await create_db();
    var status = await sdb.rawDelete("delete from review where rid=?", [rId]);
    return status;
  }
}
