# Individual HW 1
### Digital Marketing Analytics 2019 - 2020 MSc BA On-campus
This HW constitutes 20 % of your course grade.

You can consult freely (internet, Help, tutorials) as well as members of your group for all programming but you should do the work by yourself. You will have to make a lot of design decisions yourself in the analysis. There is no right answer for many, but you have to write a brief explanation of why you chosed what you chose to do.

See the Instructions for many helpful tips....

1. (10 points) Create a database in Postgresql and load the data files given to your database---this may be more troublesome than it Sounds because of the .csv format, and dates, so start early. If you are having trouble loading with SQL, try the pandas routine, but do use SQL for the queries.
Submission (in a pdf or a text file):
• A query (query only) to identify the top 5 customer locations by average spend.
• If you are using pandas the Python source code you used
• Any auxiliary queries/code that you did to load data, clean up data
(read the description to find the field where this information lies; check the format or put it in the right format; decide what to do with missing data; join tables appropriately to extract)

2. (20 points) Analyse the data set to gain “insights” into them effectiveness of the various direct-marketing channels---specifically catalog mailing vs. email. This is an open-ended HW so no ``right” answer, but you are expected to do substantial work. The grade depends on both effort and scope of your work as well as depth.
A. (5 points) Raise two interesting data-analytical questions you can ask on the data, and study and analyse the data to give answers to your questions. Sample question: which channel has better response rates, catalog mailing or email?
B. (10 points) Segment using the RFM dimensions (5 quantiles for each dimension). Estimate response rates for each RFM cell. Make a decision on how many to mail based on an estimate of ROI of the campaign (say it costs a normalized $1 per mailing and an average profit of $30 per purchase).

3. (10 points)
a) Calculate the Average CLV of a customer. (Note that this is an e-commerce setting).
b) Management believes different types of customers have different CLVs. Come up with a plan (1 page max) on how you would do such a project so the results are useful for the business. (There is no need to implement it, but write a plan on how you would go about doing it, based on the data you have in this case.)

I could have given you cleaned up data---but instead am giving you raw data plus instructions, so you get practice in data wrangling and also the SQL skills you learned.

Notes and Instructions:-

1. Please go through the data description for interpreting the data. It is all the information I have also. For instance Location information is in SCF_Code, which gives the first three digits of the zip code.

2.
.csv format loading into database tables is finicky and you may have trouble even loading the file into a database. Try
(a) saving them as tab-delimited files (native format for postgresql) and then
(b) loading it after first creating tables (use the CREATE scripts available in pgAdmin after rightclicking on the table name). Read Postgresql Help on loading
(c) Check you are loading dates properly

Options: COPY is fast and simple with only a few parameters, but is very finicky; another option is pandas read_csv (say with sqlalchemy). The latter has as many options as a Mercedes luxury car, so you will spend equal time with either one.

Other ways, such as reading line by line, or with R could turn out to be way too slow.

You can take either strategy (for the loading part), but do the queries using SQL as, if you take some care in indexing and writing the queries, significantly faster than all other methods.

If you are using the COPY command, you will face the problem of creating the table. What I do is take the header, copy into Excel and transpose it and then format it into a CREATE command with the fields to create the table. Then use COPY.

If there are 100+ fields as in the Summary table (you only really need the Orders table for RFM, but in case you have to…). One option is to create the table using pandas and import only a line, and then use the COPY command if the data is too big and pandas turns out to be slow.

Now, once you have the table and columns set up, as I mentioned, csv files might be troublesome to load. Convert to tab-delimited first to make your life easier.

Here is a sample loading script
Eg query to load in SQL (the file cleaned2.txt in the query is in tab-delimited format)

COPY
dataset9_cusorders(custid,ordernum,orderdate,linedollars,gift,recipnum)
FROM ‘F:\\classes\\data sets\\Data set 9\\DMEFcustomer orders
cleaned2.txt’ NULL ‘ ‘

in pandas
from sqlalchemy import create_engine
import pandas as pd
file=’F:\\classes\\data sets\\marketing edge datasets\\Data set
9\\DMEFExtractSummaryV01.CSV’
engine =
create_engine(‘postgresql://MyDBServer:PasswordToMyDB@localhost/digital
class’)
df = pd.read_csv(file,nrows-=2 )
df.to_sql(‘dataset9_summary’, engine)

You may still have to work to get it going…

Further Notes and instructions:

1. Please use SQL on Postgresql at least for storage and to do joins or filters across the four tables. Some parts you can probably do easier with pandas (say loading data), but I insist on SQL for the main queries and for practice.

2. Try to use the SQL aggregate and window functions rather than pandas for summarizing data– they are more low-level but more compact. Hint: Look into ntile.
On the other hand, if you are more comfortable with pandas, you are free to use pandas instead.

3. There are a lot of files and info you don’t need. Eg. Various fields DMEF Demo codes reference. Please ignore them

4. Index and link your tables for faster queries and analysis.

5. Missing data is a problem---you have to deal with it.

6. The question of Average Spend is subtle---Average over what, and what time-window? Which location? Resolve these to the best of your judgements.


### Group HW 3
### Digital Marketing Analytics

(NO extensions---please start as soon as possible)
This constitutes 20% of your total course grade

There are two questions in this homework. This is a group homework.

Q1. (5 points) This is based on the case “Launching W Singapore Sentoso Cove: Starwood Hotel’s digital strategy” in Section 10.2.
After reading the case, please answer

1. What goals should Chan and her team accomplish?
2. What feeder markets should Chan choose for the digital campaign and why?
3. If the CTR is 0.05 and the expected yield is 0.002 to 0.006 reservations, how many impressions will Chan need so as to achieve her booking goal? What will be her cost per click?

Q2: (15 points)
Attached is clickstream data from an e-commerce site. The data is anonymized and consists of
a. Clickstream (a tab-delimited file called clickstream-feed-generated.tsv)
The fields are as follows: clickstream_id|timestamp|IP address|url|is_purchased?|is_page_errored?|user_session_id|city|state|country

Sample:
1331799426|2012-03-15 01:17:06|2860005755985467733|4611687631188657821|99.122.210.248|http://www.acme.com/SH55126545/VD55170364|7AAB8415-E803-3C5D-7100-E362D7F67CA7|homestead|fl|usa
b. Products and reviews codes (products.tsv)
c. Registered users that are identifiable (regusers.tsv)

Analyze the data to understand how customers behave and purchase on the site. Answer the following questions raised by the management. Management is interested in only the business side and it is your task to come up with appropriate measures that would make sense to them. Explain what you did and why.

a) Are celebrity reviews significantly more influential than customer reviews? And how do they both fare against video reviews? Is there a way to capture the “bump”, in terms of revenue, of celebrity and video reviews vs. customer reviews?
b) Is there a simple way to capture and show the customer journeys between the various elements (reviews, products)?
