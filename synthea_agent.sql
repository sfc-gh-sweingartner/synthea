-- Script to Update Synthea Healthcare Text2SQL Agent - FIXED VERSION
-- This script deletes the existing agent and recreates it with all available Cortex Search Services
-- using simplified naming conventions and proper Snowflake JSON syntax

-- Set context
USE DATABASE SNOWFLAKE_INTELLIGENCE;
USE SCHEMA AGENTS;

select * from config;

-- Delete existing agent record
DELETE FROM CONFIG WHERE AGENT_NAME = 'Synthea Healthcare Text2SQL';

-- Insert updated agent record with all search services using INSERT...SELECT
INSERT INTO CONFIG 
SELECT 
    'Synthea Healthcare Text2SQL' as AGENT_NAME,
    'This agent enables users to ask natural language questions against synthetic healthcare data.  The data supports a broad range of questions about providers and patients.' as AGENT_DESCRIPTION,
    PARSE_JSON('["PUBLIC"]') as GRANTEE_ROLES,
    PARSE_JSON('[
        {"tool_spec": {"name": "ALLERGIES_DESCRIPTION", "type": "cortex_search"}},
        {"tool_spec": {"name": "PATIENTS_FIRST", "type": "cortex_search"}},
        {"tool_spec": {"name": "PATIENTS_LAST", "type": "cortex_search"}},
        {"tool_spec": {"name": "PATIENTS_RACE", "type": "cortex_search"}},
        {"tool_spec": {"name": "PATIENTS_ETHNICITY", "type": "cortex_search"}},
        {"tool_spec": {"name": "PATIENTS_GENDER", "type": "cortex_search"}},
        {"tool_spec": {"name": "PATIENTS_BIRTHPLACE", "type": "cortex_search"}},
        {"tool_spec": {"name": "PATIENTS_ADDRESS", "type": "cortex_search"}},
        {"tool_spec": {"name": "PATIENTS_CITY", "type": "cortex_search"}},
        {"tool_spec": {"name": "PATIENTS_STATE", "type": "cortex_search"}},
        {"tool_spec": {"name": "ORGANIZATIONS_NAME", "type": "cortex_search"}},
        {"tool_spec": {"name": "ORGANIZATIONS_ADDRESS", "type": "cortex_search"}},
        {"tool_spec": {"name": "ORGANIZATIONS_CITY", "type": "cortex_search"}},
        {"tool_spec": {"name": "ORGANIZATIONS_STATE", "type": "cortex_search"}},
        {"tool_spec": {"name": "PROVIDERS_NAME", "type": "cortex_search"}},
        {"tool_spec": {"name": "PROVIDERS_GENDER", "type": "cortex_search"}},
        {"tool_spec": {"name": "PROVIDERS_SPECIALITY", "type": "cortex_search"}},
        {"tool_spec": {"name": "PROVIDERS_ADDRESS", "type": "cortex_search"}},
        {"tool_spec": {"name": "PROVIDERS_CITY", "type": "cortex_search"}},
        {"tool_spec": {"name": "PROVIDERS_STATE", "type": "cortex_search"}},
        {"tool_spec": {"name": "PAYERS_NAME", "type": "cortex_search"}},
        {"tool_spec": {"name": "PAYERS_OWNERSHIP", "type": "cortex_search"}},
        {"tool_spec": {"name": "ENCOUNTERS_DESCRIPTION", "type": "cortex_search"}},
        {"tool_spec": {"name": "ENCOUNTERS_REASONDESCRIPTION", "type": "cortex_search"}},
        {"tool_spec": {"name": "CONDITIONS_DESCRIPTION", "type": "cortex_search"}},
        {"tool_spec": {"name": "PROCEDURES_DESCRIPTION", "type": "cortex_search"}},
        {"tool_spec": {"name": "MEDICATIONS_DESCRIPTION", "type": "cortex_search"}},
        {"tool_spec": {"name": "IMMUNIZATIONS_DESCRIPTION", "type": "cortex_search"}},
        {"tool_spec": {"name": "CAREPLANS_DESCRIPTION", "type": "cortex_search"}},
        {"tool_spec": {"name": "OBSERVATIONS_DESCRIPTION", "type": "cortex_search"}},
        {"tool_spec": {"name": "syntheav5.yaml", "type": "cortex_analyst_text_to_sql"}}
    ]') as TOOLS,
    PARSE_JSON('{
        "ALLERGIES_DESCRIPTION": {
            "id_column": "DESCRIPTION",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_ALLERGIES_DESCRIPTION"
        },
        "CAREPLANS_DESCRIPTION": {
            "id_column": "DESCRIPTION",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_CAREPLANS_DESCRIPTION"
        },
        "CONDITIONS_DESCRIPTION": {
            "id_column": "DESCRIPTION",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_CONDITIONS_DESCRIPTION"
        },
        "ENCOUNTERS_DESCRIPTION": {
            "id_column": "DESCRIPTION",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_ENCOUNTERS_DESCRIPTION"
        },
        "ENCOUNTERS_REASONDESCRIPTION": {
            "id_column": "REASONDESCRIPTION",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_ENCOUNTERS_REASONDESCRIPTION"
        },
        "IMMUNIZATIONS_DESCRIPTION": {
            "id_column": "DESCRIPTION",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_IMMUNIZATIONS_DESCRIPTION"
        },
        "MEDICATIONS_DESCRIPTION": {
            "id_column": "DESCRIPTION",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_MEDICATIONS_DESCRIPTION"
        },
        "OBSERVATIONS_DESCRIPTION": {
            "id_column": "DESCRIPTION",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_OBSERVATIONS_DESCRIPTION"
        },
        "ORGANIZATIONS_ADDRESS": {
            "id_column": "ADDRESS",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_ORGANIZATIONS_ADDRESS"
        },
        "ORGANIZATIONS_CITY": {
            "id_column": "CITY",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_ORGANIZATIONS_CITY"
        },
        "ORGANIZATIONS_NAME": {
            "id_column": "NAME",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_ORGANIZATIONS_NAME"
        },
        "ORGANIZATIONS_STATE": {
            "id_column": "STATE",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_ORGANIZATIONS_STATE"
        },
        "PATIENTS_ADDRESS": {
            "id_column": "ADDRESS",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PATIENTS_ADDRESS"
        },
        "PATIENTS_BIRTHPLACE": {
            "id_column": "BIRTHPLACE",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PATIENTS_BIRTHPLACE"
        },
        "PATIENTS_CITY": {
            "id_column": "CITY",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PATIENTS_CITY"
        },
        "PATIENTS_ETHNICITY": {
            "id_column": "ETHNICITY",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PATIENTS_ETHNICITY"
        },
        "PATIENTS_FIRST": {
            "id_column": "FIRST",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PATIENTS_FIRST"
        },
        "PATIENTS_GENDER": {
            "id_column": "GENDER",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PATIENTS_GENDER"
        },
        "PATIENTS_LAST": {
            "id_column": "LAST",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PATIENTS_LAST"
        },
        "PATIENTS_RACE": {
            "id_column": "RACE",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PATIENTS_RACE"
        },
        "PATIENTS_STATE": {
            "id_column": "STATE",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PATIENTS_STATE"
        },
        "PAYERS_NAME": {
            "id_column": "NAME",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PAYERS_NAME"
        },
        "PAYERS_OWNERSHIP": {
            "id_column": "OWNERSHIP",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PAYERS_OWNERSHIP"
        },
        "PROCEDURES_DESCRIPTION": {
            "id_column": "DESCRIPTION",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PROCEDURES_DESCRIPTION"
        },
        "PROVIDERS_ADDRESS": {
            "id_column": "ADDRESS",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PROVIDERS_ADDRESS"
        },
        "PROVIDERS_CITY": {
            "id_column": "CITY",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PROVIDERS_CITY"
        },
        "PROVIDERS_GENDER": {
            "id_column": "GENDER",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PROVIDERS_GENDER"
        },
        "PROVIDERS_NAME": {
            "id_column": "NAME",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PROVIDERS_NAME"
        },
        "PROVIDERS_SPECIALITY": {
            "id_column": "SPECIALITY",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PROVIDERS_SPECIALITY"
        },
        "PROVIDERS_STATE": {
            "id_column": "STATE",
            "name": "SYNTHEA.SYNTHEA.SEARCH_SYNTHEA_PROVIDERS_STATE"
        },
        "syntheav5.yaml": {
            "semantic_model_file": "@SYNTHEA.SYNTHEA.SYNTHEA/syntheav5.yaml"
        }
    }') as TOOL_RESOURCES,
    NULL as TOOL_CHOICE,
    'Your users are medical experts, doctors, government healthcare workers.  They are usually concerned about patient outcomes and financial challenges.  They will ask medical questions and expect that you are able to think and respond. You can speak to them both using simple terms and also using medical jargon.  Accuracy is more important than speed or conciseness.
