--Kampaniya ve statuslar uzre statistika k.Bank


--Secilmis tarixde Kampaniyalar ve kampaniyalardaki musterilerin sayi
SELECT 
    c."Name" AS campaign_name,
    COUNT(cu."CIF") AS customer_count
FROM 
    "Campaigns" c
LEFT JOIN 
    "Customers" cu ON cu."Queue" = c."Id"
WHERE 
    c."Name" LIKE 'SOFT1%' AND
    c."StartDt" BETWEEN '2025-07-19' AND '2025-08-19'
GROUP BY 
    c."Name"
ORDER BY 
    c."Name";

----------------------------------------------------------------------------------


--Statusu paid ve partial paid olan musterilerinin ceminin siyahisi
SELECT 
  CASE 
    WHEN "Status" = 6 THEN 'Paid'
    WHEN "Status" = 7 THEN 'PartialPaid'
    ELSE 'Other'
  END AS "StatusLabel",
  COUNT(*) AS customer_count
FROM "Customers"
WHERE "Status" IN (6, 7)
  AND "CreatedDate" BETWEEN '2025-06-01' AND '2025-07-01'
GROUP BY "StatusLabel";

----------------------------------------------------------------------------------
--Xususi kampaniya uzre olan queryler(PreCollection Example)
--PreCollection kampaniyalarinin siyahisi
SELECT *
FROM "Campaigns"
WHERE 
  ("Name" LIKE '%RE%' OR "Name" LIKE '%re%')
  AND "CreateTime" BETWEEN '2025-07-19' AND '2025-08-20'
    order by "CreateTime";
	
--Xususi kampaniyalar ve her kampaniyadaki musteri sayi(PreCollection)
SELECT 
    c."Name" AS "CampaignName",
    COUNT(cu."CIF") AS "TotalCustomers"
FROM "Campaigns" c
LEFT JOIN "Customers" cu
    ON cu."Queue" = c."Id"
WHERE 
    c."Name" LIKE '%RE%' OR c."Name" LIKE '%re%'
    AND c."CreateTime" BETWEEN '2025-07-19' AND '2025-08-20'
GROUP BY c."Name"

