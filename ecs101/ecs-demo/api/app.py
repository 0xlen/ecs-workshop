from flask import Flask
app = Flask(__name__)

@app.route('/api')
def api_index():
    return ('Hello world! This is Python + Flask web example. I\'m 2nd web API endpoint.')

if __name__ == '__main__':
    app.run(port=8000,host='0.0.0.0')
