SELECT id as device_ID,
       systolic systolic_pressure,
       diastolic as diastolic_pressure
FROM "sundb"."sunsbhujbal123" bp
where ( bp.systolic >= 200  ) or (bp.diastolic >= 120)