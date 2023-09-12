import UIKit
import SQLite3

//destroyPart1Database()
let part1DbPath:String? = "test.sqlite"


func openDatabase() -> OpaquePointer? {
  var db: OpaquePointer?
  guard let part1DbPath = part1DbPath else {
    print("part1DbPath is nil.")
    return nil
  }
  if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
    print("Successfully opened connection to database at \(part1DbPath)")
    return db
  } else {
    print("Unable to open database.")
   return nil
  }
}
let db = openDatabase()

let createTableString = """
create table contact(
id int primary key not null,
name char(255))
"""

func createTable() {
  // 1
  var createTableStatement: OpaquePointer?
  // 2
  if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
      SQLITE_OK {
    // 3
    if sqlite3_step(createTableStatement) == SQLITE_DONE {
      print("\nContact table created.")
    } else {
      print("\nContact table is not created.")
    }
  } else {
    print("\nCREATE TABLE statement is not prepared.")
  }
  // 4
  sqlite3_finalize(createTableStatement)
}
createTable()

let insertStatementString = "INSERT INTO Contact (Id, Name) VALUES (?, ?);"

func insert() {
  var insertStatement: OpaquePointer?
  // 1
  if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
      SQLITE_OK {
    let id: Int32 = 2
    let name: NSString = "Esraa"
    // 2
    sqlite3_bind_int(insertStatement, 1, id)
    // 3
    sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
    // 4
    if sqlite3_step(insertStatement) == SQLITE_DONE {
      print("\nSuccessfully inserted row.")
    } else {
      print("\nCould not insert row.")
    }
  } else {
    print("\nINSERT statement is not prepared.")
  }
  // 5
  sqlite3_finalize(insertStatement)
}
insert()

let queryStatementString = "SELECT * FROM Contact;"

func query() {
  var queryStatement: OpaquePointer?
  // 1
  if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
      SQLITE_OK {
    // 2
    if sqlite3_step(queryStatement) == SQLITE_ROW {
      // 3
      let id = sqlite3_column_int(queryStatement, 0)
      // 4
      guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
        print("Query result is nil")
        return
      }
      let name = String(cString: queryResultCol1)
      print("\nQuery Result:")
      print("\(id) | \(name)")
  } else {
      print("\nQuery returned no results.")
  }
  } else {
      // 6
    let errorMessage = String(cString: sqlite3_errmsg(db))
    print("\nQuery is not prepared \(errorMessage)")
  }
  // 7
  sqlite3_finalize(queryStatement)
}

query()

let deleteStatementString = "DELETE FROM Contact WHERE Id = 1;"

func delete() {
  var deleteStatement: OpaquePointer?
  if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
      SQLITE_OK {
    if sqlite3_step(deleteStatement) == SQLITE_DONE {
      print("\nSuccessfully deleted row.")
    } else {
      print("\nCould not delete row.")
    }
  } else {
    print("\nDELETE statement could not be prepared")
  }
  
  sqlite3_finalize(deleteStatement)
}

delete()
query()
sqlite3_close(db)

