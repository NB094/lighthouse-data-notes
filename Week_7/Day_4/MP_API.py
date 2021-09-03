#!/usr/bin/env python
# coding: utf-8

# In[1]:


# import Flask and jsonify
from flask import Flask, jsonify, request
# import Resource, Api and reqparser
from flask_restful import Resource, Api, reqparse
import pandas as pd
import numpy as np
import pickle


# In[2]:


app = Flask(__name__)
api = Api(app)


# In[3]:


from sklearn.pipeline import Pipeline

class DataframeFunctionTransformer():
    def __init__(self, func):
        self.func = func

    def transform(self, input_df, **transform_params):       
        return self.func(input_df)

    def fit(self, X, y=None, **fit_params):
        return self

def process_dataframe(input_df):  
    #input_df = pd.DataFrame(input_df)
    
    input_df.drop(columns=['Loan_ID'], inplace=True)
    
    input_df = input_df.astype({'Credit_History':str})
    
    input_df['ln(LoanAmount)'] = np.log(input_df['LoanAmount'])
    input_df['Total_Income'] = input_df['ApplicantIncome'] + input_df['CoapplicantIncome']
    input_df['ln(Total_Income)'] = np.log(input_df['Total_Income'].astype(float))

    input_df['LoanRatio'] = input_df['LoanAmount'] / input_df['Loan_Amount_Term']
    
    return input_df

def convert_credit_int(input_df):
    input_df = input_df.astype({'Credit_History':'int'})
    return input_df

def convert_credit_str(input_df):
    input_df = input_df.astype({'Credit_History':'str'})
    return input_df

def split_data(input_df):
    X = input_df.loc[:, df_pipe.columns != 'Loan_Status']
    y = input_df.loc[:,'Loan_Status']
    X_train_pipe, X_test_pipe, y_train_pipe, y_test_pipe = train_test_split(X,y,test_size=0.25)
    return X_train_pipe, X_test_pipe, y_train_pipe, y_test_pipe

def backtopd(array):
    return pd.DataFrame(array, columns=['ApplicantIncome', 'CoapplicantIncome', 'LoanAmount', 'Loan_Amount_Term', 'Gender', 'Married', 'Dependents', 'Education', 'Self_Employed', 'Property_Area', 'Credit_History', 'Loan_ID'])

def logcolumn(input_df):
    input_df['LoanAmount'] = input_df['LoanAmount'].astype(float)
    return input_df


# In[4]:


model = pickle.load( open( "model.p", "rb" ) )


# In[9]:


class Scoring(Resource):
    def post(self):
        json_data = request.get_json()
        df = pd.DataFrame(json_data.values(), index=json_data.keys()).transpose()
        # getting predictions from our model.
        # it is much simpler because we used pipelines during development
        res = model.predict_proba(df)
        # we cannot send numpy array as a result
        return res.tolist()


# In[6]:


# assign endpoint
api.add_resource(Scoring, '/scoring')


# In[8]:


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5555, debug=True, use_reloader=False)

