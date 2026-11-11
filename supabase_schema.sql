-- Run in your Supabase SQL editor. Each signed-in user sees only their own records.
create table if not exists public.equipment (
  id text primary key,
  owner uuid not null default auth.uid() references auth.users(id),
  payload jsonb not null,
  updated_at timestamptz not null default now()
);
create table if not exists public.attachment_index (
  id text primary key,
  owner uuid not null default auth.uid() references auth.users(id),
  equipment_id text not null,
  name text not null,
  type text,
  updated_at timestamptz not null default now()
);
alter table public.equipment enable row level security;
alter table public.attachment_index enable row level security;
create policy "equipment owner" on public.equipment for all to authenticated using (owner=auth.uid()) with check (owner=auth.uid());
create policy "attachment index owner" on public.attachment_index for all to authenticated using (owner=auth.uid()) with check (owner=auth.uid());
insert into storage.buckets(id,name,public,file_size_limit) values('attachments','attachments',false,12582912) on conflict(id) do nothing;
-- Object path: <file uuid>/<filename>. Storage ownership enforced by object owner.
create policy "attachments read own" on storage.objects for select to authenticated using (bucket_id='attachments' and owner_id=auth.uid()::text);
create policy "attachments insert own" on storage.objects for insert to authenticated with check (bucket_id='attachments' and owner_id=auth.uid()::text);
create policy "attachments update own" on storage.objects for update to authenticated using (bucket_id='attachments' and owner_id=auth.uid()::text) with check (bucket_id='attachments' and owner_id=auth.uid()::text);