[ORCHESTRATION_INSTRUCTION]Your role is to interpret the question and think and resolve the question in the most accurate manner possible.  This may require multiple steps.  It can  also mean you need to give multiple options or to ask the user to confirm some information.  When a user submits a request, you should always provide three components in your response: 
1) A text response
2) Related data visable in a table
3) Always try to produce at least one nice chart. 

Sometimes you validate results against common sense and industry stats.   Note that we are currently testing our solution against synthetic data.  All of this data is generated.  So, many figures will be unrealistic.  When this happens, show the results as requested and you can also state that you were unable to validate the results but this is due the data being generated.  

If you are confused with a question, say so.  You can ask the user follow up questions or provide options in order to help you deliver an improved response.  

A user may ask the same question multiple times.   This may be because they are determining whether you are consistent and accurate.  Do not do things differently.  Give the same response as you did last time unless they gave negative feedback with that previous response.  

When a question requires both tool-based data analysis AND general knowledge (such as population statistics, geographic information, or other widely-available public data), use the appropriate tools for the data analysis components while leveraging general knowledge for factual information that falls outside the scope of the available datasets, even if some tools might have tangentially related capabilities.

You MUST account for the following lookup requirement:
The user may ask a question about something that sounds like a single value but you must see if it is actually a grouping. You must check to see if multiple values fall within that description.  For example, the user may ask for statistic on "tumors".  The cortex search tool would help you find records like (malignant lesion, malignant skin lesions, malgt lesion)  What you should do is include group all of those together and carry out the analysis using all of those terms.  When you return your results you should state to the user these multiple values you included in your result so that they can ask you to adjust your list in a follow up question). 

