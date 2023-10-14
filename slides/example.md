---
marp: true
header: "example"
theme: gaia
class: invert
paginate: true
math: katex
---


# marp-auto-build

by [kentakom1213](https://github.com/kentakom1213/)

<hr>

marpで作成したスライドを自動でビルドし、GitHub Pagesにデプロイします。

- 公開先：https://kentakom1213.github.io/marp-auto-build/

---
## 手順
1. gitのhookを設定
2. スライドの追加
3. テーマの追加
4. デプロイ


---
### 1. gitのhookを設定

`.git/hooks/pre-commit`を作成し、以下を書き加えます。

```sh
#!/bin/zsh

# arrange files
./organize-md.sh

# staging
git add .
```

**注意**：`organize-md.sh`はzshで書かれているため、それ以外のシェルを使っているかたは適宜書き換えてください。


---
### 2. スライドの追加

スライドは、`example/`ディレクトリにならって作成してください。

```
${スライド名}/
  ├ images/
  │  ├ image1.png
  │  ├ image2.png
  │  ...
  └ slide.md
```

**注意**：`images/`の中に入っているファイル名が重複すると、`slides/images`に画像がコピーされる際に上書きされてしまうため、ファイル名は重複しないようにしてください。


---
### 3. テーマの追加

自作css等のカスタムテーマは、`.marp/themes`ディレクトリに格納してください。


---
### 4. デプロイ

mainブランチにコミットし、pushされるとGitHub Actionsにより自動でビルド、デプロイされます。
デプロイ先のURLは`https://${GitHubのユーザ名}.github.io/${リポジトリ名}`です。


---
画像のテスト

![w:800](images/calc_graph_example.png)

<!-- mermaid.js -->
<script src="https://unpkg.com/mermaid@8.1.0/dist/mermaid.min.js"></script>
<script>mermaid.initialize({startOnLoad:true});</script>
