# Deepti Creation website

Two versions, same site:
- index.html      soft gradient background (can be switched in Admin > Settings)
- botanical.html  lotus-pond background, fixed

## See it on your computer
Unzip, double-click index.html or botanical.html. Demo mode, no setup.

## Put it online (free)
app.netlify.com/drop: drag the whole folder in. Open the link on your phone.
Keep assets/ next to the html files.

## Connect the database
1. Supabase > SQL Editor: run supabase-setup.sql (new project) or supabase-update.sql (if you already ran the older one).
2. Authentication > Users > Add user (your admin login).
3. In the html file, fill in SUPABASE_URL, SUPABASE_KEY, MAP_EMBED_URL in the CONFIG block (last script).
4. Upload the folder again.

## Admin
yoursite.com/#admin  (Products with several photos + optional sticker cutout, Orders, Reviews, Reels, Settings)

## As an app
Phone: open the hosted link > Add to Home Screen. manifest.webmanifest, sw.js and assets/icon-*.png are what an Android APK wrapper needs.
