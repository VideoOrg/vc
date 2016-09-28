//
//  CameraController.swift
//  VC
//
//  Created by zhangyun on 2016/9/12.
//  Copyright © 2016年 zhangyun. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import AssetsLibrary

class CameraController: NSObject,AVCaptureFileOutputRecordingDelegate {
    
    var captureSession: AVCaptureSession!
    var imageOutput: AVCaptureStillImageOutput!
    var movieOutput: AVCaptureMovieFileOutput!
    var outputUrl: URL?
    var activeVideoInput: AVCaptureDeviceInput?
    
    var globalQueue = DispatchQueue(label:"cameraQueue",attributes:[])

//    var globalQueue = DispatchQueue(label: nil, attributes: [])
    
    override init() {
        super.init()
    }
    
    func setupSession() {
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        // set up  default camera device
        let videoDevice:AVCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput = try! AVCaptureDeviceInput(device: videoDevice)
        captureSession.addInput(videoInput)
        self.activeVideoInput = videoInput
        
        // set up default microphone 
        let audioDevice:AVCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
        
        do{
            let audioInput = try AVCaptureDeviceInput(device: audioDevice)
            captureSession.addInput(audioInput)
        }
        catch{
            return;
        }
        
        // set up still image output
        imageOutput = AVCaptureStillImageOutput()
        imageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
        
        if captureSession.canAddOutput(imageOutput) {
            captureSession.addOutput(imageOutput)
        }
        
        // set up movie output
        self.movieOutput = AVCaptureMovieFileOutput()
        if captureSession.canAddOutput(self.movieOutput) {
            captureSession.addOutput(self.movieOutput)
        }
    }
    
    
    func startSession() {
        if false == captureSession.isRunning {
            globalQueue.async(execute: { 
                self.captureSession.startRunning()
            })
        }
    }
    
    func stopSession() {
        if true ==  captureSession.isRunning{
            globalQueue.async(execute: { 
                self.captureSession.stopRunning()
            })
        }
    }
    
    // recording
    
    func isRecording() -> Bool {
        return self.movieOutput.isRecording
    }
    
    // current device orientation
    func currentVideoOrientation() -> AVCaptureVideoOrientation {
        
        var orientation: AVCaptureVideoOrientation
        switch UIDevice.current.orientation {
        case .portrait:
            orientation = .portrait
        case .landscapeRight:
            orientation = .landscapeLeft
        case .portraitUpsideDown:
            orientation = .portraitUpsideDown
        default:
            orientation = .landscapeRight
        }
        return orientation
    }
    
