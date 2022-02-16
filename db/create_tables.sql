drop table if exists company;
create table company (
	id int primary key, 
	name text, 
	country text
);

drop table if exists review;
create table review (
	id int primary key, 
	company_id int not null references company (id), 
	bar_name text not null, 
	year int not null, 
	cocoa_pct real not null check (cocoa_pct between 0 and 1), 
	rating real not null check (rating between 1 and 5),
	bean_type text,
	bean_origin text
);