UPDATE comments as c
SET relevant_child = true
WHERE relevant = true
and (select count(*) from comments where relevant = true and parent_key = c.key) > 0