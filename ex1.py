import csv
from io import TextIOWrapper
from zipfile import ZipFile

# Output files and their writers
file_handles = {}
writers = {}

table_names = [
    "region", "country", "specialized", "privatestatus",
    "phd_granting", "enrollment", "University", "acceptence_data"
]

# Open CSV writers for each table
for name in table_names:
    file_handles[name] = open(f"{name}.csv", "w", encoding="UTF8", newline="")
    writers[name] = csv.writer(file_handles[name], delimiter=",", quoting=csv.QUOTE_MINIMAL)

# Track unique entries
region_set = set()
country_set = set()
specialized_set = set()
privatestatus_set = set()
phd_granting_set = set()
university_data = {}  # Stores last occurrence of a university

acceptance_data_set = set()

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

                # Store latest university data (last occurrence in the file)
                university_data[iau_id1] = (
                    iau_id1, orig_name, yrclosed, foundedyr, latitude, longitude,
                    divisions, phd_granting, private01, country, specialized
                )

                # Track unique categorical values
                region_set.add((region,))
                country_set.add((country, countrycode, region))
                specialized_set.add((specialized,))
                privatestatus_set.add((private01,))
                phd_granting_set.add((phd_granting,))

                # Track unique acceptance data
                acceptance_data_set.add((year, iau_id1, students5_estimated))

    # Write unique values to CSV files
    
    print(region_set)
    writers["region"].writerows(region_set)
    writers["country"].writerows(country_set)
    writers["specialized"].writerows(specialized_set)
    writers["privatestatus"].writerows(privatestatus_set)
    writers["phd_granting"].writerows(phd_granting_set)

    # Write University data (ensuring latest values are used)
    for data in university_data.values():
        writers["University"].writerow(data)

    # Write acceptance data
    writers["acceptence_data"].writerows(acceptance_data_set)

    # Close all file handles
    for fh in file_handles.values():
        fh.close()

# Return the table names in creation order
def get_names():
    return table_names

if __name__ == "__main__":
    process_file()
