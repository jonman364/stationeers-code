import sys
from datetime import datetime

print(datetime.fromtimestamp(int(sys.argv[1]) / 10000000 - 11644473600))
