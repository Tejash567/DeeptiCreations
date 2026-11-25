# Deepti Creation website

## See it on your computer
Unzip, double-click index.html. It opens in demo mode with sample pieces.

## Put it online (free)
app.netlify.com/drop: drag the whole deepti-creation folder in, then open the link on your phone.
Keep the assets folder next to index.html.

## Connect the database
1. Supabase > SQL Editor: run supabase-setup.sql for a new project.
   If you already have tables, or the admin says "permission denied for table products", run supabase-fix.sql once instead.
2. Authentication > Users > Add user (your admin login).
3. In index.html fill in SUPABASE_URL, SUPABASE_KEY and MAP_EMBED_URL in the CONFIG block (top of the last script).
4. Upload the folder again.

## Admin
yoursite.com/#admin: Products (several photos, New arrival toggle, automatic Product ID), Orders, Reviews, Reels (upload a video: it autoplays muted).

## Policies
Privacy Policy and Return & Refund Policy text is in index.html (search for "const POL"). Please read it and change the return window, refund time and anything else to match how the store really works.

## As an app
Phone: open the hosted link > Add to Home Screen. manifest.webmanifest, sw.js and assets/icon-*.png are what an Android APK wrapper needs.
