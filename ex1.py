import csv
from io import TextIOWrapper
from zipfile import ZipFile

# Output files and their writers
file_handles = {}
writers = {}

table_names = [
    "region", "incomegroup", "country",
     "University", "acceptence_data"
]

# Open CSV writers for each table
for name in table_names:
    file_handles[name] = open(f"{name}.csv", "w", encoding="UTF8")
    writers[name] = csv.writer(file_handles[name], delimiter=",", quoting=csv.QUOTE_MINIMAL)

# Track unique entries
country_dict = {}
incomegroup_dict = {}
region_dict = {}
university_dict = {}
acceptance_data_dict = {}

def process_file():
    with ZipFile('enrollment.zip') as zf:
        with zf.open('enrollment.csv', 'r') as infile:
            reader = csv.reader(TextIOWrapper(infile, 'utf-8'))
            

            for row in reader:
                (
                    country, countrycode, region, incomegroup, iau_id1, eng_name,
                    orig_name, foundedyr, yrclosed, private01, latitude, longitude,
                    phd_granting, divisions, specialized, year, students5_estimated
                ) = row

                # Store unique country data
                country_dict[countrycode] = [countrycode, country, incomegroup, region]
                
                # Store unique income group data
                incomegroup_dict[incomegroup] = [incomegroup]
                
                # Store unique region data
                region_dict[region] = [region]
                
                # Store latest university data
                university_dict[iau_id1] = [
                    iau_id1, eng_name, orig_name, foundedyr, yrclosed, private01, 
                    latitude, longitude, phd_granting, divisions, specialized, countrycode
                ]
                
                # Store unique enrollment data
                acceptance_data_dict[(iau_id1, year)] = [iau_id1, year, students5_estimated]


    # Write unique values to CSV files
    writers["region"].writerows(region_dict.values())
    writers["country"].writerows(country_dict.values())
    writers["incomegroup"].writerows(incomegroup_dict.values())
    writers["University"].writerows(university_dict.values())
    writers["acceptence_data"].writerows(acceptance_data_dict.values())
    # Close all file handles
    for fh in file_handles.values():
        fh.close()


# Return the table names in creation order
def get_names():
    return table_names

if __name__ == "__main__":
    process_file()
