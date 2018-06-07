from flask import Flask
app = Flask(__name__)

@app.route('/web')
def hello_world():
    return ('Hi! This web page is using Python + Flask. I\'m 1st web endpoint.')

if __name__ == '__main__':
    app.run(port=3000,host='0.0.0.0')
