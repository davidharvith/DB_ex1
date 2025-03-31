create table region(
	regionname varchar primary key
);

create table country(
	 country varchar primary key,
	 countrycode varchar not null,
	 region varchar not null references region(regionname)
);

create table specialized(
	specialized BOOLEAN primary key
);

create table privatestatus(
	private01 BOOLEAN primary key
);


create table phd_granting(
	phd_granting BOOLEAN primary key
);


create table enrollment(
	country varchar, 
	countrycode varchar, 
	region varchar, 
	incomegroup varchar, 
	iau_id1 varchar, 
	eng_name varchar, 
	orig_name varchar, 
	foundedyr varchar, 
	yrclosed varchar, 
	private01 varchar, 
	latitude varchar, 
	longitude varchar, 
	phd_granting varchar, 
	divisions varchar, 
	specialized varchar, 
	year varchar, 
	students5_estimated varchar
);

create table University(
	iau_id1 varchar primary key,
	orig_name varchar not null,
	yrclosed INT,
	foundedyr INT not null,
	latitude FLOAT,
	longitude FLOAT ,
	divisions INT,
	phd_granting BOOLEAN not null references phd_granting(phd_granting),
	private01 BOOLEAN not null references privatestatus(private01),
	country varchar not null references country(country),
	specialized BOOLEAN not null references specialized(specialized)
);





create table acceptence_data(
	year INT,
	iau_id1 varchar references University(iau_id1),
	students5_estimated INT,
	primary key(year, iau_id1)	
);
