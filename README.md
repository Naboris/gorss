# GORSS - Go RSS Reader

## About
Simple RSS/Atom reader written in Golang. Highly configurable and with themes.

![Overview](preview.png)

[Screenshots](#screenshots)

Prebuilt binaries exists in `bin` folder. You will need the `gorss.conf` and `default.theme` to execute
the binaries.

Any error will be written to `gorss.log`. Note that it also logs key-presses to `gorss.log` in order to 
easily spot what keys you might want to bind in `gorss.conf`.

## Features
- RSS and Atom support (via github.com/mmcdole/gofeed)
- Highlights for configurable words
- Keyboard shortcuts highly configurable
- Custom keys for custom execution of external applications
- Open links in browser
- Mark articles and open all marked in bulk in webbrowser
- Theme support
- Preview content of the RSS
- Backed by SQLite database
- Mark articles as read
- Mark all as read/unread

## Configuration Example (Default config)
It's possible to specify configuration file as a flag, default is `gorss.conf`.
```
./gorss -config my.conf
```

```
{
    "highlights": [
        "emulation",
        "truck",
        "google",
        "network",
        "math",
        "tesla"
    ],
    "feeds": [
        "https://news.ycombinator.com/rss",
        "https://www.sweclockers.com/feeds/nyheter",
        "https://www.reddit.com/r/homeassistant/.rss"
    ],
    "secondsBetweenUpdates": 120,
    "skipPreviewInTab": true,
    "keyOpenLink": "Backspace2",
    "keyMarkLink": "Enter",
    "keyOpenMarked": "o",
    "keyDeleteArticle": "d",
    "keyMoveDown": "s",
    "keyMoveUp": "w",
    "keySortByDate": "r",
    "keySortByUnread": "e",
    "keySortByTitle": "t",
    "keySortByFeed": "y",
    "keyUpdateFeeds": "Ctrl+U",
    "keyMarkAllRead": "Ctrl+R",
    "keyMarkAllUnread": "Ctrl+T",
    "keyTogglePreview": "q",
    "keySelectFeedWindow": "1",
    "keySelectArticleWindow": "2",
    "keySelectPreviewWindow": "3",
    "keyToggleHelp": "h",
    "keySwitchWindows": "Tab",
    "keyQuit": "Esc",
    "customCommands": [
        { 
            "key": "j",
            "Cmd": "echo 'ARTICLE.Content' 'ARTICLE.Link' > /tmp/test2.txt"
        },
        { 
            "key": "k",
            "Cmd": "echo 'ARTICLE.Title' 'ARTICLE.Feed' > /tmp/test.txt"
        }
    ]
}
```

## Custom Commands
Custom commands can be added such as the example in the example configuration above.

The variables given will be substituted with the content of the given article. There are no escaping going on
so be careful!

Available variables are:
* `ARTICLE.Content` - The content of the article
* `ARTICLE.Link` - The link to the article
* `ARTICLE.Feed` - Name of the feed
* `ARTICLE.Title` - Title of the article

## Themes
Themes are highly configurable and 3 example themes are included. You can start gorss with a specific theme as argument.
```
./gorss -theme my.theme
```

Themes are configured with JSON, default example below:
```
{
    "feedNames": [
        "#8ed2c8",
        "#46aa9f",
        "#2e6294",
        "#3b9293"
    ],
    "date": "#a25478",
    "time": "#f96bad",
    "articleBorder": "#4b7d81",
    "previewBorder": "#4b7d81",
    "feedBorder": "#4b7d81",
    "feedBorderTitle": "#fcedd5",
    "articleBorderTitle": "#fcedd5",
    "previewBorderTitle": "#fcedd5",
    "highlights": "#c90036",
    "tableHead": "#b2b37d",
    "title": "#fcedd5",
    "unreadFeedName": "#FFFFFF",
    "totalColumn": "#FFFFFF",
    "unreadColumn": "#FFFFFF",
    "previewText": "#FFFFFF",
    "previewLink": "#39537e",
    "statusBackground": "#4b7d81",
    "statusText": "#fcedd5",
    "statusKey": "#f6d270",
    "statusBrackets": "#bfceab",
    "feedIcon": "🔖",
    "articleIcon": "🗞",
    "previewIcon": "📰",
    "linkMarker": "🌍",
    "unreadMarker": "🌟"
}
```

## [Screenshots]
![default theme](default.png)
![irssi theme](irssi.png)
![night theme](night.png)

## License
MIT