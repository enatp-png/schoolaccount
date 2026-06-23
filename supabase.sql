
-- Supabase SQL สำหรับระบบบัญชีโรงเรียน
-- รันทั้งหมดใน Supabase > SQL Editor

create extension if not exists pgcrypto;

create table if not exists public.registers (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.sub_items (
  id uuid primary key default gen_random_uuid(),
  register_name text not null references public.registers(name) on update cascade on delete cascade,
  name text not null,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  unique(register_name, name)
);

create table if not exists public.records (
  id text primary key,
  register_type text not null,
  sub_category text not null,
  date date not null,
  document_number text,
  description text not null,
  amount_received numeric(14,2) not null default 0,
  amount_paid numeric(14,2) not null default 0,
  balance numeric(14,2) not null default 0,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.settings (
  key text primary key,
  value text,
  updated_at timestamptz not null default now()
);

alter table public.registers enable row level security;
alter table public.sub_items enable row level security;
alter table public.records enable row level security;
alter table public.settings enable row level security;

-- หมายเหตุ: ชุดนี้เปิดให้ anon ใช้งานได้ เพราะ GitHub Pages เป็นเว็บ static ไม่มีระบบล็อกอิน
-- ถ้าข้อมูลจริงมีความลับ ควรเพิ่ม Supabase Auth แล้วปรับ policy ใหม่

drop policy if exists "anon select registers" on public.registers;
drop policy if exists "anon insert registers" on public.registers;
drop policy if exists "anon update registers" on public.registers;
drop policy if exists "anon delete registers" on public.registers;
create policy "anon select registers" on public.registers for select to anon using (true);
create policy "anon insert registers" on public.registers for insert to anon with check (true);
create policy "anon update registers" on public.registers for update to anon using (true) with check (true);
create policy "anon delete registers" on public.registers for delete to anon using (true);

drop policy if exists "anon select sub_items" on public.sub_items;
drop policy if exists "anon insert sub_items" on public.sub_items;
drop policy if exists "anon update sub_items" on public.sub_items;
drop policy if exists "anon delete sub_items" on public.sub_items;
create policy "anon select sub_items" on public.sub_items for select to anon using (true);
create policy "anon insert sub_items" on public.sub_items for insert to anon with check (true);
create policy "anon update sub_items" on public.sub_items for update to anon using (true) with check (true);
create policy "anon delete sub_items" on public.sub_items for delete to anon using (true);

drop policy if exists "anon select records" on public.records;
drop policy if exists "anon insert records" on public.records;
drop policy if exists "anon update records" on public.records;
drop policy if exists "anon delete records" on public.records;
create policy "anon select records" on public.records for select to anon using (true);
create policy "anon insert records" on public.records for insert to anon with check (true);
create policy "anon update records" on public.records for update to anon using (true) with check (true);
create policy "anon delete records" on public.records for delete to anon using (true);

drop policy if exists "anon select settings" on public.settings;
drop policy if exists "anon insert settings" on public.settings;
drop policy if exists "anon update settings" on public.settings;
drop policy if exists "anon delete settings" on public.settings;
create policy "anon select settings" on public.settings for select to anon using (true);
create policy "anon insert settings" on public.settings for insert to anon with check (true);
create policy "anon update settings" on public.settings for update to anon using (true) with check (true);
create policy "anon delete settings" on public.settings for delete to anon using (true);

grant usage on schema public to anon;
grant select, insert, update, delete on public.registers to anon;
grant select, insert, update, delete on public.sub_items to anon;
grant select, insert, update, delete on public.records to anon;
grant select, insert, update, delete on public.settings to anon;

insert into public.settings(key, value) values
('system_title', 'ระบบบัญชีโรงเรียน'),
('school_name', 'โรงเรียนตัวอย่าง')
on conflict (key) do update set value = excluded.value, updated_at = now();
