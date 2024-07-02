-- Start a transaction
BEGIN;

CREATE TABLE channels (
  id TEXT PRIMARY KEY,
  title TEXT
);

CREATE TABLE videos (
  id TEXT PRIMARY KEY,
  channel_id TEXT REFERENCES channels(id),
  title TEXT,
  published_at TIMESTAMP,
  like_count INTEGER,
  view_count INTEGER,
  thumbnail_highres VARCHAR(255);
);

-- Insert YouTube Channels
INSERT INTO channels (id, title) VALUES
  ('UCP4bf6IHJJQehibu6ai__cg', 'Firebase'),
  ('UCnUYZLuoy1rq1aVMwx4aTzw', 'Chrome'),
  ('UCwXdFgeE9KYzlDdR7TG9cMw', 'Flutter'),
  ('UCVHFbqXqoYvEWM1Ddxl0QDg', 'Android'),
  ('UC_x5XG1OV2P6uZZ5FSM9Ttw', 'Google for Developers'),
  ('UC0rqucBdTuFTjJiefW5t-IQ', 'Tensorflow'),
  ('UCbn1OgGei-DV7aSRo_HaAiw', 'Angular'),
  ('UCO3LEtymiLrgvpb59cNsb8A', 'Go');

-- Read the JSON file into a variable (assuming your JSON file is 'videos.json')
\set videos_json `cat videos.json`

-- Iterate over each video object in the JSON array
INSERT INTO videos (id, channel_id, title, published_at, view_count, like_count)
SELECT
  video->>'resourceId'->>'videoId' AS id,
  video->>'channelId' AS channel_id,
  video->>'title' AS title,
  (video->>'publishedAt')::TIMESTAMP AS published_at,
  (video->>'statistics'->>'viewCount')::INTEGER AS view_count,
  (video->>'statistics'->>'likeCount')::INTEGER AS like_count,
  video->'thumbnails'->'maxres'->>'url' AS thumbnail_highres
FROM jsonb_array_elements(:'videos_json');

-- Commit the transaction if successful
COMMIT;

-- Rollback if an error occurs
EXCEPTION WHEN OTHERS THEN
ROLLBACK;
