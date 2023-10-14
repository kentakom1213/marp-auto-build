#!/bin/zsh

# mermaidのCDNリンク
local MARP_CDN='
<!-- mermaid.js -->
<script src="https://unpkg.com/mermaid@8.1.0/dist/mermaid.min.js"></script>
<script>mermaid.initialize({startOnLoad:true});</script>'

# slides/index.mdのリセット
echo '# slides' > slides/index.md

# slides/imagesのリセット
rm -rf slides/images && mkdir slides/images
rm -rf output/images && mkdir output/images

# ディレクトリのみ取り出し
for dir in $(ls -l | grep '^d' | awk '{print $9}')
do
    if [[ ! $dir =~ "slides|output" ]] then
        # markdownファイルのコピー
        cat "$dir/slide.md" > "slides/$dir.md"
        # mermaidのCDNを追加
        echo $MARP_CDN >> "slides/$dir.md"
        # indexに追記
        echo "- [$dir](./$dir)" >> 'slides/index.md'
        # imagesのコピー
        for img in $(ls "$dir/images")
        do
            cp "$dir/images/$img" slides/images
            cp "$dir/images/$img" output/images
        done
    fi
done
