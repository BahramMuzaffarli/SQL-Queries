--3.Customer uzre query'ler


--Customer DialResultlari manual deyismek numunesi
--Icrada qalan statuslari queue uzre tapmaq
Select * From "Customers"
where "Status" = 3 and
 "Queue" = 628
 --Statuslarin icradan NotDialede cevirmek
 UPDATE "Customers"
SET "Status" = 0
WHERE "Status" = 3
  AND "Queue" = 628;

----------------------------------------------------------
--MUSTERI nomresine gore ad soyad tapmaq
SELECT 
    c."FirstName",
    c."CIF",
    cl.*
FROM "CallLogs" cl
JOIN "Customers" c
    ON cl."Cif" = c."CIF"
WHERE cl."External" = '514234858'
ORDER BY cl."Date" DESC;
