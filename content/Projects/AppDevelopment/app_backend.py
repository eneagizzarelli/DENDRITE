from flask import Flask, request, jsonify
app = Flask(__name__)
@app.route('/api/tasks', methods=['GET'])
def get_tasks():
    # Placeholder for getting tasks from the database
    tasks = [
        {"id": 1, "title": "Task 1", "completed": False},
        {"id": 2, "title": "Task 2", "completed": True}
    ]
    return jsonify(tasks)
@app.route('/api/tasks', methods=['POST'])
def create_task():
    # Placeholder for creating a new task
    new_task = request.json
    return jsonify(new_task), 201
if __name__ == '__main__':
    app.run(debug=True)