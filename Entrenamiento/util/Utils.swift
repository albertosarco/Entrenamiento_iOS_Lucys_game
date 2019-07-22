//
//  Utils.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 20/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation
import UIKit

public class Utils {
    
    fileprivate static var imagesNotDownloaded: NSMutableOrderedSet = []
    fileprivate static var dispatchWorkItemToReloadImagesNotDownloaded: DispatchWorkItem!
    
    public static func getString(_ resourceKey: ResourceStringKey, _ args: CVarArg...) -> String {
        if let value = Bundle.main.object(forInfoDictionaryKey: resourceKey.key) as? String {
            return String(format: value, locale: Locale.current, arguments: args)
        }
        return String(format: NSLocalizedString(resourceKey.key, comment: ""),
                      locale: Locale.current, arguments: args)
    }
    
    public static func loadImageByFileURL(_ fileName: String!, _ fileUrl: String!, _ imageView: UIImageView) {
        if (!TextUtils.isEmpty(fileName) && !TextUtils.isEmpty(fileUrl)) {
            if let imageFromFile = getFileInDirByFileName(fileName) {
                imageView.accessibilityIdentifier = nil
                imageView.accessibilityValue = nil
                imageView.image = imageFromFile
                //si consigue cargar la imagen entonces no continua con el codigo
                return
            }
            
            imageView.accessibilityIdentifier = nil
            imageView.accessibilityValue = nil
            imageView.image = getLoadingImageUIImage()
            
            //si no se consigue cargar la imagen con el archivo fisico entonces se procede a buscarla en la nube
            guard let url = URL(string: fileUrl) else {
                imageView.accessibilityIdentifier = nil
                imageView.accessibilityValue = nil
                imageView.image = getNoImageAvailableUIImage()
                return
            }
            
            imageView.accessibilityIdentifier = fileName
            imageView.accessibilityValue = url.absoluteString
            
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 15.0
            sessionConfig.timeoutIntervalForResource = 20.0
            URLSession(configuration: sessionConfig).dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let imageFromServlet = UIImage(data: data)
                    else {
                        // si el error es de memoria insuficiente se programa una nueva descarga en 10s
                        if let errorLocalizedDescription = error?.localizedDescription,
                            errorLocalizedDescription.elementsEqual("The operation couldn’t be completed. No space left on device") {
                            //si ya hay una descarga previa programada se cancela
                            if dispatchWorkItemToReloadImagesNotDownloaded != nil {
                                dispatchWorkItemToReloadImagesNotDownloaded.cancel()
                                dispatchWorkItemToReloadImagesNotDownloaded = nil
                            }
                            dispatchWorkItemToReloadImagesNotDownloaded = DispatchWorkItem {
                                reloadImagesNotDownloaded()
                            }
                            // se programa la nueva descarga para luego de 10s
                            DispatchQueue.global(qos: .background)
                                .asyncAfter(deadline: .now() +  10, execute: dispatchWorkItemToReloadImagesNotDownloaded)
                        }
                        if (imageView.accessibilityValue == url.absoluteString) {
                            imagesNotDownloaded.add(imageView)
                            DispatchQueue.main.async() {
                                imageView.image = getNoImageAvailableUIImage()
                            }
                        }
                        return
                }
                
                if let fileName = imageView.accessibilityIdentifier,
                    imageView.accessibilityValue == url.absoluteString {
                    self.imagesNotDownloaded.remove(imageView)
                    DispatchQueue.main.async() {
                        imageView.image = imageFromServlet
                    }
                    createFileInDir(fileName, imageFromServlet)
                }
                }.resume()
        } else {
            imageView.accessibilityIdentifier = nil
            imageView.accessibilityValue = nil
            imageView.image = getNoImageAvailableUIImage()
        }
    }
    
    fileprivate static func getFileInDirByFileName(_ fileName: String!) -> UIImage! {
        if (TextUtils.isEmpty(fileName)) {
            return nil
        }
        return UIImage(contentsOfFile: getImagesFolderPath().appendingPathComponent(fileName).path)
    }
    
    fileprivate static func getLoadingImageUIImage() -> UIImage! {
        return #imageLiteral(resourceName: "loading_image")
    }
    
    fileprivate static func getNoImageAvailableUIImage() -> UIImage! {
        return #imageLiteral(resourceName: "no_image_available")
    }
    
    public static func reloadImagesNotDownloaded() {
        for imageNotDownloaded in imagesNotDownloaded {
            if let imageView = imageNotDownloaded as? UIImageView {
                DispatchQueue.main.async() {
                    loadImageByFileURL(imageView.accessibilityIdentifier, imageView.accessibilityValue, imageView)
                }
            }
        }
    }
    
    fileprivate static func createFileInDir(_ fileName: String, _ image: UIImage) {
        DispatchQueue.global(qos: .background).async(execute: {
            if let data = fileName.contains(".png") ? image.pngData()
                : image.jpegData(compressionQuality: 1) {
                try? data.write(to: getImagesFolderPath().appendingPathComponent(fileName))
            }
        })
    }
    
    fileprivate static var imagesFolderPath: URL!
    fileprivate static func getImagesFolderPath() -> URL! {
        if (imagesFolderPath == nil) {
            imagesFolderPath = getDocumentsDirectory("images/")
        }
        return imagesFolderPath
    }
    
    fileprivate static func getDocumentsDirectory(_ pathComponent: String ) -> URL! {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = paths[0].appendingPathComponent(pathComponent, isDirectory: true)
        do {
            try createDirectoryIfNotExists(path)
            return path
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    fileprivate static func createDirectoryIfNotExists(_ urlPath: URL) throws {
        let fileManager = FileManager.default
        var isDir : ObjCBool = false
        if fileManager.fileExists (atPath: urlPath.path, isDirectory: &isDir) {
            if !isDir.boolValue {
                throw Utils.getImagesFolderPath().path + " exists and is not a directory"
            }
        } else {
            try fileManager.createDirectory(atPath: urlPath.path,
                                            withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    public static func consumeWebService(_ urlString: String) throws -> Data {
        let connectionTimeOutInSeconds: Double = 60
        
        var request = URLRequest(url: URL(string: Utils.getString(R.string.server_url, urlString))!)
        request.timeoutInterval = connectionTimeOutInSeconds
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = "POST"
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = connectionTimeOutInSeconds
        sessionConfig.timeoutIntervalForResource = connectionTimeOutInSeconds
        let (data, response) = try URLSession(configuration: sessionConfig).synchronousDataTask(with: request)
        
        //se verifica el estatus de la respuesta
        if (response?.statusCode != 200) {
            if (response?.statusCode == 401) { //HTTP_UNAUTHORIZED
                throw String(data: data!, encoding: String.Encoding.utf8) ?? ""
            } else if (response?.statusCode == 404) { //
                throw "server not found"
            } else {
                throw String(data: data!, encoding: String.Encoding.utf8) ?? ""
            }
        }
        return data!
    }
    
    static func deleteImagesFolder() -> Bool {
        return clearTempFolder(getImagesFolderPath())
    }
    
    static func clearTempFolder(_ url: URL!) -> Bool {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: url.path)
            return true
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        return false
    }
}

