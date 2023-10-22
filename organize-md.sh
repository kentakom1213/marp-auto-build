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
    local tmpdir=$dir
    if [[ `ls $dir | grep 'secret'` ]] then
        if [[ ! `cat $dir/secret` ]] then
            uuidgen | tr "[:upper:]" "[:lower:]" > "$dir/secret"
        fi
        tmpdir=`cat $dir/secret`
        mv $dir $tmpdir
    fi
    if [[ ! $tmpdir =~ "slides|output" ]] then
        # markdownファイルのコピー
        cat "$tmpdir/slide.md" > "slides/$tmpdir.md"
        echo $MARP_CDN >> "slides/$tmpdir.md"
        # imagesのコピー
        for img in $(ls "$tmpdir/images")
        do
            cp "$tmpdir/images/$img" slides/images
            cp "$tmpdir/images/$img" output/images
        done
        # indexに追記
        if [[ $dir == $tmpdir ]] then
            echo "- [$dir](./$dir) ([PDF](./$dir.pdf))" >> 'slides/index.md'
        else
            mv $tmpdir $dir
        fi
    fi
done
