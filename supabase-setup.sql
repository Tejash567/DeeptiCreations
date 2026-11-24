-- Run this once in Supabase > SQL Editor.
-- Then: Authentication > Users > "Add user" (this is the admin login; disable public sign-ups in Auth settings).

create table products(
  id uuid primary key default gen_random_uuid(),
  product_id text unique not null,
  name text not null,
  price numeric not null,
  category text,
  sizes text,
  description text,
  image_url text not null,
  images text[] default '{}',
  cutout_url text,
  is_new boolean default false,
  in_stock boolean default true,
  created_at timestamptz default now());

create table reels(id uuid primary key default gen_random_uuid(), url text not null, product_id text, created_at timestamptz default now());

create table reviews(
  id uuid primary key default gen_random_uuid(),
  name text not null, rating int not null check (rating between 1 and 5),
  text text not null, approved boolean default false, created_at timestamptz default now());

create table orders(
  id uuid primary key default gen_random_uuid(),
  name text not null, phone text not null, address text not null,
  items jsonb not null, total numeric not null,
  status text default 'new', created_at timestamptz default now());

alter table products enable row level security;
alter table reels enable row level security;
alter table reviews enable row level security;
alter table orders enable row level security;

-- public can read products, reels, approved reviews
create policy "read products" on products for select using (true);
create policy "read reels" on reels for select using (true);
create policy "read approved reviews" on reviews for select using (approved = true);
-- public can submit a review (pending) and place an order
create policy "submit review" on reviews for insert to anon with check (approved = false);
create policy "place order" on orders for insert to anon with check (true);
-- logged-in admin can do everything
create policy "admin products" on products for all to authenticated using (true) with check (true);
create policy "admin reels" on reels for all to authenticated using (true) with check (true);
create policy "admin reviews" on reviews for all to authenticated using (true) with check (true);
create policy "admin orders" on orders for all to authenticated using (true) with check (true);

-- image storage
insert into storage.buckets (id, name, public) values ('products','products',true);
create policy "public read images" on storage.objects for select using (bucket_id = 'products');
create policy "admin upload images" on storage.objects for insert to authenticated with check (bucket_id = 'products');

-- website settings (background choice)

-- table permissions (needed on newer Supabase projects, otherwise: "permission denied for table")
grant usage on schema public to anon, authenticated;
grant select on public.products, public.reels, public.reviews to anon;
grant insert on public.orders, public.reviews to anon;
grant select, insert, update, delete on public.products, public.reels, public.reviews, public.orders to authenticated;
