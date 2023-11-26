

reactのテンプレートはgithub上に公開されています。

from https://github.com/topics/react-template

これらプロジェクトのソースを利用することにより**reactのデザインを一から考える必要がなくなります。**
それだけでなく**高品質なコードを利用できるため、保守性の向上も望めるでしょう。**

また、Starが多くついているGithubのソースコードはとても参考になります。

今回参考にしたのは`react-material-admin`というプロジェクト

そこでこんなコードを見つけた。

from https://github.com/flatlogic/react-material-admin

```js
const structure = [
  { id: 0, label: "Dashboard", link: "/app/dashboard", icon: <HomeIcon /> },
  ...
  { id: 5, type: "divider" },
  { id: 6, type: "title", label: "HELP" },
  { id: 7, label: "Library", link: "https://flatlogic.com/templates", icon: <LibraryIcon /> },
  { id: 8, label: "Support", link: "https://flatlogic.com/forum", icon: <SupportIcon /> },
  { id: 9, label: "FAQ", link: "https://flatlogic.com/forum", icon: <FAQIcon /> },
  { id: 10, type: "divider" },
  { id: 11, type: "title", label: "PROJECTS" },
];

return (<>
  <List className={classes.sidebarList}>
    {structure.map(link => (
      <SidebarLink
        key={link.id}
        location={location}
        isSidebarOpened={isSidebarOpened}
        {...link}
      />
    ))}
  </List>
</>)
```


このコードでは`struct`というサイドバーの中身を表す連想配列と、それらを展開する`map`という関数で構成されている。

structの中身を展開する際には、デフォルトで最低限必要とされている引数以外は、`...link`という形で関数に渡している。

### メリット

`struct`は**それぞれのリンクのカスタマイズに最低限必要なデータしか存在しない。**
SidebarLinkを大量に使用する方法に比べて、**コードの圧縮率が格段に高い**

これにより

- リンクを編集する際にどこを変更すればよいかが明白
- リンクそのものであるSidebarLinkの重複を防ぐことができる

等のメリットがある。













