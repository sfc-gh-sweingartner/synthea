# Snowflake Synthea Demo
Snowflake Healthcare Demo using Cortex and Synthea 

This git will enable you to create a demo enviornment with syntetic data.  You can run BI reports, streamlit apps on top, 
or build AI solutions.  This git also offers a Cortex Analyst python file and yaml file that allow you to run 
text to SQL / AI against this dataset.  

This solution includes 17 tables with synthetic 5000 patients generated via Synthea 
More information about Synthea is located here:
https://synthetichealth.github.io/synthea/
The data dictionary can be found here:
https://github.com/synthetichealth/synthea/wiki/CSV-File-Data-Dictionary

If required, you could generate a custom dataset yourself via their java program: 
https://github.com/synthetichealth/synthea/wiki/Basic-Setup-and-Running
However, this produces CSV files and some columns were renamed and data types changed so it is better to simply 
receive a Snowflake data share into a Snowflake environment. The steps below assume you will ask for and receive a share.  

Steps to deploy this demo:
1. Have the right Snowflake Account
       a. Need ACCOUNTADMIN access
       b. It must be in a region where Cortex Analyst is available.  Oregon AWS works well.
       c. There are two yaml files.  One (synthea_joins_01.yaml) assumes that a new Private Preview feature which is "Cortex Joins" has been enabled in the account.
       d. A sales engineer can enable that preview feature.  If not, you can use the other yaml file (synthea_model_04) and change that name in the python script accordingly.
       e. Note that as of 19 Sep the new joins feature works pretty well however some queries will fail out.  Please share any errors with the PM team so they can fix the product
3. Find the Account Locator of that enviroment and email or slack it to stephen.weingartner@snowflake.com who will do a direct share of the dataset
4. After being informed the share is ready, then recieve it by 
       a. logging into your env as Accountadmin
       b. Click data products
       c. Click private sharing
       d. Click "Get" for the Synthea dataset
       e. Name this read only database as: SYNTHEA_5000_SHARE_READONLY and the schema should be SYNTHEA
5. Open a SQL worksheet and run the contents of the script: createdb.sql   
       a. (FYI...  That script creates a copy of all those tables into a read / write database and schema (SYNTHEA.SYNTHEA) that you can change as you like.
           Note that the table and column data dictionary comments are not carried across but they have already been loaded into the yaml files) 
7. Download the provided synthea_joins_01.yaml file to your laptop then load it into the SYNTHEA stage by doing the following:
       a. Click on the databases icon on the left
       b. Click on Synthea database then Synthea Schema then Synthea Stage
       c. Click add file and upload the provided YAML file to that stage
8. Configure and run your Cortex Analyst python script by doing the following:
       a. Start an anaconda python environment and open a terminal. (e.g. Install Anaconda Navigator, create a Python env.  Open terminal)
       b. Download the cortex_synthea.py to your laptop
       c. Configure the Snowflake environment details in that file.  (i.e. Replace YOURACCOUNTLOCATOR, YOURUSER, YOURPASSWORD, YOURWAREHOUSE)
       d. Save the file and run the following command:  streamlit run synthea_joins_01.yaml
   
