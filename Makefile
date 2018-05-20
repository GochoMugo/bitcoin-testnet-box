BITCOINCLI=bitcoin-cli
B1_FLAGS=
B2_FLAGS=
B1=-datadir=nodes/1 $(B1_FLAGS)
B2=-datadir=nodes/2 $(B2_FLAGS)
BLOCKS=1
ADDRESS=
AMOUNT=
ACCOUNT=

generate:
	$(BITCOINCLI) $(B1) generate $(BLOCKS)

getwalletinfo:
	$(BITCOINCLI) $(B1) getwalletinfo
	$(BITCOINCLI) $(B2) getwalletinfo

sendfrom1:
	$(BITCOINCLI) $(B1) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom2:
	$(BITCOINCLI) $(B2) sendtoaddress $(ADDRESS) $(AMOUNT)

address1:
	$(BITCOINCLI) $(B1) getnewaddress $(ACCOUNT)

address2:
	$(BITCOINCLI) $(B2) getnewaddress $(ACCOUNT)

stop:
	$(BITCOINCLI) $(B1) stop
	$(BITCOINCLI) $(B2) stop

clean:
	find nodes/1/regtest/* -not -name 'server.*' -delete
	find nodes/2/regtest/* -not -name 'server.*' -delete
