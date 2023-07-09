


## 辞書は頻繁に使うべし

```jsx
// NG
switch (user.type) {
  case user:
    return <User />;
  case admin:
    return <AdminUser />;
  case host:
    return <HostUser />;
}

// Good🥴
const userView = {
  user: <User />,
  admin: <AdminUser />,
  host: <HostUser />,
};

return userView[user.type];
```

from https://qiita.com/JNJDUNK/items/e040925e546a45a1d913#7-%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%81%AF%E4%BD%BF%E3%81%84%E3%81%93%E3%81%AA%E3%81%9B%E3%81%A6%E3%81%84%E3%82%8B%E3%81%8B

<iframe width="560" height="315" src="https://www.youtube.com/embed/Un0aoW0kNeE?start=374" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

