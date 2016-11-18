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
  
  let artwork = UIImageView()
  let storyLabel = UILabel()
  let firstChoiceButton = UIButton(type: .system)
  let secondChoiceButton = UIButton(type: .system)
  
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
      artwork.image = page.story.artwork
      let attributedString = NSMutableAttributedString(string: page.story.text)
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.lineSpacing = 10
      
      attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
      
      storyLabel.attributedText = attributedString
      
      if let firstChoice = page.firstChoice {
        firstChoiceButton.setTitle(firstChoice.title, for: .normal)
      } else {
        firstChoiceButton.setTitle("Play Again", for: .normal)
      }
      
      if let secondChoice = page.secondChoice {
        secondChoiceButton.setTitle(secondChoice.title, for: .normal)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillLayoutSubviews() {
    view.addSubview(artwork)
    // this is so that we don't inherit the contsraints from the main view
    artwork.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      artwork.topAnchor.constraint(equalTo: view.topAnchor),
      artwork.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      artwork.rightAnchor.constraint(equalTo: view.rightAnchor),
      artwork.leftAnchor.constraint(equalTo: view.leftAnchor)
    ])
    
    view.addSubview(storyLabel)
    storyLabel.translatesAutoresizingMaskIntoConstraints = false
    storyLabel.numberOfLines = 0
    
    NSLayoutConstraint.activate([
      storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
      storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
      storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0)
    ])
    
    view.addSubview(firstChoiceButton)
    firstChoiceButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0)
    ])
    
    view.addSubview(secondChoiceButton)
    secondChoiceButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
    ])
  }
}
