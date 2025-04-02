create table region(
	regionname varchar(60) primary key
);

create table incomegroup(
	incomegroup varchar(60) primary key
)

create table country(
	 countrycode varchar(3) primary key,
	country varchar(60) unique not null,
	 region varchar,
	 incomegroup varchar,
	 foreign key (incomegroup) references incomegroup(incomegroup),
	 foreign key (region) references region(regionname)
);


create table University(
	iau_id1 varchar(60) primary key,
	orig_name varchar(320) not null,
	yrclosed integer,
	foundedyr integer not null,
	latitude FLOAT,
	longitude FLOAT ,
	divisions integer,
	phd_granting BOOLEAN not null,
	private01 BOOLEAN not null,
	country varchar not null,
	specialized BOOLEAN not null,
	foreign key (country) references country(country)
);


create table acceptence_data(
	year integer,
	iau_id1 varchar references University(iau_id1),
	students5_estimated integer,
	primary key(year, iau_id1)	
);
