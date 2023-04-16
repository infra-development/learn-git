select 'Application & Services' as traffic_type, 
    sum(upbytes+downbytes), 
    count(distinct subscriberid) FROM mrx.monthly_points 
where (bintag=1646092800) and ods3 not like '[%' and ods1 not in ('Communication') and ods2 not in ('Application Download') AND gds not in ('Video') group by traffic_type) 
union (select 'Videos' as traffic_type, sum(upbytes+downbytes), count(distinct subscriberid) FROM mrx.monthly_points where (bintag=1646092800) and ods3 not like '[%' AND gds in ('Video') group by traffic_type) 
union (select 'Communication' as traffic_type, sum(upbytes+downbytes), count(distinct subscriberid) FROM mrx.monthly_points where (bintag=1646092800) and ods3 not like '[%' AND ods1 in ('Communication') and gds not in ('Video') group by traffic_type) 
union (select 'Application Download' as traffic_type, sum(upbytes+downbytes), count(distinct subscriberid) FROM mrx.monthly_points where (bintag=1646092800) and ods3 not like '[%' AND ods2 in ('Application Download') and gds not in ('Video') group by traffic_type) 
union  (select 'Uncategorised' as traffic_type, sum(upbytes+downbytes), count(distinct subscriberid) FROM mrx.monthly_points where (bintag=1646092800) and gds not in ('Video') group by traffic_type) 
union (select 'Total (including long tail)' as traffic_type, sum(upbytes+downbytes), 
count(distinct subscriberid) FROM  mrx.monthly_points where (bintag=1646092800) group by traffic_type)