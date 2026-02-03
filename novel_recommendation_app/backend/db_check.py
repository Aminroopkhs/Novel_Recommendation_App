import sqlite3

DB_PATH = r"C:\Users\poorn\Projects\mad_project\novel_recommendation_app\backend\novel_app.db"

conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

# 1️⃣ List all tables
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = cursor.fetchall()
print("Tables found in DB:")
for table in tables:
    print(table)

# 2️⃣ Try reading users table
print("\nUsers table data:")
# cursor.execute("Truncate user_preferences;")

cursor.execute("select * FROM user_preferences;")
rows = cursor.fetchall()
for row in rows:
    print(row)

conn.close()
