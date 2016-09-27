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
        dateFormat.dateFormat = "HH:mm:ss-E-M-dd-zzz-GGG"
        let stringDate = dateFormat.string(from: curDateString)
        print(stringDate)
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let documentpath       = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).last
        let fileurl =  URL(fileURLWithPath: documentpath!).appendingPathComponent("wc.mov")
        return fileurl
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
    
    
    //MARK: - delegate

    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        if (error != nil) {
            return
        }
        
        writeVideoToAssetLibaray(fileUrl: self.outputUrl!)

    }

    func writeVideoToAssetLibaray(fileUrl:URL) {
       
        let  file = BmobFile(filePath: self.outputUrl?.path);
        
        file?.saveInBackground(byDataSharding: { (isSuccesssful, error) in
            
            if isSuccesssful {
               
                
            }else{
                print("error \(error)")
            }
            
            
        })
        
        
    }
}
