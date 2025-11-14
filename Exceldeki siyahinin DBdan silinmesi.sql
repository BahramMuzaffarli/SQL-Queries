--Excelde Gonderilen(musterilerin) CIF kodlara uygun olaraq DB'dan silinmesi


--Step1   Empty table yaradiriq exceli oraya import edirik
--Step2    CIF Kodlarin yuklendiyine emin olmaq ucun
Select*from "SilinecekMusteri"
 
--Step3    Ortaq CIFlerin olmasini yoxlamaq ucun
SELECT * FROM "Customers"
WHERE "CIF" IN (
    SELECT "CIF" FROM "SilinecekMusteri"
);
 
--Step4    Yoxlayandan sonra Silmek ucun
DELETE FROM "Customers"
WHERE "CIF" IN (
    SELECT "CIF" FROM "SilinecekMusteri"
);

--Step5   CIF kodun silindiyine emin olmaq ucun
SELECT COUNT(*) 
FROM "Customers" 
WHERE "CIF" = '00000'; --example CIF
 
