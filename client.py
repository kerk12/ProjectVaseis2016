import psycopg2

try:
    conn = psycopg2.connect("dbname='mydb' user='postgres' host='localhost' password='everduzk'")
except:
    print "I am unable to connect to the database"

cur = conn.cursor()

#Query 1:
cur.execute("""
WITH SumOfOrders AS (
	SELECT customerid, SUM(totaldue) AS SumTotal FROM public.salesorderheader
	GROUP BY customerid
)

SELECT customerid, SumTotal FROM SumOfOrders WHERE SumTotal = (
	SELECT MAX(SumTotal) FROM SumOfOrders
)
GROUP BY customerid, sumtotal;
 """)
data = cur.fetchall()
print "Query #1 Results:"
print "CustomerID | TotalDue"
for row in data:
    print row[0], " | ", row[1]

#Query 2:
cur.execute("""
WITH CategCount AS (
	SELECT salesorderid, COUNT(DISTINCT productcategoryid) FoundTimes
	FROM salesorderdetail JOIN public.product
	USING(productid)
	GROUP BY 1
)

SELECT customerid, COUNT(FoundTimes) AS OrderCount FROM
public.salesorderheader JOIN CategCount USING (salesorderid)
GROUP BY 1
HAVING bool_or(FoundTimes >= 3)
""")
print "\n==========================\n"
raw_input("Press Enter to continue with the second query...")
data = cur.fetchall()
print "Query #2 Results:"
print "CustomerID | OrderCount"
for row in data:
    print row[0], " | ", row[1]
