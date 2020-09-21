import UIKit

protocol Subscribeable {
    func receive(message: String)
}

protocol Publishable {
    func postNotification(message: String)
}


class CustomNotification {
    static let shared = CustomNotification()
    private init() {}
    
    private var subscribers = [String: [Subscribeable]]()
    
    public func subscribe(subscriber: Subscribeable, message: String) {
        if subscribers[message] == nil {
            subscribers[message] = []
        }
        subscribers[message]?.append(subscriber)
    }
    
    public func postNotification(message: String) {
        if let subscribersList = subscribers[message] {
            for subscriber in subscribersList {
                subscriber.receive(message: message)
            }
        }
    }
}

class ViewController: UIViewController, Publishable {
    func postNotification(message: String) {
        CustomNotification.shared.postNotification(message: message)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let a = A()
        postNotification(message: "View Loaded")
    }
}

class A: Subscribeable {
    
    init() {
        CustomNotification.shared.subscribe(subscriber: self, message: "View Loaded")
    }

    func receive(message: String) {
        print("Message received is \(message)")
    }
}

