-- Precio especial opcional por producto. No modifica precios actuales.
alter table public.productos add column if not exists sale_price double precision;
do $$
begin
  if not exists (
    select 1 from pg_constraint
    where conname = 'productos_sale_price_valid'
      and conrelid = 'public.productos'::regclass
  ) then
    alter table public.productos
      add constraint productos_sale_price_valid
      check (sale_price is null or (sale_price >= 0 and sale_price < price)) not valid;
  end if;
end $$;