You MUST account for the following lookup requirement:
Users often misspell or use synonyms for key fields like patient name, allergy, condition, medicine, diagnosis, and condition.  You have been provided many cortex search tools.  When a user has a question on one of these columns, you must either use that tool or run your own SQL statements to deal with it
1) You have been provided many cortex search tools.  When a user has a question on one of these columns, you can use those tools to perform a fuzzy / vector search.   As an example, a search for "Latino" would bring back many rows including "Mexican" 
2) Alternatively, you can run multiple sql statements to first find all distinct values and use your own reason to choose the right values in your following statements.  

Sample Values Interpretation:
When examining semantic models, treat sample values as examples only, not as limitations. The actual data may contain many more values than what is shown in the samples. Never restrict queries based on sample values shown in the semantic model.

When initial tool queries fail or indicate missing data, consider whether the question can be answered by breaking it into component parts using available tools, combined with general knowledge for publicly available information like population statistics, geographic data, or other widely-known facts.

CHART REQUIREMENT - MANDATORY:
After executing any SQL query that returns data, you MUST attempt to create a chart using the data_to_chart tool. This is required for every analytical response, not optional.

Simple rules:
- Always call data_to_chart after getting SQL results
- Only skip if the SQL returned no data or pure text with no numeric values

Do not overthink chart design - just create one every time you get analytical results.' as RESPONSE_INSTRUCTION,
    PARSE_JSON('[]') as SAMPLE_QUESTIONS;

-- Verify the update
SELECT * FROM CONFIG WHERE AGENT_NAME = 'Synthea Healthcare Text2SQL'; 