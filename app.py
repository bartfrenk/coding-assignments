import flask
import json

app = flask.Flask(__name__)

data1 = json.loads(open('file1').read())

@app.route('/')
def index():
    return 'hello world\n\n'


@app.route('/file1')
def file1():
    data1['count'] = data1['count']+1
    return json.dumps(data1, indent=4)

    
@app.route('/file2')
def file2():
    with open('file2') as f:
        return f.read()

    
if __name__ == '__main__':
    app.debug = True
    app.run(port=5000)


