#!/bin/bash

INPUT="$1"
OUTPUT="$2"

FONT_DIR="/var/www/bookstack/public/fonts/iranyekan"
LETTERHEAD_PATH="/var/www/bookstack/public/websila/websila-letter-head.png"
TMP_HTML="/tmp/bookstack_rtl.html"

cat <<EOF > "$TMP_HTML"
<!DOCTYPE html>
<html lang="fa" dir="rtl">
<head>
    <meta charset="UTF-8">
    <style>
        @font-face {
            font-family: 'IRANYekan';
            src: url("file://$FONT_DIR/IRANYekanXVF.woff2") format("woff2"),
                 url("file://$FONT_DIR/IRANYekanXVF.woff") format("woff");
            font-weight: normal;
            font-style: normal;
        }
        
        @page {
            size: A4;
        }

        html {
            font-family: 'IRANYekan', sans-serif;
        }

        p,h1,h2,h3,h4,h5,h6,span,div {
            line-height: 180% !important;
        }

    </style>
</head>
<body>
EOF

cat "$INPUT" >> "$TMP_HTML"
echo "</body></html>" >> "$TMP_HTML"

/opt/weasy-env/bin/weasyprint "$TMP_HTML" "$OUTPUT" 2>> /tmp/weasy-debug.log
echo "Exit code: $?" >> /tmp/weasy-debug.log
