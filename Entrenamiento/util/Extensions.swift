//
//  Extensions.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 21/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation
import UIKit

//extension String {
//    var linesArray:[String?] {
//        var result: [String?] = []
//        enumerateLines { (line, _) -> () in
//            result.append(line)
//        }
//        return result
//    }
//    
//    func trim() -> String {
//        return self.trimmingCharacters(in: .whitespacesAndNewlines)
//    }
//    
//    func equalsIgnoreCase(_ string: String) -> Bool {
//        return self.caseInsensitiveCompare(string) == ComparisonResult.orderedSame
//    }
//    
//    func replaceFirst(of string: String, with replacement: String) -> String {
//        guard let range = self.range(of: string) else { return self }
//        return replacingCharacters(in: range, with: replacement)
//    }
//    
//    var html2AttributedString: NSAttributedString? {
//        return Data(utf8).html2AttributedString
//    }
//    var html2String: String {
//        return html2AttributedString?.string ?? ""
//    }
//    
//    func replaceAll(_ of: String, _ with: String) -> String {
//        return self.replacingOccurrences(of: of, with: with)
//    }
//    
//    func split(_ separator: String) -> [String] {
//        return self.components(separatedBy: separator)
//    }
//    
//    func isNumber() -> Bool {
//        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
//    }
//    
//    func charAt(_ i: Int) -> Character {
//        return self[index(startIndex, offsetBy: i)]
//    }
//    
//    func substring(from: Int?, to: Int?) -> String {
//        if let start = from {
//            guard start < self.count else {
//                return ""
//            }
//        }
//        
//        if let end = to {
//            guard end >= 0 else {
//                return ""
//            }
//        }
//        
//        if let start = from, let end = to {
//            guard end - start >= 0 else {
//                return ""
//            }
//        }
//        
//        let startIndex: String.Index
//        if let start = from, start >= 0 {
//            startIndex = self.index(self.startIndex, offsetBy: start)
//        } else {
//            startIndex = self.startIndex
//        }
//        
//        let endIndex: String.Index
//        if let end = to, end >= 0, end < self.count {
//            endIndex = self.index(self.startIndex, offsetBy: end + 1)
//        } else {
//            endIndex = self.endIndex
//        }
//        
//        return String(self[startIndex ..< endIndex])
//    }
//    
//    func substring(from: Int) -> String {
//        return self.substring(from: from, to: nil)
//    }
//    
//    func substring(to: Int) -> String {
//        return self.substring(from: nil, to: to)
//    }
//    
//    func substring(from: Int?, length: Int) -> String {
//        guard length > 0 else {
//            return ""
//        }
//        
//        let end: Int
//        if let start = from, start > 0 {
//            end = start + length - 1
//        } else {
//            end = length - 1
//        }
//        
//        return self.substring(from: from, to: end)
//    }
//    
//    func substring(length: Int, to: Int?) -> String {
//        guard let end = to, end > 0, length > 0 else {
//            return ""
//        }
//        
//        let start: Int
//        if let end = to, end - length > 0 {
//            start = end - length + 1
//        } else {
//            start = 0
//        }
//        
//        return self.substring(from: start, to: to)
//    }
//    
//    func toDate(_ dateFormat: String) -> Date! {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = dateFormat //Your date format
//        dateFormatter.timeZone = TimeZone.current //Current time zone
//        return dateFormatter.date(from: self)
//    }
//    
//    func indexOf(_ str: String) -> Int {
//        if (self.count == 0 && str.count == 0) {
//            return 0
//        } else if (self.count == 0 || str.count == 0) {
//            return -1
//        }
//        
//        let patternLetters: [String] = str.map(String.init)
//        
//        let sourceLetters: [String] = self.map(String.init)
//        var sourceIndex: Int = 0
//        // se itera a traves del string fuente
//        while (sourceIndex < sourceLetters.endIndex) {
//            //se verifica si la primera letra del patron de busqueda es igual a la letra actual del string fuente
//            if (sourceLetters[sourceIndex] == patternLetters[0]) {
//                
//                //si el patron de busqueda tiene una sola letra entonces se devuelve el indice conseguido
//                if (str.count == 1) {
//                    return sourceIndex
//                }
//                
//                // se guarda el indice de la primera incidencia de la primera letra del patron de busqueda respecto a la fuente
//                let index = sourceIndex
//                
//                //se adelanta en una posicion el indice del arreglo fuente y del arreglo patron
//                var patternIndex: Int = 1
//                sourceIndex += 1
//                
//                //se verifica si las siguientes letras son iguales uno a uno
//                while (patternIndex < patternLetters.endIndex &&
//                    sourceIndex < sourceLetters.endIndex &&
//                    sourceLetters[sourceIndex] == patternLetters[patternIndex]) {
//                        
//                        patternIndex += 1
//                        sourceIndex += 1
//                }
//                
//                //si al finalizar la comparacion letra a letra se consigue que se pudo llegar al final del arreglo patron de busqueda
//                //significa que se consiguio el string completo, entonces se devuelve el indice de la primera letra conseguida del patron de
//                //busqueda respecto a la fuente
//                if (patternIndex == (patternLetters.endIndex)) {
//                    return index
//                }
//            }
//            sourceIndex += 1
//        }
//        
//        return -1
//    }
//    
//    var condensedWhitespace: String {
//        let components = self.components(separatedBy: .whitespacesAndNewlines)
//        return components.filter { !$0.isEmpty }.joined(separator: " ")
//    }
//}


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

extension Character {
    var asciiValue: Int {
        get {
            let s = String(self).unicodeScalars
            return Int(s[s.startIndex].value)
        }
    }
}

extension Float {
    var stringFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self))!
    }
    
    func round(to places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return Darwin.round(self * divisor) / divisor
    }
}

extension Double {
    var stringFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self))!
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
    
    func hideKeyboard() {
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(UIViewController.dismissKeyboard)))
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addNavBarImage() {
        if let logo = UIImage(named: "actionbar_logo") {
            let imageView = UIImageView(image: logo)
            imageView.contentMode = .scaleAspectFit
            navigationItem.titleView = imageView
        }
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

extension UISearchBar {
    public func addDoneButtonInKeyboard(_ viewController: UIViewController) {
        //init toolbar
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: viewController.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        toolbar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                          UIBarButtonItem(title: "Listo", style: .done, target: viewController,
                                          action: #selector(UIViewController.dismissKeyboard))], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        self.inputAccessoryView = toolbar
    }
}

extension UIImage {
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    static var appIcon: UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String:Any],
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String:Any],
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last else { return nil }
        return UIImage(named: lastIcon)
    }
    
    func resize (sizeChange: CGSize)-> UIImage{
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
}

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var identifier: String? {
        return infoDictionary?["CFBundleIdentifier"] as? String
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
    func addShadow() -> Void {
        // shadow
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 6.0
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

extension NSMutableAttributedString {
    func appendWithReturn(_ attrString: NSAttributedString) -> NSMutableAttributedString {
        self.append(attrString)
        return self
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
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
