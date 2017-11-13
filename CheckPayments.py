import requests
import json
import psycopg2
import os


r = requests.get('https://webapi.steemdata.com/Operations?where={"type": "transfer", "to": "steemvisit"}')
json = json.loads(r.text)
for item in json["_items"]:
	amount = float(str(item["amount"]["amount"]))
	memo = item["memo"]
	try:
		conn = psycopg2.connect((os.environ['DATABASE_URL']),sslmode='require')
	except:
	    print ("I am unable to connect to the database.")
	cur = conn.cursor()
	try:
		cur.execute("""UPDATE users SET steem = u.steem + %s FROM transactions t INNER JOIN users u ON t.id = u.transactionid WHERE t.name =%s""",(amount,memo,))
		cur.execute("""DELETE FROM transactions WHERE name LIKE %s""",(memo,))
		cur.close()
		conn.commit()
		conn.close()
	except:
	    print ("I can't exec")

#s.get_account_history('steemvisit',index_from=-1,limit=1)