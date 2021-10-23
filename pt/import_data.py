import pandas 
from neo4j import GraphDatabase
from pandas.io.common import is_fsspec_url

class Neo4jConnection:
    
    def __init__(self, uri, user, pwd):
        self.__uri = uri
        self.__user = user
        self.__pwd = pwd
        self.__driver = None
        try:
            self.__driver = GraphDatabase.driver(self.__uri, auth=(self.__user, self.__pwd))
        except Exception as e:
            print("Failed to create the driver:", e)
        
    def close(self):
        if self.__driver is not None:
            self.__driver.close()
        
    def query(self, query, parameters=None, db=None):
        assert self.__driver is not None, "Driver not initialized!"
        session = None
        response = None
        try: 
            session = self.__driver.session(database=db) if db is not None else self.__driver.session() 
            response = list(session.run(query, parameters))
        except Exception as e:
            print("Query failed:", e)
        finally: 
            if session is not None:
                session.close()
        return response



df_aggr = pandas.read_excel('dat.xlsx', sheet_name=0, header=None, index_col=None)
df_ware = pandas.read_excel('dat.xlsx', sheet_name=1, header=None, index_col=None)

warehouses = []
agregats   = []

isFirst = True

for i in range(0, df_ware.shape[0]):
    if isFirst:
        isFirst = False
        continue

    warehouse = {
    'id'          : df_ware[0][i],
    'name'        : df_ware[1][i],
    'plan_date'   : df_ware[2][i],
    'res_level'   : str(df_ware[3][i]),
    'is_at_max'   : str(df_ware[4][i]),
    'max_level'   : str(df_ware[5][i]),
    }

    warehouse['plan_date'] = str(warehouse['plan_date'].strftime("%m/%d/%Y"))
    print(warehouse['plan_date'])
    if warehouse['plan_date'] != '11/16/2021':
        found=True
        continue

    warehouses.append(warehouse)

isFirst = True
for i in range(0, df_aggr.shape[0]):
    if isFirst:
        isFirst = False
        continue

    agregat = {
    'name':    df_aggr[0][i],
    'is_constrained_by_outpt': df_aggr[1][i],
    'id':      df_aggr[2][i],
    'input':   str(df_aggr[3][i]).split(';'),
    'outputs': str(df_aggr[4][i]).split(';'),
    }
    agregats.append(agregat)

conn = Neo4jConnection(uri="bolt://localhost:7687", user='neo4j', pwd='neo4j')

for wrh in warehouses:
    conn.query('CREATE (prod:Aggregat {name: "'+wrh['name']+'", plan_date: "'+wrh['plan_date']+'", fid: "'+wrh['id']+'", res_level: "'+wrh['res_level']+'", is_at_max:"'+wrh['is_at_max']+'", max_level: "'+wrh['max_level']+'"});')

for agr in agregats:

    new_input = []
    for item in agr['input']:
        tmp = f'"{item}"'
        new_input.append(tmp)
    agr['input'] = ','.join(new_input)

    new_outp = []
    for item in agr['outputs']:
        tmp = f'"{item}"'
        new_outp.append(tmp)
    agr['outputs'] = ','.join(new_outp)



    query = 'CREATE (:Stanok {name:"'+agr['name']+'",' 
    query += 'is_constrained_by_outpt: "'+str(agr['is_constrained_by_outpt'])+'",'
    query += 'fid: "'+str(agr['id'])+'",'
    query += 'inputs: ['+agr['input']+'],'
    query += 'outputs: ['+agr['outputs']+']});'
    conn.query(query)

conn.query("""MATCH (a:Stanok), (b:Aggregat) WHERE any(input in a.inputs WHERE input = b.fid) 
CREATE (a)<-[:INPUTS]-(b)
RETURN a,b""")

conn.query("""MATCH (a:Stanok), (b:Aggregat) WHERE any(outputs in a.outputs WHERE outputs = b.fid) 
CREATE (a)-[:OUTPUTS]->(b)
RETURN a,b """)

conn.close()



