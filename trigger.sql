CREATE TRIGGER updcust
  AFTER INSERT
  ON public.salesorderdetail
  FOR EACH ROW
  EXECUTE PROCEDURE public.updatecustomer();

  CREATE OR REPLACE FUNCTION updatecustomer()
    RETURNS trigger AS
  $BODY$
  	BEGIN
  		WITH getCustomer AS (
  			SELECT customerid FROM public.salesorderheader WHERE salesorderid = NEW.salesorderid
  		)
  UPDATE public.customer SET number_of_items = (SELECT number_of_items FROM public.customer WHERE customerid = (SELECT customerid FROM getCustomer)) + (1*NEW WHERE customerid = (SELECT customerid FROM getCustomer);
  RETURN NEW;
  END;

## THIS SHIT WORKS (kind of)

CREATE FUNCTION updateCustomer() RETURNS trigger AS $updCust$
	BEGIN
		WITH getCustomer AS (
			SELECT customerid FROM public.salesorderheader WHERE salesorderid = NEW.salesorderid
		)
UPDATE public.customer SET number_of_items = (SELECT number_of_items FROM public.customer WHERE customerid = (SELECT customerid FROM getCustomer)) + 1 WHERE customerid = (SELECT customerid FROM getCustomer);
RETURN NEW;
END;
$updCust$ LANGUAGE plpgsql;

CREATE TRIGGER updCust AFTER INSERT ON public.salesorderdetail
	FOR EACH ROW EXECUTE PROCEDURE updateCustomer();
