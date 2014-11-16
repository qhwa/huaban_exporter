花瓣图片下载工具
===============

从 huaban.com 导出图片，保存到本地

## 安装

~~~sh
gem install hb_exporter
~~~

## 用法

* 列出一个用户的所有画板

    ~~~sh
    huaban list boards --of <用户名>
    ~~~

* 列出一个画板所有的采集

    ~~~sh
    huaban list pins --of <board_id>
    ~~~

* 导出所有画板的所有图片到本地

    ~~~sh
    huaban export boards --of <用户名>
    ~~~

* 导出一个画板的所有图片到本地

    ~~~sh
    huaban export pins --of <board_id>
    ~~~
