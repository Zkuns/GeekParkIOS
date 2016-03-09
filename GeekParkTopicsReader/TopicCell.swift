//
//  TopicCell.swift
//  GeekParkTopicsReader
//
//  Created by 朱坤 on 3/7/16.
//  Copyright © 2016 Zkuns. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell{
  
  @IBOutlet weak var title: UILabel!
  func setData(topic: Topic){
    title.text = topic.title
  }
}