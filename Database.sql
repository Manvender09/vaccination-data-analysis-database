/* Strong Entity Holding Relation With all the tables in the Database*/

CREATE TABLE Vaccination (
    Country_Name                        TEXT    NOT NULL,
    iso_code                            TEXT,
    Date                                TEXT    NOT NULL,
    Total_Vaccinations                  INTEGER,
    People_Vaccinated                   INTEGER,
    People_Fully_Vaccinated             INTEGER,
    Total_Boosters                      INTEGER,
    Daily_Vaccinations_Raw              INTEGER,
    Daily_Vaccinations                  INTEGER,
    Total_Vaccinations_Per_Hundred      INTEGER,
    People_Vaccinated_Per_Hundred       INTEGER,
    People_Fully_Vaccinated_Per_Hundred INTEGER,
    Total_Boosters_Per_Hundred          INTEGER,
    Daily_Vaccinations_Per_Million      INTEGER,
    Daily_People_Vaccinated             INTEGER,
    Daily_People_Vaccinated_Per_Hundred INTEGER,
    PRIMARY KEY (
        Country_Name,
        Date
    )
);

/* Vaccine Table is Related to Vaccination Table by N:1 */

CREATE TABLE Vaccine (
    Country_Name TEXT NOT NULL,
    Date         TEXT NOT NULL,
    Vaccine      TEXT NOT NULL,
    PRIMARY KEY (
        Country_Name,
        Date,
        Vaccine
    ),
    FOREIGN KEY (
        Country_Name,
        Date
    )
    REFERENCES Vaccination (Country_Name,
    Date) 
);

/* Location Table is Related to Vaccination Table by N:1 */

CREATE TABLE Location (
    Serial_Number         INTEGER NOT NULL,
    Country_Name          TEXT    NOT NULL,
    Iso_Code              TEXT,
    Vaccine_Name          TEXT    NOT NULL,
    Last_Observation_Date TEXT,
    Source_Name           TEXT,
    Source_Website        TEXT,
    PRIMARY KEY (
        Serial_Number,
        Country_Name,
        Vaccine_Name
    )
);

/* Vaccine_Manufacture Table is Related to Vaccination Table by N:1 */

CREATE TABLE Vaccine_Manufacture (
    Country_Name       TEXT    NOT NULL,
    Date               TEXT    NOT NULL,
    Vaccine            TEXT    NOT NULL,
    Total_Vaccinations INTEGER,
    PRIMARY KEY (
        Country_Name,
        Date,
        Vaccine
    ),
    FOREIGN KEY (
        Country_Name,
        Date
    )
    REFERENCES Vaccination (Country_Name,
    Date) 
);

/* Age_Group Table is Related to Vaccination Table by N:1 */

CREATE TABLE Age_Group (
    Country_Name                        TEXT    NOT NULL,
    Date                                TEXT    NOT NULL,
    Age_Group                           TEXT    NOT NULL,
    People_Vaccinated_Per_Hundred       INTEGER,
    People_Fully_Vaccinated_Per_Hundred INTEGER,
    People_With_Booster_Per_Hundred     INTEGER,
    PRIMARY KEY (
        Country_Name,
        Date,
        Age_Group
    ),
    FOREIGN KEY (
        Country_Name,
        Date
    )
    REFERENCES Vaccination (Country_Name,
    Date) 
);

/* This is a weak entity which is borrowing the primary key from the Vaccination table */

CREATE TABLE US_State (
    Location                            TEXT    NOT NULL,
    Date                                TEXT    NOT NULL,
    Total_Vaccinations                  INTEGER,
    People_Vaccinated                   INTEGER,
    People_Fully_Vaccinated             INTEGER,
    Total_Boosters                      INTEGER,
    Daily_Vaccinations_Raw              INTEGER,
    Daily_Vaccinations                  INTEGER,
    Total_Vaccinations_Per_Hundred      INTEGER,
    People_Vaccinated_Per_Hundred       INTEGER,
    People_Fully_Vaccinated_Per_Hundred INTEGER,
    Total_Boosters_Per_Hundred          INTEGER,
    Daily_Vaccinations_Per_Million      INTEGER,
    PRIMARY KEY (
        Location,
        Date
    ),
    FOREIGN KEY (
        Date
    )
    REFERENCES Vaccination (Date) 
);

 /* This is an intermediate table between the table Location and Vaccination which have Many to Many Relation betweent Them */
  
CREATE TABLE Given_In (
    Serial_Number INTEGER,
    Location      TEXT    NOT NULL,
    Vaccine_Name  TEXT    NOT NULL,
    PRIMARY KEY (
        Serial_Number,
        Location,
        Vaccine_Name
    ),
    FOREIGN KEY (
        Location
    )
    REFERENCES Vaccination (Country_Name),
    FOREIGN KEY (
        Vaccine_Name
    )
    REFERENCES Location (Vaccine_Name) 
);
