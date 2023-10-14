---
marp: true
header: "example"
theme: gaia
paginate: true
math: katex
---


# marp-auto-build

by [kentakom1213](https://github.com/kentakom1213/)

<hr>

marpで作成したスライドを自動でビルドし、GitHub Pagesにデプロイします。

- 公開先：https://kentakom1213.github.io/marp-auto-build/


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
### 2. 権限の追加

リポジトリの設定画面から、

`Settings > Actions > General > Workflow permissions` を `Read and write permissions` に変更します。

![w:800](images/example_permission.png)


---
### 3. GitHub Pagesを有効化

リポジトリの設定画面から、

`Settings > Pages > Build and deployment > Branch`を`gh-pages`に変更してください。

![w:700](images/example_pages.png)

---
### 4. スライドの追加

スライドは、`example/`ディレクトリにならって作成してください。

```
slide-name/
  ├ images/
  │  ├ image1.png
  │  ├ image2.png
  │  ...
  └ slide.md
```

カスタムcssは、`.marp/themes`ディレクトリに格納してください。

**注意**：`images/`の中に入っているファイル名は（全スライドを通じて）重複しないようにしてください。

---
### 5. commit & push

mainブランチにコミットし、pushされるとGitHub Actionsにより自動でビルド、デプロイされます。
デプロイ先のURLは`https://${GitHubのユーザ名}.github.io/${リポジトリ名}`です。


---
# 完成！

よいmarpライフを！
