-- Run this script using the button above
-- or with the command psql --dbname=youtube -f example.sql
SELECT v.title, v.view_count 
FROM videos as v
INNER JOIN channels as c ON c.id = v.channel_id
  WHERE c.title = 'Firebase'
  AND view_count > 10000
LIMIT 100;