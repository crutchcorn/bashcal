
DATE="${REQUEST_PATH##*/}";

# todo: sanitize 😉
touch data/$DATE

if [[ "$REQUEST_METHOD" == "POST" ]]; then
    # add the item to the list
    echo "${FORM_DATA[item]}" >> data/$DATE
fi

ITEMS=$(awk '{ print "<li>"$0"</li>" }' data/$DATE)
htmx_page << EOF
    <div id="sidebar">
        <h2>${DATE}</h2>
        <ul>
            ${ITEMS}
        </ul>
        <form>
            <input name="item" type="text" />
            <button type="submit" hx-post="/date/$DATE" hx-target="#sidebar">Submit</button>
        </form>
    </div>
EOF
