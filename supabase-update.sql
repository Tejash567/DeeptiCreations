-- Already ran the older supabase-setup.sql? Run only this file once to add the new features.
alter table products add column if not exists images text[] default '{}';
alter table products add column if not exists cutout_url text;
alter table reels add column if not exists product_id text;
create table if not exists settings(key text primary key, value text not null);
alter table settings enable row level security;
drop policy if exists "read settings" on settings;
drop policy if exists "admin settings" on settings;
create policy "read settings" on settings for select using (true);
create policy "admin settings" on settings for all to authenticated using (true) with check (true);
