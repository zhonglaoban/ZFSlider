# ZFSlider

这是一个自定义的进度条，最初是因为系统的slider无法自定义sliderbar的样式，所以自己写了一个，代码比较简单，可以随意搭配。

## Getting Started

接下来我会讲到如何运行这个项目，并且会截取一些图片展示，最后会讲一下实现的原理。

### Prerequisites

Xcode 9.0 or later; iOS 9.0 SDK or later

### Installing

首先从GitHub上克隆项目

```
git clone https://github.com/zhonglaoban/ZFSlider
```

然后打开ZFSlider.xcodeproj，如果你有开发者账号就可以在自己手机上运行啦。

## Running the Project

运行项目你会看到这个样子
<img src="https://github.com/zhonglaoban/ZFSlider/blob/master/Screenshots/screenshot1.png" width="200px" alt="截图1"/>

你可以按住滑块拖动控制进度，当然你也可以改变代码实现点击进度条控制进度

## 实现原理

简单的说一下实现原理吧

### 加载xib
通过Bundle加载xib文件，并把加载后的view添加到当前view上

### 进度控制
重写当前view的touches事件，根据手势计算出进度，并更新sliderbar的位置和slider进度view的宽度。

## Authors

* **zhong fan** - *Initial work* - [zhonglaoban](https://github.com/zhonglaoban)

## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details

## Acknowledgments

*Inspiration from UISlider


