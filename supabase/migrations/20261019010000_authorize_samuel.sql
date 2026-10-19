insert into public.admin_users (email)
values ('samuelmancebo@gmail.com')
on conflict (email) do nothing;
