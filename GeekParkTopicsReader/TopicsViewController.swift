//
//  ViewController.swift
//  GeekParkTopicsReader
//
//  Created by 朱坤 on 3/7/16.
//  Copyright © 2016 Zkuns. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController {

  @IBOutlet weak var topicsTable: UITableView!
  var imageView: UIImageView?
  var topics = [[Topic]]()
  override func viewDidLoad() {
    super.viewDidLoad()
    topics = [[Topic(title: "name", body: "body", publish_at: "publish_at", cover_url: "http://www.geekpark.net")]]
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    animate()
  }
  
  func animate(){
    imageView = UIImageView(image: UIImage(named: "1.pic"))
    imageView?.backgroundColor = UIColor.grayColor()
    imageView?.layer.masksToBounds = true
    imageView?.layer.cornerRadius = 5.0
    imageView?.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(imageView!)
    
    let IDotCare1 = NSLayoutConstraint(item: imageView!, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
    let yPosition = imageView?.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: (imageView?.frame.height)!)
    let width = imageView?.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.33, constant: -50)
    let IDotCare2 = imageView?.widthAnchor.constraintEqualToAnchor(imageView?.heightAnchor)
    
    NSLayoutConstraint.activateConstraints([IDotCare1, IDotCare2!, yPosition!, width!])
    
    let animateView = UIView(frame: CGRect(x: 100, y: 100, width: 50,height: 50))
    animateView.backgroundColor = UIColor.grayColor()
    view.addSubview(animateView)
    
    let animate = CABasicAnimation(keyPath: "position.y")
    animate.setValue([1], forKey: "testValue")
    
    
//    let animate = CABasicAnimation(keyPath: "position.x")
//    animate.toValue = 500
//    animate.duration = 3
//    animate.beginTime = CACurrentMediaTime() + 0.4
//    animate.removedOnCompletion = false
//    animate.fillMode = kCAFillModeBoth
//    animateView.layer.addAnimation(animate, forKey: nil)
    
    view.layoutIfNeeded()
    
    UIView.animateWithDuration(1, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
      yPosition?.constant = -(self.view?.frame.size.height)! / 2
      width?.constant = 0
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  private func delay(delay:Double, closure:()->()) {
    dispatch_after(
      dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(delay * Double(NSEC_PER_SEC))
      ),
      dispatch_get_main_queue(), closure)
  }
  
}

extension TopicsViewController: UITableViewDataSource{
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return topics.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return topics[section].count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("topicCell", forIndexPath: indexPath) as! TopicCell
    cell.setData(topics[indexPath.section][indexPath.row])
    return cell
  }
  
}

extension TopicsViewController: UITableViewDelegate{
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let topic = topics[indexPath.section][indexPath.row]
    let topicDetailViewController = storyboard?.instantiateViewControllerWithIdentifier("TopicDetailViewControlller") as? TopicDetailViewController
  }
}
