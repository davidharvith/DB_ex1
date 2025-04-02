create table region(
	regionname varchar(60) primary key
);

create table incomegroup(
	incomegroup varchar(60) primary key
);

create table country(
	 countrycode varchar(3) primary key,
	country varchar(60) unique not null,
	 incomegroup varchar,
	 region varchar,
	 foreign key (incomegroup) references incomegroup(incomegroup),
	 foreign key (region) references region(regionname)
);


create table University(
	iau_id1 varchar(60) primary key,
	eng_name varchar not null,
	orig_name varchar not null,
	foundedyr integer not null,
	yrclosed integer,
	private01 boolean not null,
	latitude FLOAT,
	longitude FLOAT,
	phd_granting boolean not null,
	divisions integer,
	specialized boolean not null,
	countrycode varchar(3) not null,
	foreign key (countrycode) references country(countrycode)
);


create table acceptence_data(
	iau_id1 varchar references University(iau_id1),
	year integer,
	students5_estimated integer,
	primary key(year, iau_id1)	
);
