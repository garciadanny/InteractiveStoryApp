//
//  PageController.swift
//  InteractiveStory
//
//  Created by Danny Garcia on 11/13/16.
//  Copyright © 2016 Danny Garcia. All rights reserved.
//

import UIKit

class PageController: UIViewController {
  
  var page: Page?
  
  required init?(coder aDecoder: NSCoder) {
    /*
     If we were always instantiaing the view controller in code instead
     of through the storyboard setup, we could have simply added
     fatalError("Init coder not implemented") instead of calling super
     because we know this init method wouldn't ever be called.
     http://stackoverflow.com/questions/30085264/why-use-required-initializers-in-swift-classes/30087117#30087117
    */
    super.init(coder: aDecoder)
  }
  
  init(page: Page) {
    self.page = page
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let page = page {
      print(page.story.text)
    }
    
    // Do any additional setup after loading the view.
    view.backgroundColor = .blue
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
