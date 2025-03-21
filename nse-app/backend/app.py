from flask import Flask, jsonify
from flask_cors import CORS
from fetch_data import get_top_gainers, get_top_losers

app = Flask(__name__)
CORS(app)  # Enable CORS for frontend

@app.route('/api/gainers')
def gainers():
    return jsonify(get_top_gainers())

@app.route('/api/losers')
def losers():
    return jsonify(get_top_losers())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)