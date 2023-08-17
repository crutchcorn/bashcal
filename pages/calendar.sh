
if [[ ! -f data/month ]]; then
  echo $(date +"%-m %-Y") > data/month
fi

CAL_ARGS=$(cat data/month)
if [[ "$CAL_ARGS" == "$(date +"%-m %-Y")" ]]; then
    DAY=$(date +"%-d")
    CURSED_CSS='
    tbody #date-'$DAY' {
        background: red;
    }'
fi
CALENDAR_HEAD=$(cal $CAL_ARGS \
  | tail -n +2 \
  | head -n 1 \
  | sed 's@^\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s*$@<th>\1</th><th>\2</th><th>\3</th><th>\4</th><th>\5</th><th>\6</th><th>\7</th>@g' \
  | awk '{ print "<tr>"$0"</tr>" }')

CALENDAR_BODY=$(cal $CAL_ARGS \
  | tail -n +3 \
  | head -n -1 \
  | sed 's@^\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s*$@<td id="date-\1">\1</td><td id="date-\2">\2</td><td id="date-\3">\3</td><td id="date-\4">\4</td><td id="date-\5">\5</td><td id="date-\6">\6</td><td id="date-\7">\7</td>@g' \
  | sed 's@id="date-\s*\([0-9]*\)"@id="date-\1"@g' \
  | awk '{ print "<tr>"$0"</tr>" }')

#^(?:\s(\w)|(\w{2})|()\s{2})\s$

# (?:\s(\w)|(\w{2})|()\s{2})\s

# ^(?:\s(?<one>\w)|(?<one>\w{2})|(?<one>)\s{2})\s(?:\s(?<two>\w)|(?<two>\w{2})|(?<two>)\s{2})\s(?:\s(?<three>\w)|(?<three>\w{2})|(?<three>)\s{2})\s(?:\s(?<four>\w)|(?<four>\w{2})|(?<four>)\s{2})\s(?:\s(?<five>\w)|(?<five>\w{2})|(?<five>)\s{2})\s(?:\s(?<six>\w)|(?<six>\w{2})|(?<six>)\s{2})\s(?:\s(?<seven>\w)|(?<seven>\w{2})|(?<seven>)\s{2})\s*$


CALENDAR_TITLE=$(cal $CAL_ARGS | head -n1)
htmx_page << EOF
<div id="calendar">
  <h1>$CALENDAR_TITLE</h1>
  <table>
    <thead>
        ${CALENDAR_HEAD}
    </thead>
    <tbody>
        ${CALENDAR_BODY}
    </tbody>
  </table>
  <style>${CURSED_CSS}</style>
</div>
EOF
