from tvm_py_lib.sql_work import run_sql_and_fetch_
from tvm_py_lib.file_work import write_to_file


import sys
import MySQLdb

def get_db_table_names( host , cfg_file , db ):
        cmd = "show tables"
        ret = run_sql_and_fetch_( cmd , host , cfg_file , db  )
        res = []
        names = ""
        for data in ret :
                res.append( data[ 0 ] )
                names += data[ 0 ] + " "
        return res , names

#may for later use of db
def get_db_names( host , cfg_file ):
        cmd = "show databases"
        ret = run_sql_and_fetch_( cmd , host , cfg_file , db  = "" )
        res = []
        names = ""
        for data in ret :
                res.append( data[ 0 ] )
                names += data[ 0 ] + " "
        return res , names

def get_table_data( host , cfg_file , db , table_name ):
        cmd = "describe %s " % table_name
        ret = run_sql_and_fetch_( cmd , host , cfg_file , db )
        fields = ""
        for data in ret :
                fields += data[ 0 ] +  " "
        return fields

host = sys.argv[ 1 ]
db =   sys.argv[ 2 ]
cfg_file =  sys.argv[ 3 ]

table_name_list , table_names =  get_db_table_names( host , cfg_file , db )
all_keys =  table_names
for table_name in table_name_list :
        tmp = get_table_data( host , cfg_file , db , table_name)
        all_keys +=  tmp
write_to_file( all_keys , ".key_words" )
