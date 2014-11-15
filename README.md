花瓣图片下载工具
===============

从 huaban.com 导出图片，保存到本地

## 用法

目前只提供 rake 任务，稍后做成 gem

~~~sh
rake boards         # 列出一个用户的所有画板 (user=用户名 rake boards)
rake export_board   # 导出一个画板的所有图片到本地 (board_id=画板id  rake export_board)
rake export_boards  # 导出用户所有的画板图片到本地 (user=用户名 rake export_boards)
rake pins           # 列出一个画板所有的采集 (board_id=画板id rake pins)
~~~
