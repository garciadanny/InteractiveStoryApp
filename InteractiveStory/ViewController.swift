//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Danny Garcia on 11/11/16.
//  Copyright © 2016 Danny Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "startAdventure" {
      if let pageController = segue.destination as? PageController {
        pageController.page = Adventure.story
      }
    }
  }
}

