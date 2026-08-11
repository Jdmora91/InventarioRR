-- RR Joyería: catálogo público y administración autenticada.
create table if not exists public.config (
  key text primary key,
  value text not null default '',
  updated_at timestamptz not null default now()
);

alter table public.productos add column if not exists description text;
alter table public.productos add column if not exists sold boolean not null default false;
alter table public.productos add column if not exists images jsonb not null default '[]'::jsonb;
alter table public.productos enable row level security;
alter table public.config enable row level security;

drop policy if exists "Admin puede todo" on public.productos;
drop policy if exists "Lectura pública" on public.productos;
drop policy if exists "catalog_read" on public.productos;
drop policy if exists "catalog_admin_insert" on public.productos;
drop policy if exists "catalog_admin_update" on public.productos;
drop policy if exists "catalog_admin_delete" on public.productos;
create policy "catalog_read" on public.productos for select to anon, authenticated using (true);
create policy "catalog_admin_insert" on public.productos for insert to authenticated with check (true);
create policy "catalog_admin_update" on public.productos for update to authenticated using (true) with check (true);
create policy "catalog_admin_delete" on public.productos for delete to authenticated using (true);

drop policy if exists "config_read" on public.config;
drop policy if exists "config_admin_insert" on public.config;
drop policy if exists "config_admin_update" on public.config;
drop policy if exists "config_admin_delete" on public.config;
create policy "config_read" on public.config for select to anon, authenticated using (true);
create policy "config_admin_insert" on public.config for insert to authenticated with check (true);
create policy "config_admin_update" on public.config for update to authenticated using (true) with check (true);
create policy "config_admin_delete" on public.config for delete to authenticated using (true);

drop policy if exists "Allow upload fotos-joyas" on storage.objects;
drop policy if exists "Allow public read fotos-joyas" on storage.objects;
drop policy if exists "Public storage access" on storage.objects;
drop policy if exists "Eliminar fotos" on storage.objects;
drop policy if exists "Subir fotos" on storage.objects;
drop policy if exists "Acceso público a fotos" on storage.objects;
drop policy if exists "jewelry_public_read" on storage.objects;
drop policy if exists "jewelry_admin_insert" on storage.objects;
drop policy if exists "jewelry_admin_update" on storage.objects;
drop policy if exists "jewelry_admin_delete" on storage.objects;
create policy "jewelry_public_read" on storage.objects for select to anon, authenticated using (bucket_id='fotos-joyas');
create policy "jewelry_admin_insert" on storage.objects for insert to authenticated with check (bucket_id='fotos-joyas');
create policy "jewelry_admin_update" on storage.objects for update to authenticated using (bucket_id='fotos-joyas') with check (bucket_id='fotos-joyas');
create policy "jewelry_admin_delete" on storage.objects for delete to authenticated using (bucket_id='fotos-joyas');

insert into public.config(key,value) values
 ('promo_config','{"active":false,"title":"Selección especial","desc":"","start":"","end":""}'),
 ('promo_products','[]')
on conflict (key) do nothing;
