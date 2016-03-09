//
//  ContainerViewController.swift
//  GeekParkTopicsReader
//
//  Created by 朱坤 on 3/8/16.
//  Copyright © 2016 Zkuns. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  var menuController: UIViewController?
  var topicsController: UIViewController?
  var topicDetailController: UIViewController?
  var num = 1
  var controllers = [UIViewController?]()
  @IBOutlet weak var containerView: UIView!
  var panGesture: UIPanGestureRecognizer?
  override func viewDidLoad() {
    super.viewDidLoad()
    addPanGesture()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    loadController()
    addPositon()
    
//    addController("MenuController")
//    menuController = controllers[0]
//    
//    var transform = CATransform3DIdentity
//    transform.m34 = -1.0/500
//    containerView.layer.sublayerTransform = transform
//    
//    var transform0 = CATransform3DMakeTranslation(-containerView.frame.width/2, 0, 0)
//        transform0 = CATransform3DRotate(transform0, -CGFloat(M_PI_2), 0, 1, 0)
//    
//    let transform1 = CATransform3DMakeTranslation(0, 0, 0)
//    
//    var transform2 = CATransform3DMakeTranslation(0, 0, 0)
//        transform2 = CATransform3DRotate(transform2, CGFloat(M_PI_2), 0, 1, 0)
//    
//    menuController?.view.layer.transform = transform0
//    containerView.layer.doubleSided = false
//    
//
//    UIView.animateWithDuration(0.3, animations: {
//      let angle = M_PI_4
//      self.containerView.layer.sublayerTransform = CATransform3DRotate(self.containerView.layer.sublayerTransform, CGFloat(angle), 0, 1, 0)
//    })
//    print(menuController?.view.frame)
  }
  
  
  
  private func addPanGesture(){
    panGesture = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
    containerView.addGestureRecognizer(panGesture!)
  }
  
  private func addController(controllerIdentifier: String){
    let viewController = storyboard?.instantiateViewControllerWithIdentifier(controllerIdentifier)
    guard let controller = viewController else { return }
    self.containerView.addSubview(controller.view)
    self.addChildViewController(controller)
    controller.view.frame = CGRect(origin: containerView.frame.origin, size: CGSize(width: containerView.bounds.width, height: containerView.bounds.height))
//    controller.view.frame = CGRect(origin: containerView.center, size: CGSize(width: 100, height: 100))
    print("width is \(containerView.bounds.width), height is \(containerView.bounds.height)")
    controller.didMoveToParentViewController(self)
    controllers.append(controller)
  }
  
  private func loadController(){
    for controllerName in ["MenuController", "TopicsController", "TopicDetailController"]{
      addController(controllerName)
    }
    menuController = controllers[0]
    topicsController = controllers[1]
    topicDetailController = controllers[2]
  }
  
  private func addPositon(){
    
    var transform = CATransform3DMakeTranslation(0, 0, 0)
    transform.m34 = -1.0/500
    containerView.layer.sublayerTransform = transform
    
    var transform0 = CATransform3DMakeTranslation(-containerView.frame.width/2, 0, 0)
        transform0 = CATransform3DRotate(transform0, -CGFloat(M_PI_2), 0, 1, 0)

    let transform1 = CATransform3DMakeTranslation(0, 0, 0)

    var transform2 = CATransform3DMakeTranslation(containerView.frame.width/2, 0, 0)
        transform2 = CATransform3DRotate(transform2, CGFloat(M_PI_2), 0, 1, 0)
    
    [transform0, transform1, transform2].enumerate().map{ index, transform in
      controllers[index]?.view.layer.transform = transform
    }
  }
}

extension ContainerViewController: UIGestureRecognizerDelegate{
  func handlePanGesture(recognizer: UIPanGestureRecognizer){
    let moveX = recognizer.velocityInView(view).x
    guard moveX > 100 else { return }
    if moveX > 0{
      moveController(true)
    } else {
      moveController(false)
    }
    switch recognizer.state{
    default: break;
    }
  }
  
  private func moveController(clockwise: Bool){
    UIView.animateWithDuration(0.5, animations: {
      let angle = M_PI_2 * (clockwise ? 1 : -1)
      self.containerView.layer.transform = CATransform3DMakeRotation(CGFloat(angle), 0, 1, 0)
    })
  }
}
