#!/bin/bash
export HTTPSTAT_METRICS_ONLY=true
# cd github
#  for i in {001..200}
#  do
#     httpstat https://icpmoles.github.io/lorem/ > "$i".json
#     echo "github $i"
#  done

#  cd ../netlify
#  for i in {001..200}
#  do
#     httpstat https://pixtest.netlify.app/lorem/ > "$i".json
#       echo "netlify $i"
#  done
# cd ../cloudflare
# for i in {001..200}
# do
#    httpstat https://icpmoles.pages.dev/lorem/ > "$i".json
#        echo "cloudflare $i"
# done
# cd ../vercel
# for i in {001..200}
# do
#    echo "vercel $i"
#    httpstat https://icpmoles.vercel.app/lorem > "$i".json
# done

cd render
for i in {001..200}
do
   httpstat https://hugoback.onrender.com/lorem > "$i".json
   echo "render $i"
done