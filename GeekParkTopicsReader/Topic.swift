//
//  Topic.swift
//  GeekParkTopicsReader
//
//  Created by 朱坤 on 3/7/16.
//  Copyright © 2016 Zkuns. All rights reserved.
//

import Foundation

struct Topic{
  var title: String
  var body: String
  var publish_at: String
  var cover_url: String
  init(title: String, body: String, publish_at: String, cover_url: String){
    self.title = title
    self.body = body
    self.publish_at = publish_at
    self.cover_url = cover_url
  }
}