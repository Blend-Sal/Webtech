from flask import Flask, render_template, request, jsonify
from flask_login import LoginManager, UserMixin
import sqlite3
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash


conn = sqlite3.connect('bridgebuilder.db', check_same_thread=False)
c = conn.cursor()

c.execute('''CREATE TABLE IF NOT EXISTS users
                    (user_id INTEGER PRIMARY KEY AUTOINCREMENT,
                     username TEXT NOT NULL,
                     password TEXT NOT NULL)''')

app = Flask(__name__)
CORS(app)


login_manager = LoginManager(app)
login_manager.init_app(app)

class User(UserMixin):
    def __init__(self, user_id, username, password):
        self.user_id = user_id
        self.username = username
        self.password = password

@login_manager.user_loader
def load_user(user_id):
    c.execute("SELECT * FROM users WHERE user_id = ?", (user_id,))
    data = c.fetchone()
    if data is None:
        return None
    return User(user_id=data[0], username=data[1], password=data[2])

@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')

@app.route('/users')
def get_all_users():
    c.execute("SELECT * FROM users")
    users = c.fetchall()
    return jsonify(users)

@app.route('/register', methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    at_level = data.get('atLevel')
    
    if username is None or password is None:
        return jsonify({"message": "Username and password are required"}), 400
    
    try:
        c = conn.cursor()
        hashed_password = generate_password_hash(password)
        c.execute("INSERT INTO users (username, password) VALUES (?, ?)", (username, hashed_password))
        conn.commit()
        
        return jsonify({"message": f"User {username} created successfully at level {at_level}"}), 201
    except sqlite3.Error as e:
        print("SQLite error:", e)
        return jsonify({"message": "An error occurred during user registration"}), 500
    finally:
        c.close()  


@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if username is None or password is None:
        return jsonify({"message": "Username and password are required"}), 400

    try:
        c = conn.cursor()
        c.execute("SELECT * FROM users WHERE username = ?", (username,))
        user = c.fetchone()

        if user is not None and check_password_hash(user[2], password):
            return jsonify({"message": f"User {username} logged in successfully"}), 200
        else:
            return jsonify({"message": "Invalid username or password"}), 401
    except sqlite3.Error as e:
        print("SQLite error:", e)
        return jsonify({"message": "An error occurred during user login"}), 500
    finally:
        c.close()  

    
@app.route('/delete', methods=['DELETE'])
def delete_user():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if username is None or password is None:
        return jsonify({"message": "Username and password are required"}), 400

    try:
        c = conn.cursor()
        c.execute("SELECT * FROM users WHERE username = ?", (username,))
        user = c.fetchone()

        if user is not None and check_password_hash(user[2], password):
            c.execute("DELETE FROM users WHERE username = ?", (username,))
            conn.commit()
            return jsonify({"message": f"User {username} deleted successfully."}), 200
        else:
            return jsonify({"message": "Invalid username or password"}), 401
    except sqlite3.Error as e:
        print("SQLite error:", e)
        return jsonify({"message": "An error occurred while deleting the user"}), 500
    finally:
        c.close()

@app.route('/update_username', methods=['PUT'])
def update_username():
    data = request.json
    old_username = data.get('old_username')
    new_username = data.get('new_username')
    password = data.get('password')

    if old_username is None or new_username is None or password is None:
        return jsonify({"message": "Old username, new username, and password are required"}), 400

    try:
        c = conn.cursor()
        c.execute("SELECT * FROM users WHERE username = ?", (old_username,))
        user = c.fetchone()

        if user is not None and check_password_hash(user[2], password):
            c.execute("UPDATE users SET username = ? WHERE username = ?", (new_username, old_username))
            conn.commit()
            return jsonify({"message": f"Username updated successfully from {old_username} to {new_username}"}), 200
        else:
            return jsonify({"message": "Invalid old username or password"}), 401
    except sqlite3.Error as e:
        print("SQLite error:", e)
        return jsonify({"message": "An error occurred while updating the username"}), 500
    finally:
        c.close()
        
        
@app.route('/update_password', methods=['PUT'])
def update_password():
    data = request.json
    username = data.get('username')
    old_password = data.get('old_password')
    new_password = data.get('new_password')

    if username is None or old_password is None or new_password is None:
        return jsonify({"message": "Username, old password, and new password are required"}), 400

    try:
    
        c.execute("SELECT * FROM users WHERE username = ?", (username,))
        user = c.fetchone()

        if user is not None and check_password_hash(user[2], old_password):
            new_password_hash = generate_password_hash(new_password)
            c.execute("UPDATE users SET password = ? WHERE username = ?", (new_password_hash, username))
            conn.commit()
            return jsonify({"message": "Password updated successfully"}), 200
        else:
            return jsonify({"message": "Invalid username or old password"}), 401

    except sqlite3.Error as e:
        print("SQLite error:", e)
        return jsonify({"message": "An error occurred while updating the password"}), 500
    finally:
        c.close()





if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True)
