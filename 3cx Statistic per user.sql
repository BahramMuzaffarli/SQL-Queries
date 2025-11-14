--3cx Statistic per user

--Son 1aydaki operatorlarin total danisiq muddeti
SELECT 
    "Internal",
    to_char(
        make_interval(secs => SUM("CallDuration")),
        'HH24:MI:SS'
    ) AS total_duration
FROM 
    "CallLogs"
WHERE 
    "Date" BETWEEN '2025-09-09' AND '2025-10-09'
GROUP BY 
    "Internal"
ORDER BY 
    SUM("CallDuration") DESC;
