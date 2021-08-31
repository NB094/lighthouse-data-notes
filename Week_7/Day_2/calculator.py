
from flask import Flask, jsonify

from flask_restful import Resource, Api, reqparse



app = Flask(__name__)


api = Api(app)

class add(Resource):
    def get(self):
        # create request parser
        parser = reqparse.RequestParser()

        # create and parse 'num_1' and 'num_2' arguments
        parser.add_argument('num_1', type=int)
        parser.add_argument('num_2', type=int)
        num_1 = parser.parse_args().get('num_1')
        num_2 = parser.parse_args().get('num_2')

        if num_1 == None or num_2 == None:
            result = 'Please supply two numbers.'
        else:
            result = num_1 + num_2

        # make json from result value
        return jsonify(result=result)

class subtract(Resource):
    def get(self):
        # create request parser
        parser = reqparse.RequestParser()

        # create and parse 'num_1' and 'num_2' arguments
        parser.add_argument('num_1', type=int)
        parser.add_argument('num_2', type=int)
        num_1 = parser.parse_args().get('num_1')
        num_2 = parser.parse_args().get('num_2')

        if num_1 == None or num_2 == None:
            result = 'Please supply two numbers.'
        else:
            result = num_1 - num_2

        # make json from result value
        return jsonify(result=result)

class multiply(Resource):
    def get(self):
        # create request parser
        parser = reqparse.RequestParser()

        # create and parse 'num_1' and 'num_2' arguments
        parser.add_argument('num_1', type=int)
        parser.add_argument('num_2', type=int)
        num_1 = parser.parse_args().get('num_1')
        num_2 = parser.parse_args().get('num_2')

        if num_1 == None or num_2 == None:
            result = 'Please supply two numbers.'
        else:
            result = num_1 * num_2

        # make json from result value
        return jsonify(result=result)

class divide(Resource):
    def get(self):
        # create request parser
        parser = reqparse.RequestParser()

        # create and parse 'num_1' and 'num_2' arguments
        parser.add_argument('num_1', type=int)
        parser.add_argument('num_2', type=int)
        num_1 = parser.parse_args().get('num_1')
        num_2 = parser.parse_args().get('num_2')

        if num_1 == None or num_2 == None:
            result = 'Please supply two numbers.'
        else:
            result = num_1 / num_2

        # make json from result value
        return jsonify(result=result)                        


api.add_resource(add, '/add',)
api.add_resource(subtract, '/subtract',)
api.add_resource(multiply, '/multiply',)
api.add_resource(divide, '/divide',)

if __name__ == '__main__':
    app.run(debug=True, use_reloader=False)

# example of what to type into browser:  http://127.0.0.1:5000/divide?num_1=5&num_2=4




