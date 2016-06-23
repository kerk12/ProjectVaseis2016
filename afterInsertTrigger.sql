INSERT INTO salesorderdetail (SalesOrderID,SalesOrderDetailID,OrderQty,ProductID,UnitPrice,UnitPriceDiscount,LineTotal) VALUES (43684,121325,5,763,419.4589,0.00,419.458900)

SELECT customerid, number_of_items FROM customer WHERE customerid = (SELECT customerid FROM salesorderheader WHERE salesorderid = 43684)
