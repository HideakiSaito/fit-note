select
  max(id) 
from
  pages 
where
  user_id = 1
and
  wight is not null
