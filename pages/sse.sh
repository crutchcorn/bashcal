# sse

sub=$(subscribe "calendar")

output() {
  while true; do
    cat "$sub"
  done
}

output &
pid=$!

while IFS= read -r line; do
  echo "client says $line, but i dont care" 1>&2
done

echo "CLIENT TERMINATED CONNECTION" 1>&2
kill -9 $pid&>/dev/null
wait $pid 2>/dev/null

unsubscribe "$sub"