#!/usr/bin/env python
# -*- coding:utf-8 -*-

import json
import ssl
import urllib.request

import certifi

file_name = 'TextBlog.json'
url = 'https://api.github.com/repos/renyuzhuo/Blog/issues?labels=TextBlog&state=all'
blogList = []

if __name__ == '__main__':
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 '
                             'Safari/537.36',
               'content-type': 'application/json',
               'Accept': 'application/vnd.github.v3+json'}
    request = urllib.request.Request(url, headers=headers)
    json_string = urllib.request.urlopen(request, context=ssl.create_default_context(cafile=certifi.where()))
    issuesList = json.load(json_string)
    for item in issuesList:
        blogItem = {
            'number': item['number'],
            'title': item['title'],
            'created_at': item['created_at'].replace("T", " ").replace("Z", ""),
            'body': item['body']
        }
        print(blogItem)
        blogList.append(blogItem)
    with open(file_name, 'w') as file:
        file.write(json.dumps(blogList, ensure_ascii=False, separators=(',', ':')))
