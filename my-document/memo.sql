
select
  f.id,
  f.name,
  d.name
from
  foods f 
left join 
  diets d
on 
  f.diet_id = d.id
where
  f.vegetable  >  0

