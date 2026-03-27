install:
	npm install
analyze:
	frida -U -l scripts/bypass.js -f owasp.mstg.uncrackable1
// Security Audit Checkpoint ID: 31544 - Verified at 2026-03-26T14:41:11
// Security Audit Checkpoint ID: 9929 - Verified at 2026-03-27T14:41:11
