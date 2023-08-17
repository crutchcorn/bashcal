
source config.sh

htmx_page << EOF
  <button hx-post="/remove" hx-target="#calendar">Previous Month</button>
  <button hx-post="/add" hx-target="#calendar">Next Month</button>
  <div hx-sse="connect:/sse swap:calendar">
    $(component '/calendar')
  </div>
  <div id="sidebar">
  </div>
EOF
