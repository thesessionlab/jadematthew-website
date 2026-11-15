#!/usr/bin/env bash
# Copies every image, thumbnail and audio file off Squarespace into the site, and points the pages at the copies.
# A file that will not download keeps its original address, so nothing breaks.
cd "$(dirname "$0")"
mkdir -p assets/img assets/audio

swap() { # remote-url-pattern local-path
  find . -name '*.html' | while read -r f; do
    depth=$(echo "${f#./}" | awk -F/ '{print NF-1}')
    prefix=""; i=0; while [ $i -lt $depth ]; do prefix="../$prefix"; i=$((i+1)); done
    [ "$f" = "./404.html" ] && prefix="/"
    U="$1" N="$2" perl -pi -e 's/content="\Q$ENV{U}\E(\?format=\d+w)?/content="https:\/\/www.jadematthew.co.uk\/$ENV{N}/g' "$f"
    U="$1" N="$2" P="$prefix" perl -pi -e 's/\Q$ENV{U}\E(\?format=\d+w)?/$ENV{P}$ENV{N}/g' "$f"
  done
}
get() { # url query local-path
  if curl -fsSL -A 'Mozilla/5.0' "$1$2" -o "$3"; then swap "$1" "$3"; echo "ok   $3"; else rm -f "$3"; echo "skip $3"; fi
}

get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/c174b965-e887-4578-a93c-472204d40ec9/JADE+MATTHEW+VOICEOVER+ARTIST+BW+1+%281%29+%281%29.jpg" "?format=1500w" "assets/img/headshot-bw.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/8c7c8bd6-b545-4d45-8db2-8ce2c8eeab4a/headshot+new+1+%281%29.jpg" "?format=1500w" "assets/img/headshot-1.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/cfca4a6b-8adb-4455-a04c-2771d8c14644/headshot+new+3+%281%29.jpg" "?format=1500w" "assets/img/headshot-3.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/2db8a9f1-ff97-4b4c-89ae-a51e7199c8c5/headshot+new+5+%281%29.jpg" "?format=1500w" "assets/img/headshot-5.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/63ac7b24-4c77-4265-90be-36c90778c8be/OVAUK26+Nominee+Badge_Black+Only.png" "?format=1500w" "assets/img/ova-nominee.png"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/4065eee2-e520-47d4-bdbb-5c99a8ea871e/bbcaudiodrama.jpg" "?format=1500w" "assets/img/bbc-audio-drama-awards.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/070e8c30-5666-4daa-9faa-9485af965033/awards.jpeg" "?format=1500w" "assets/img/award-night.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/b4832c26-4d00-4788-84d7-85704521e055/IMG_2992+Small.jpeg" "?format=1500w" "assets/img/studio-hansa.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/024a8fee-ee8a-4371-952f-9b47ca6e5643/IMG_0396+Small.jpeg" "?format=1500w" "assets/img/studio-booth.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/c103cfc5-d620-4d30-8305-e6b0c806df02/IMG_0945+Small.jpeg" "?format=1500w" "assets/img/studio-desk.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/42b8c1c6-954f-452d-b840-51616d10974a/IMG_2332+Small.jpeg" "?format=1500w" "assets/img/studio-window.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/5b4d91ca-101d-4238-ba20-7af4305dbf5a/IMG_2573+Small.jpeg" "?format=1500w" "assets/img/studio-mic.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/f9217cf3-b726-405d-af4e-d0ed546c6e17/IMG_6760+Small.jpeg" "?format=1500w" "assets/img/studio-live-room.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/bcc74586-b2b6-4c94-8037-5fe3fa9e62c0/IMG_7351.PNG" "?format=1500w" "assets/img/studio-vintage.png"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/863ec47e-566e-486c-ba23-4a7dea26e58b/IMG_7690.jpg" "?format=1500w" "assets/img/studio-tape.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/29f53e1d-528b-46e5-a978-f1805aaaa6ec/IMG_8835+Small.jpeg" "?format=1500w" "assets/img/studio-script.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/be712a5f-b61e-464b-a318-6e2626fd6a91/D634677E-49B6-4837-9812-42400E631D64.jpg" "?format=1500w" "assets/img/scripts.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/ffd009fa-9936-4946-9b0c-6aae08e67ecc/the+archers.jpg" "?format=1500w" "assets/img/the-archers.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/b08aced7-69f7-4ace-b8d4-8c61af5325e0/homefront.jpg" "?format=1500w" "assets/img/home-front.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/2d8caa6b-a850-4e2a-87d5-de991749111c/IMG_3264.jpg" "?format=1500w" "assets/img/directing.jpg"
get "https://images.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/ed0ea8d5-57ea-4095-ad1d-dcaabb853cee/jade-matthew-profile-arts-education-and-coaching.jpg" "?format=1500w" "assets/img/about.jpg"
get "https://video.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/3492c799-06c8-4136-8cd5-37cc0795a0f8/thumbnail" "" "assets/img/thumb-yamaha.webp"
get "https://video.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/85426557-fdd3-4845-aa70-c1e65869df1a/thumbnail" "" "assets/img/thumb-bora.webp"
get "https://video.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/6f0d4008-b2ba-4bc7-88c5-ec7f7173eaaf/thumbnail" "" "assets/img/thumb-hellofresh.webp"
get "https://video.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/84dc003d-2062-4d90-85b7-d5c60edd5b75/thumbnail" "" "assets/img/thumb-socialtip.webp"
get "https://video.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/4c3a180e-6504-4ca5-b5da-edb795f2e7b2/thumbnail" "" "assets/img/thumb-skoda.webp"
get "https://video.squarespace-cdn.com/content/v1/655c7f4793fcc243c60bab72/56f26c18-54ec-407c-9a2c-8973f04e9b58/thumbnail" "" "assets/img/thumb-screen-reel.webp"
get "https://static1.squarespace.com/static/655c7f4793fcc243c60bab72/t/682c7b0ee7773238991bf994/1747745560032/Jade+Matthew+-+Commercial+Reel+2025+.mp3" "" "assets/audio/commercial-reel-2025.mp3"
get "https://static1.squarespace.com/static/655c7f4793fcc243c60bab72/t/68304b24d1ab0a018ae39813/1747995388574/A_KIDNAPPING_Ep3of3_PLN403_144A8081_wth_S.mp3" "" "assets/audio/a-kidnapping-episode-3.mp3"
echo "Done."
