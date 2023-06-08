# load RODBC library with odbcConnectAccess2007 function
library(RODBC) 


#========= CONNECT DATABASE ===========
# 1) set .accdb database file path
path_DB <- "C:/Users/andre/Documents/Database1.accdb"

# 2) connect database to R session 
conn <- odbcConnectAccess2007(path_DB)

# 3) check table names
sqlTables(conn)$TABLE_NAME

# 4) set table name to load
table <- "Tabella1"

# 5) import the table in R data.frame
df<- sqlFetch(conn, table, rows_at_time=1000)


#========= MODIFY DATABASE ===========
# 6) OPTIONAL: append a new dataframe to an existing DB
# ...create a new dataframe...
names(df)
df2 <- data.frame(ID=5,
                 nome="wsx",
                 location="BO",
                 age=30,
                 sex="F")
# append in an existing table in the db, using sqlSave function and append = TRUE
sqlSave(channel = conn, 
        dat = df2, 
        tablename = "Tabella1", # select the existing table
        append = T, 
        rownames = F)


# 7) OPTIONAL: Create a new table in an existing DB
# ...create a new dataframe...
df3 <- iris
# add a new table in the db using sqlSave function
sqlSave(channel = conn, 
        dat = df3, 
        tablename = "Iris_table", # write a new table name
        rownames = F)


