from datetime import datetime, timedelta


now =  datetime(2017,8,4)
print('hoje', now)
print('week', now.weekday())
print(now - timedelta(days=4))

date_ = now - timedelta(days=4)
print(type(date_))