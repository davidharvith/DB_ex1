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
	phd_granting BOOLEAN not null,
	private01 BOOLEAN not null,
	country varchar not null,
	specialized BOOLEAN not null,
	foreign key (phd_granting) references phd_granting(phd_granting),
	foreign key (private01) references privatestatus(private01),
	foreign key (country) references country(country),
	foreign key (specialized) references specialized(specialized)
);





create table acceptence_data(
	year INT,
	iau_id1 varchar references University(iau_id1),
	students5_estimated INT,
	primary key(year, iau_id1)	
);
