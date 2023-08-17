
if [[ ! -f data/month ]]; then
  echo $(date +"%-m %-Y") > data/month
fi

CAL_ARGS=$(cat data/month)
CALENDAR_HEAD=$(cal $CAL_ARGS \
  | tail -n +2 \
  | head -n 1 \
  | sed 's@^\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s*$@<th>\1</th><th>\2</th><th>\3</th><th>\4</th><th>\5</th><th>\6</th><th>\7</th>@g' \
  | awk '{ print "<tr>"$0"</tr>" }')

CALENDAR_BODY=$(cal $CAL_ARGS \
  | tail -n +3 \
  | head -n -1 \
  | sed 's@^\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s\(.\{2\}\)\s*$@<td>\1</td><td>\2</td><td>\3</td><td>\4</td><td>\5</td><td>\6</td><td>\7</td>@g' \
  | awk '{ print "<tr>"$0"</tr>" }')

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
</div>
EOF
