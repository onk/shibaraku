## Shibaraku master (unreleased)
[full changelog](https://github.com/onk/shibaraku/compare/v0.0.2...master)

*   カラム名が `start_at` / `end_at` 決め打ちだったので、`started_at` 等をオプションで渡せるようにした

    ```ruby
    class Event
      shibaraku start_at: :started_at, end_at: :ended_at
    end
    ```


## Shibaraku v0.0.2 (2014-12-05)

[full changelog](https://github.com/onk/shibaraku/compare/v0.0.1...v0.0.2)

* 終了時刻の 00:00 は分かりづらいので前日の 23:59 と返すメソッドを用意 (@onk)


## Shibaraku v0.0.1 (2014-11-18)

* Initial Release