    // unique url
    func uniqueURL() -> URL {
        let curDateString = Date()
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale.current
        dateFormat.dateFormat = "HH:mm:ss-M-dd-yyyy"
        var stringDate = dateFormat.string(from: curDateString)
        stringDate.append(".mov")
        print(stringDate)
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let documentpath       = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).last
        let fileurl =  URL(fileURLWithPath: documentpath!).appendingPathComponent(stringDate)
        return fileurl
    }
    
    // del video at url
    func delVideoURL(fileUrl:URL) {
        do{
          try FileManager.default.removeItem(at: fileUrl)
          print("\(fileUrl)删除成功")
        }catch{
          print("\(fileUrl)删除失败")
        }
    }
    
    func stopRecording() {
        if isRecording() {
            self.movieOutput.stopRecording()
        }
    }
    
    func startRecording() {
        
        if false == isRecording() {
            let videoConnection = self.movieOutput.connection(withMediaType: AVMediaTypeVideo)
            
            if true == videoConnection?.isVideoOrientationSupported {
                videoConnection?.videoOrientation = currentVideoOrientation()
            }
            
            videoConnection?.preferredVideoStabilizationMode = .auto
            
            self.outputUrl = uniqueURL()
            self.movieOutput.startRecording(toOutputFileURL: self.outputUrl, recordingDelegate: self)
        }
    }
    
    //MARK: - delegate

    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        if (error != nil) {
            return
        }
        
        // compress video
        let asset = AVAsset(url: outputFileURL)
        let assetExportSession = AVAssetExportSession(asset: asset, presetName:AVAssetExportPresetMediumQuality)
        assetExportSession?.outputURL = self.uniqueURL()
         self.outputUrl = assetExportSession?.outputURL
        assetExportSession?.outputFileType = AVFileTypeQuickTimeMovie
        assetExportSession?.exportAsynchronously(completionHandler: {
            if assetExportSession?.status == .completed {
                print("compress completed!")
                // del old video
                self.delVideoURL(fileUrl: outputFileURL)
                // begin upload
                print("\(self.outputUrl) compressed video file url")
                self.uploadVideo(fileUrl: self.outputUrl!)
            }else{
                // show error tip
                self.delVideoURL(fileUrl: outputFileURL)
                print(" compress video failed\(assetExportSession?.error)")
            }
        })
    }
    
    // upload videl file to bmob
    func uploadVideo(fileUrl:URL) {
        
        let obj = BmobObject(className: "Movie")
        let  file = BmobFile(filePath: fileUrl.path)
        file?.saveInBackground { [weak file] (isSuccessful, error) in
            if isSuccessful {
                //如果文件保存成功，则把文件添加到file列
                let weakFile = file
                obj?.setObject(weakFile, forKey: "video")
                obj?.saveInBackground(resultBlock: { (success, err) in
                    if err != nil {
                        print("save \(error)")
                    }
                    
                    print(obj)
                    print(file)
                })
            }else{
                print("upload \(error)")
            }
        }
    }
    
    func writeVideoToAssetLibaray(fileUrl:URL) {
        let  file = BmobFile(filePath: self.outputUrl?.path);
        file?.saveInBackground(byDataSharding: { (isSuccesssful, error) in
            if isSuccesssful {
               self.generateThumbnailFromVideoUrl(video: fileUrl)
            }else{
                print("error \(error)")
            }
        })
    }
    
    // generate thumbnail
    func generateThumbnailFromVideoUrl(video:URL) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: video)
            let imageGenerate = AVAssetImageGenerator(asset: asset)
            imageGenerate.maximumSize = CGSize(width: 100, height: 0)
            imageGenerate.appliesPreferredTrackTransform = true
            do{
                let imageRef = try imageGenerate.copyCGImage(at: kCMTimeZero, actualTime: nil)
                let image = UIImage(cgImage: imageRef)
            }catch{
                return
            }
        }
    }
    
    // switch camera
    func switchCamera() {
        if false == self.canswitchCamera() {
           return
        }
        
        let inactiveDevice = self.inactiveCamera()
        
        let inactiveCaptureDeviceInput: AVCaptureDeviceInput? = try! AVCaptureDeviceInput(device: inactiveDevice)
        
        if inactiveCaptureDeviceInput == nil   {
            return
        }
        
        self.captureSession.beginConfiguration()
        self.captureSession.removeInput(self.activeVideoInput)
        if self.captureSession.canAddInput(inactiveCaptureDeviceInput) {
            self.captureSession.addInput(inactiveCaptureDeviceInput)
            self.activeVideoInput = inactiveCaptureDeviceInput
        }else{
           self.captureSession.addInput(self.activeVideoInput)
        }
        self.captureSession.commitConfiguration()
    }
    
    func inactiveCamera() -> AVCaptureDevice? {
        
        var camera: AVCaptureDevice?
        if canswitchCamera() {
            if self.activeVideoInput?.device.position == .back {
                camera = self.cameraWithPoistion(position: .front)
            }else{
                camera = self.cameraWithPoistion(position: .back)
            }
        }
        return camera
    }
    
    func cameraWithPoistion(position:AVCaptureDevicePosition) -> AVCaptureDevice? {
        let cameras: NSArray = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as NSArray
        for device  in cameras {
           let model =  device as! AVCaptureDevice
            if model.position == position {
               return model
            }
        }
        return nil
    }
    
    func canswitchCamera() -> Bool {
        if self.cameraCount() > 1 {
            return true
        }else{
            return false
        }
    }
    
    func cameraCount() -> NSInteger {
        return AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo).count
    }

}
