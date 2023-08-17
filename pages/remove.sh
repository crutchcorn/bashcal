if [[ "$REQUEST_METHOD" != "POST" ]]; then
  # only allow POST to this endpoint
  return $(status_code 405)
fi

MONTH=$(awk '{ print $1 }' data/month)
YEAR=$(awk '{ print $2 }' data/month)

MONTH=$(( MONTH - 1 ))
if [[ $MONTH -lt 1 ]]; then
  MONTH=12
  YEAR=$(( YEAR - 1 ))
fi

echo "$MONTH $YEAR" > data/month

CALENDAR=$(component "/calendar" | tr '\n' ' ')
printf "event: calendar\ndata: %s\n\n" "$CALENDAR" \
    | publish "calendar"
