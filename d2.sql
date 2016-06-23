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
