from flask import Flask, request, jsonify
from flask_restful import Api, Resource, reqparse
import mlflow
import json
import pandas as pd
from flask_cors import CORS 


app = Flask(__name__)
api = Api(app)
CORS(app)


# Define the path to the logged MLflow model
event_recommendation1 = 'runs:/62fd2aa987b94d4398ec7acb9eb6c52d/event_recommendation_pyfunc'
book_recommendation = 'runs:/cb7457e92f094c0eb983b2ef35615a79/bookPopularity_recommendation_pyfunc'
#event_recommendation2 = 'runs:/575b53a0a93a488ca20dd483d86e3139/KNN_event_recommendation_pyfunc'

# Load the MLflow model for event recommendaiton using cosine
event_cosine_model =mlflow.pyfunc.load_model(event_recommendation1)
book_popularity = mlflow.pyfunc.load_model(book_recommendation)
#event_knn_model = mlflow.pyfunc.load_model(event_recommendation2)

class Recommenadation1(Resource):
    def post(self):
        try:
            data = request.get_json()
            if not data:
                return {"message": "Empty Input"}, 400
            
            # Validate input data keys
            expected_keys = {"goalName", "description", "beginDate", "endDate"}
            if not all(key in data for key in expected_keys):
                return {"message": "Missing required fields"}, 400
            
            # Validate input data values
            for key, value in data.items():
                if not value:
                    return {"message": f"Empty value for {key}"}, 400
                
            goalName = data.get("goalName")
            description = data.get("description")
            beginDate = data.get("beginDate")
            endDate = data.get("endDate")

            input_data = {
                "goalName": goalName,
                "description": description,
                "beginDate": beginDate,
                "endDate" : endDate
            }
            event1 = event_cosine_model.predict(input_data)
            #event2 = event_knn_model.predict(input_data)
            books = book_popularity.predict(input_data)
            event1 = {key: str(value) if isinstance(value, pd.Timestamp) else value for key, value in event1.items()}
            #event2 = {key: str(value) if isinstance(value, pd.Timestamp) else value for key, value in event2.items()}
            # Convert Timestamp objects to strings
            #event1 = [{key: str(value) if isinstance(value, pd.Timestamp) else value for key, value in event.items()} for event in event1]
            # Convert predictions to a JSON response
            '''response = {"bookPopularity":books,
                        "eventRecommendationCosine":event1,
                        "eventRecommendatioKNN":event2}
            '''
            response = {"bookPopularity":books,
                        "eventRecommendation":event1,}
            
            return jsonify(response)
            
        
        
        except Exception as e:
            return {"message": "An error occurred", "error": str(e)}, 500


api.add_resource(Recommenadation1, '/recommendation')

if __name__ == '__main__':
    app.run(debug=True,port=8000)