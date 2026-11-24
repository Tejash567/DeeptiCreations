-- Run this ONCE in Supabase > SQL Editor if the admin panel says "permission denied for table products".
-- It gives the website's roles permission to use the tables. (Row rules from supabase-setup.sql still apply.)
alter table products add column if not exists images text[] default '{}';
alter table products add column if not exists cutout_url text;
alter table products add column if not exists is_new boolean default false;
alter table reels add column if not exists product_id text;

-- table permissions (needed on newer Supabase projects, otherwise: "permission denied for table")
grant usage on schema public to anon, authenticated;
grant select on public.products, public.reels, public.reviews to anon;
grant insert on public.orders, public.reviews to anon;
grant select, insert, update, delete on public.products, public.reels, public.reviews, public.orders to authenticated;

-- make sure the row rules exist too
alter table products enable row level security; alter table reels enable row level security;
alter table reviews enable row level security; alter table orders enable row level security;
drop policy if exists "read products" on products; create policy "read products" on products for select using (true);
drop policy if exists "read reels" on reels; create policy "read reels" on reels for select using (true);
drop policy if exists "read approved reviews" on reviews; create policy "read approved reviews" on reviews for select using (approved = true);
drop policy if exists "submit review" on reviews; create policy "submit review" on reviews for insert to anon with check (approved = false);
drop policy if exists "place order" on orders; create policy "place order" on orders for insert to anon with check (true);
drop policy if exists "admin products" on products; create policy "admin products" on products for all to authenticated using (true) with check (true);
drop policy if exists "admin reels" on reels; create policy "admin reels" on reels for all to authenticated using (true) with check (true);
drop policy if exists "admin reviews" on reviews; create policy "admin reviews" on reviews for all to authenticated using (true) with check (true);
drop policy if exists "admin orders" on orders; create policy "admin orders" on orders for all to authenticated using (true) with check (true);
-- photo storage
insert into storage.buckets (id, name, public) values ('products','products',true) on conflict (id) do update set public = true;
drop policy if exists "public read images" on storage.objects; create policy "public read images" on storage.objects for select using (bucket_id = 'products');
drop policy if exists "admin upload images" on storage.objects; create policy "admin upload images" on storage.objects for insert to authenticated with check (bucket_id = 'products');
drop policy if exists "admin manage images" on storage.objects; create policy "admin manage images" on storage.objects for all to authenticated using (bucket_id = 'products') with check (bucket_id = 'products');
