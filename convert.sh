#!/bin/bash

echo "Script called at $(date)" >> /tmp/weasy-debug.log
echo "INPUT: $1" >> /tmp/weasy-debug.log
echo "OUTPUT: $2" >> /tmp/weasy-debug.log
echo "==== RAW INPUT BEGIN ====" >> /tmp/weasy-debug.log
cat "$1" >> /tmp/weasy-debug.log
echo "==== RAW INPUT END ====" >> /tmp/weasy-debug.log

INPUT="$1"
OUTPUT="$2"

FONT_DIR="/var/www/bookstack/public/fonts/iranyekan"
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

        body {
            font-family: 'IRANYekan', sans-serif;
            line-height: normal;
        }
    </style>
</head>
<body>
EOF

cat "$INPUT" >> "$TMP_HTML"
echo "</body></html>" >> "$TMP_HTML"

/opt/weasy-env/bin/weasyprint "$TMP_HTML" "$OUTPUT"
