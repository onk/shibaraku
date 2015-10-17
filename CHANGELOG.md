## Shibaraku master (unreleased)
[full changelog](https://github.com/onk/shibaraku/compare/v1.1.0...master)


## Shibaraku v1.1.0 (2015-10-18)
[full changelog](https://github.com/onk/shibaraku/compare/v0.0.4...v1.1.0)

*   rubygems.org に公開するため歴史を改ざん
*   `bundle gem shibaraku` をやり直して最新に追随した


## Shibaraku v0.0.4 (2015-03-06)
[full changelog](https://github.com/onk/shibaraku/compare/v0.0.3...v0.0.4)

*   `.in_time` および `#in_time?` の第一引数(`user`) を省略可能にした

    ```ruby
    Campaign.in_time
    # => select start_at <= now < end_at records

    Campaign.in_time(normal_user)
    # => select start_at <= now < end_at records

    Campaign.in_time(super_user)
    # => select test_start_at <= now < test_end_at records
    ```


## Shibaraku v0.0.3 (2014-12-16)
[full changelog](https://github.com/onk/shibaraku/compare/v0.0.2...v0.0.3)

*   カラム名が `start_at` / `end_at` 決め打ちだったので、`started_at` 等をオプションで渡せるようにした

    ```ruby
    class Event
      shibaraku start_at: :started_at, end_at: :ended_at
    end
    ```

*   運営ユーザは test_start_at を見る、という運用に対応した

    ```ruby
    Campaign.in_time(normal_user)
    # => select start_at <= now < end_at records

    Campaign.in_time(super_user)
    # => select test_start_at <= now < test_end_at records
    ```

    **Breaking Change**
    メソッドの第1引数に `super_user?` が呼べるオブジェクトを渡すように変更しました。
    全体的にアプリケーション側のコードの修正が必要です。


## Shibaraku v0.0.2 (2014-12-05)

[full changelog](https://github.com/onk/shibaraku/compare/v0.0.1...v0.0.2)

* 終了時刻の 00:00 は分かりづらいので前日の 23:59 と返すメソッドを用意 (@onk)


## Shibaraku v0.0.1 (2014-11-18)

* Initial Release
