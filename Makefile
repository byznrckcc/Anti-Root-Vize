install:
	npm install
analyze:
	frida -U -l scripts/bypass.js -f owasp.mstg.uncrackable1
