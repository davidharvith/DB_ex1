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
	 phd_granting VARBINARY not null,
	 private01 VARBINARY not null,
	 country varchar not null,
	 specialized VARBINARY not null
	 foreign key(phd_granting) references phd_granting(phd_granting),
	 foreign key (specialized) references specialized(specialized),
	 foreign key (private01) references privatestatus(private01),
	 foreign key (country) references country(country)
);

create table specialized(
	specialized VARBINARY primary key
);

create table privatestatus(
	private01 VARBINARY primary key
);


create table phd_granting(
	phd_granting VARBINARY
);

create table country(
	 country varchar primary key,
	 countrycode varchar not null,
	 region varchar not null,
	 foreign key (region) references region(regionname)
);

create table region(
	regionname varchar primary key
);

create table acceptence_data(
	year INT,
	iau_id1 varchar,
	students5_estimated INT,
	primary key(year, iau_id1)
	foreign key (iau_id1) references University(iau_id1)
);
