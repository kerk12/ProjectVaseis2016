WITH SumOfOrders AS (
	SELECT customerid, SUM(totaldue) AS SumTotal FROM public.salesorderheader
	GROUP BY customerid
)

SELECT customerid, SumTotal FROM SumOfOrders WHERE SumTotal = (
	SELECT MAX(SumTotal) FROM SumOfOrders
)
GROUP BY customerid, sumtotal;
