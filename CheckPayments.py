import requests
import json
import psycopg2
import os
from steem import Steem
'''
r = requests.get('https://webapi.steemdata.com/Operations?where={"type": "transfer", "to": "steemvisit"}')
json = json.loads(r.text)
for item in json["_items"]:
	amount = float(str(item["amount"]["amount"]))
	memo = item["memo"]
'''
s = Steem()
for i in s.get_account_history('steemvisit',index_from=-1,limit=1):
	memo = i[1]['op'][1]['memo']
	amount = float(i[1]['op'][1]['amount'][:-3])
	conn = psycopg2.connect((os.environ['DATABASE_URL']),sslmode='require')
	#conn = psycopg2.connect("dbname='my_database_development' user='nathan' host='127.0.0.1' password=''")
	cur = conn.cursor()
	cur.execute("""UPDATE users SET steem = u.steem + %s FROM transactions t INNER JOIN users u ON t.id = u.transactionid WHERE t.name =%s""",(amount,memo,))
	cur.execute("""DELETE FROM transactions WHERE name LIKE %s""",(memo,))
	cur.close()
	conn.commit()
	conn.close()

