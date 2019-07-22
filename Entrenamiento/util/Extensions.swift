//
//  Extensions.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 21/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

extension UIColor {
    convenience init(_ red: Int, _ green: Int, _ blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(_ rgb: Int) {
        self.init((rgb >> 16) & 0xFF, (rgb >> 8) & 0xFF, rgb & 0xFF)
    }
    
    convenience init(_ color: ResourceIntKey) {
        self.init((color.key >> 16) & 0xFF, (color.key >> 8) & 0xFF, color.key & 0xFF)
    }
    
    convenience init(_ resourceKey: ResourceStringKey) {
        if let value = Bundle.main.object(forInfoDictionaryKey: resourceKey.key) as? String,
            let color = Int(value.hasPrefix("0x") ? String(value.dropFirst(2)) : value, radix: 16) {
            self.init((color >> 16) & 0xFF, (color >> 8) & 0xFF, color & 0xFF)
        } else {
            self.init((0 >> 16) & 0xFF, (0 >> 8) & 0xFF, 0 & 0xFF)
        }
    }
}

extension UIViewController {
    func setTitle(_ title: String, _ subtitle: String) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = R.color.textColorPrimary
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = R.color.textColorPrimary
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        
        if widthDiff < 0 {
            subtitleLabel.frame.origin.x = abs(widthDiff / 2)
        } else {
            titleLabel.frame.origin.x = widthDiff / 2
        }
        
        self.navigationItem.titleView = titleView
    }
    
    func removeBackButtonText() {
        if #available(iOS 10.0, *) {
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        } else {
            self.navigationItem.leftItemsSupplementBackButton = true
            self.navigationController?.navigationBar.topItem?.title = ""
        }
    }
}

extension UIView {
    func addShape() -> Void {
        //border
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.9
        self.layer.borderColor = R.color.grey_medium.cgColor
    }
}

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func removeEmptyMessage() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    func removeEmptyMessage() {
        self.backgroundView = nil
    }
}

extension UIBarButtonItem {
    var isHidden: Bool {
        get {
            return !isEnabled && tintColor == .clear
        }
        set {
            tintColor = newValue ? .clear : nil
            isEnabled = !newValue
        }
    }
}

extension URLSession {
    
    func synchronousDataTask(with request: URLRequest) throws -> (data: Data?, response: HTTPURLResponse?) {
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var responseData: Data?
        var theResponse: URLResponse?
        var theError: Error?
        
        dataTask(with: request) { (data, response, error) -> Void in
            
            responseData = data
            theResponse = response
            theError = error
            
            semaphore.signal()
            
            }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        if let error = theError {
            throw error
        }
        
        return (data: responseData, response: theResponse as! HTTPURLResponse?)
    }
}
