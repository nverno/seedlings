import sqlite3
import random


conn = sqlite3.connect("test.sqlite")
cur = conn.cursor()
cur.executescript('''
DROP TABLE IF EXISTS test;

CREATE TABLE test (
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
   name TEXT UNIQUE,
   value INTEGER
);
''')

letters = "abcdefghijklmnopqrstuvwxyz"
for i in range(26):
    cur.execute('''INSERT OR IGNORE INTO test (name, value) 
    VALUES ( ?, ? )''', ( letters[i], random.randrange(100), ))

conn.commit()
conn.close()
