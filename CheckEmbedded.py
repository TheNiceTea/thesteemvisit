import requests
import json
import psycopg2
'''
r = requests.get('https://webapi.steemdata.com/Operations?where={"type": "transfer", "to": "steemvisit"}')
json = json.loads(r.text)
for item in json["_items"]:
	amount = float(str(item["amount"]["amount"]))
	memo = item["memo"]
'''
try:
    conn=psycopg2.connect("dbname='' user='' password=''")
except:
    print "I am unable to connect to the database."
    
cur = conn.cursor()
try:
	cur.execute("""SELECT name FROM users
					WHERE id IN (SELECT v.voter_id FROM posts p
					INNER JOIN users u ON
					p.user_id = u.id
					INNER JOIN votes v ON
					v.votable_id = p.id
					WHERE v.vote_flag = 't');""")
	print cur.fetchall()
	#cur.execute("""DELETE FROM transactions WHERE name LIKE %s""",(memo,))
	cur.close()
	conn.commit()
	conn.close()
except:
    print "I can't exec"