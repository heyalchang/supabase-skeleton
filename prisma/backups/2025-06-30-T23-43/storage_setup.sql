-- Storage bucket setup
-- Review storage_buckets.txt and recreate your buckets

-- Example bucket creation (update with your actual buckets):
-- INSERT INTO storage.buckets (id, name, public)
-- VALUES ('avatars', 'avatars', true);

-- Example RLS policy:
-- CREATE POLICY "Avatar images are publicly accessible"
-- ON storage.objects FOR SELECT
-- USING (bucket_id = 'avatars');
