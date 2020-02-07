#!/bin/bash

# Small Bash script to iterate over a list of URLs and print their HTTP status 
# code along with time and download meta information.

xargs `# using xargs to allow for parallel connections` \
  -n1 `# pass just one URL from the urls.txt as argument to the curl call$` \
  -P 5 `# keep 5 curl processes alive at any time` \
  curl -o /dev/null `# redirect output` \
  --silent `# disable the progress meter` \
  --head `# making a head reaquest` \
  --write-out `# specifying the output format` \
  '"%{url_effective}";"%{http_code}";"%{time_total}";"%{time_namelookup}";"%{time_connect}";"%{size_download}";"%{speed_download}"\n' \
  < http-status-code-checker_urls.txt | `# read URLs from file` \
  tee http-status-code-checker_results.csv `# write results to file`
