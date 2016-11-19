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
    view.backgroundColor = .white
    
    if let page = page {
      artwork.image = page.story.artwork
      let attributedString = NSMutableAttributedString(string: page.story.text)
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.lineSpacing = 10
      
      attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
      
      storyLabel.attributedText = attributedString
      
      if let firstChoice = page.firstChoice {
        firstChoiceButton.setTitle(firstChoice.title, for: .normal)
        firstChoiceButton.addTarget(
          self,
          action: #selector(PageController.loadFirstChoice), for: .touchUpInside
        )
      } else {
        firstChoiceButton.setTitle("Play Again", for: .normal)
        firstChoiceButton.addTarget(
          self,
          action: #selector(PageController.playAgain), for: .touchUpInside
        )
      }
      
      if let secondChoice = page.secondChoice {
        secondChoiceButton.setTitle(secondChoice.title, for: .normal)
        secondChoiceButton.addTarget(
          self,
          action: #selector(PageController.loadSecondChoice), for: .touchUpInside
        )
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
  
  /*
   loadFirstChoice() and loadSecondChoice() can be converted into one method that takes a param.
   The reason we can't dry up this code at the moment is bc
   When we first connected a button to our app in our very first iPhone app course,
   we learned about the target action pattern.
   Remember, we control dragged from the button to create an IB action.
   We can't do that here, the control dragging part but we're still going to use 
   the target action method. Now the action part of the target action is an 
   Objective C pattern. In target action you specify a method you want to call as an action
   using what is known as a selector. A selector is a connection or pointer to a method.
   Now on the button, our firstChoice button doesn't actually know what method it's
   going to run until you actually tap it. It just knows the name of a particular method.
   So let's say the firstChoice button knows about loadFirstChoice, the name that is.
   When we tap it it looks up the name, finds the body of this function, and then executes it.
   The hard part is since we're using a name, you can't pass any arguments when 
   the method is called using the selector.
   The only thing we can specify is who the sender is. 
   We can technically get this done with one method but right now with the 
   knowledge that we know it's a bit simpler here to split the logic into two different methods.
  */
  
  func loadFirstChoice() {
    if let page = page, let firstChoice = page.firstChoice {
      let nextPage = firstChoice.page
      let pageController = PageController(page: nextPage)
      
      navigationController?.pushViewController(pageController, animated: true)
    }
  }
  
  func loadSecondChoice() {
    if let page = page, let secondChoice = page.secondChoice {
      let nextPage = secondChoice.page
      let pageController = PageController(page: nextPage)
      
      navigationController?.pushViewController(pageController, animated: true)
    }
  }
  
  func playAgain() {
    navigationController?.popToRootViewController(animated: true)
  }
}
