# jadematthew.co.uk

Jade Matthew's portfolio site. Plain HTML and CSS, hosted on GitHub Pages. Any change pushed to `main` republishes the site.

```
index.html          The whole site: hero, demos, voice, studio, screen, directing, about, contact
aboutme/ voiceover/ acting/ director/ contactme/
                    Old Squarespace addresses, forwarding to the right part of the page
thanks/             Shown after someone sends the enquiry form
assets/style.css    All styling (colours at the top)
assets/site.js      Audio players, video cards, menu
assets/img/         Photos and video stills
assets/audio/       Demo reels
assets/video/       Drop video files here (see below)
```

## Adding the videos

The six videos on the old site were locked inside Squarespace's player, so they could not be copied.
Save the original files into `assets/video/` with these names and they become playable automatically:

| File | Card |
|------|------|
| `yamaha.mp4` | Yamaha, Riding the Night |
| `hello-fresh.mp4` | Hello Fresh |
| `skoda.mp4` | Skoda |
| `bora.mp4` | Bora |
| `social-tip.mp4` | Social Tip |
| `screen-reel.mp4` | Screen reel |

Keep each file under 100 MB (GitHub's limit). Until a file is there, its card shows the still with no play button.

## Adding a demo

Put the MP3 in `assets/audio/`, then copy one of the `<div class="player">` blocks in `index.html`
and change the title, description and file name.

## Enquiry form

The form sends to jadematthewvoices@gmail.com through FormSubmit (formsubmit.co). The first enquiry
triggers an activation email to that address: click the link once and every enquiry after that arrives normally.

## Colours

```
--bg:    #E4DCD6   stone background
--ink:   #0E0B0A   text
--brown: #2A1D1A   demo section and footer
--cream: #EFE8E3   text on brown
```
