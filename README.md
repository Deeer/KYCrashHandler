# KYCrashHandler

## Ability 

- Catch Crash
- Generate Crash file & Save it locally
- Provide interface for uploading Crash file 
- Provide interface for handling the instant crash

a simple and lightweight way to hanle the crash event ✈️ :]

## Demo

![effert](https://github.com/Deeer/KYCrashHandler/blob/master/images/p.gif)

## Some Logic 

![logic](https://github.com/Deeer/KYCrashHandler/blob/master/images/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-12-05%20%E4%B8%8B%E5%8D%887.54.45.png)

## Installation

 To integrate it into your project using CocoaPods,specify it in your `Podfile`
 
 ```
  pod 'KYCrashHandler'
 ```

Then,run the following command:

```
pod install
```

## Architecture

```
.
├── Category
│   ├── NSDate+TimeTool.h
│   └── NSDate+TimeTool.m
├── CrashHandler
│   ├── KYExceptionHandler.h
│   ├── KYExceptionHandler.m
│   ├── KYSignalHandler.h
│   └── KYSignalHandler.m
├── CrashHandlerCore
│   ├── KYClassFinder.h
│   ├── UIApplication+FindRepairViewController.h
│   ├── UIApplication+FindRepairViewController.m
│   ├── UIApplication+KYCrashHandler.h
│   └── UIApplication+KYCrashHandler.m
├── Interfaces
│   ├── KYExtraInfoPlugin
│   │   ├── KYExtraInfoPlugin.h
│   │   └── KYExtraInfoPlugin.m
│   ├── RepairViewController
│   │   ├── KYCrashRepairViewController.h
│   │   └── KYCrashRepairViewController.m
│   └── Uploader
│       ├── KYCrashLogUploadOperation.h
│       ├── KYCrashUploader.h
│       └── KYCrashUploader.m
├── KYCrashBusinessHandler.h
├── KYCrashBusinessHandler.m
├── Lib
│   ├── Aspects.h
│   └── Aspects.m
└── Storeage
    ├── KYCrashLocalStorage.h
    ├── KYCrashLocalStorage.m
    ├── KYTimeRecorder.h
    └── KYTimeRecorder.m
```

## Usage

- 1.Inheritant form `KYCrashRepairViewController`,Then implement  `didFinishRepairWithCompletion:`, you could do something       to do with the crash event(try to reset your database or clean some dirty data,etc)
- 2.Inheritant form `KYCrashUploader` to handle upload businiess.

## TODO 
To be more **powerful** && more **resonable**
