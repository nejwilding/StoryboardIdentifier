//: Playground - noun: a place where people can play

import UIKit

// MARK: - Storyboard Identifier

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(self)
    }
}

// MARK: - UIViewController Extension

extension UIViewController: StoryboardIdentifiable { }

extension UIStoryboard {
    
    enum Storyboard: String {
        case Main
    }
    
    convenience init(storyboard: Storyboard, bundle: NSBundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController where T: StoryboardIdentifiable>(_: T.Type) -> T {
        
        let optionalViewController = self.instantiateViewControllerWithIdentifier(T.storyboardIdentifier)
        
        guard let viewController = optionalViewController as? T else {
            fatalError("Could not instantiate viewcontroller with Storyboard Identifier \(T.storyboardIdentifier)")
        }
        
        return viewController
        
    }
    
}

// MARK: - Possible usage

class TestViewController: UIViewController { }

let identifier = TestViewController.storyboardIdentifier

class OpenViewContoller: UIViewController {
    
    func open() {
        
        let storyboard = UIStoryboard(storyboard: .Main)
        let viewController = storyboard.instantiateViewController(TestViewController.self)
        self.presentViewController(viewController, animated: true, completion: nil)
    }

}







