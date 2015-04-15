#EttFrameWork

####使用方法

EttFrameWork文件夹 添加到项目中

在项目中 `#import "EttFrameWork.h"` 


####项目模块划分

* Common----------公共类  
    * Category--类目    
    * Utils-------公共类     
    * 项目的宏    
* DB----------------数据库操作类  
* Model------------实体类
* Net---------------网络操作类  
* OtherLib----------第三方类库 （pod无法引用的或者需要改源码的第三方类） 
* OurLib------------自己封装的组件 
* Value    -------------项目常量  
* VC----------------项目ViewController  


模块对外提供一个头文件，在pch中只引用模块的头文件，或者某些地方单独引用