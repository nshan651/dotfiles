#!/bin/sh

API="https://api.kraken.com/0/public/Ticker"

# BTC Price
BTC=$(curl -sf $API?pair=BTCUSD | jq -r ".result.XXBTZUSD.c[0]")
BTC=$(LANG=C printf "%.2f" "$BTC")
# XMR Price
XMR=$(curl -sf $API?pair=XMRUSD | jq -r ".result.XXMRZUSD.c[0]")
XMR=$(LANG=C printf "%.2f" "$XMR")
# ETH
ETH=$(curl -sf $API?pair=ETHUSD | jq -r ".result.XETHZUSD.c[0]")
ETH=$(LANG=C printf "%.2f" "$ETH")
echo -e " \uE02E $BTC  \uE135 $XMR  \uE058 $ETH"
