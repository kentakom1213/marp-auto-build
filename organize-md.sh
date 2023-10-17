#!/bin/zsh

local MARP_CDN='
<!-- mermaid.js -->
<script src="https://unpkg.com/mermaid@8.1.0/dist/mermaid.min.js"></script>
<script>mermaid.initialize({startOnLoad:true});</script>'

# slidesのリセット
rm -rf slides && mkdir -p slides/images
touch slides/images/.gitkeep

# magesのリセット
rm -rf output && mkdir -p output/images
touch output/images/.gitkeep

# slides/index.mdのリセット
echo '# slides' > slides/index.md

# ディレクトリのみ取り出し
for dir in $(ls -l | grep '^d' | awk '{print $9}')
do
    if [[ ! $dir =~ "slides|output" ]] then
        # markdownファイルのコピー
        cat "$dir/slide.md" > "slides/$dir.md"
        echo $MARP_CDN >> "slides/$dir.md"
        # indexに追記
        echo "- [$dir](./$dir) ([PDF](./$dir.pdf))" >> 'slides/index.md'
        # imagesのコピー
        for img in $(ls "$dir/images")
        do
            cp "$dir/images/$img" slides/images
            cp "$dir/images/$img" output/images
        done
    fi
done
