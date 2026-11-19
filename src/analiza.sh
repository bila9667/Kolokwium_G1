#!/usr/bin/env bash
# Kolokwium — plik do samodzielnego uzupełnienia.
# Uruchomienie: bash src/analiza.sh dane
# Wynik: nazwa.log;liczba_ERROR;STATUS

KATALOG="${1:-dane}"
if [[ ! -d "$KATALOG" ]]; then
echo "Katalog nie istnieje" >&2
exit 2
fi

for PLIK in "$KATALOG"/*.log; do
[[ -f "$PLIK" ]] || continue 
ILE_ERROR=$(grep -c '^ERROR;' "$PLIK")
ILE_WARN=$(grep -c '^WARN;' "$PLIK")
if (( ILE_WARN >=2 )); then 
STATUS="ALARM"
else
STATUS="OK"
fi
printf '%s;%s;%s\n' "$(basename "$PLIK")" "$ILE_ERROR" "$STATUS"
done
