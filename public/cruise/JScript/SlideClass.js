// JavaScript Document
function SlideClass(){
	this.floorIndex=8;//当前楼层序号
	this.BindingEvt()//绑定事件
	this.TheFrist();//默认显示
	this.TxtSh();//文字闪烁
}

//绑定事件
SlideClass.prototype.BindingEvt=function(){
	var TheObj=this;
	$("#TheSlideDiv .floor li em").mouseover(function(){
		TheObj.floorIndex=$("#TheSlideDiv .floor li em").index(this);
		TheObj.ShowOneFloor();
	});	
	
	$("#TheSlideDiv .ships_floor_num li").mouseover(function(){
		TheObj.floorIndex=$("#TheSlideDiv .ships_floor_num li").index(this);
		TheObj.ShowOneFloor();
	});
	
	$("#TheSlideDiv .ships_floor_jt li").mouseover(function(){
		var index=$("#TheSlideDiv .ships_floor_jt .onefloor:eq("+TheObj.floorIndex+") li").index(this);
		if(navigator.userAgent.indexOf("MSIE 7.") || navigator.userAgent.indexOf("MSIE 6.")){
			$("#TheSlideDiv .ships_floor_pic .onefloor:eq("+TheObj.floorIndex+") ul").stop().animate({marginLeft:(0-index*760)+"px"},500);
		}else{
			$("#TheSlideDiv .ships_floor_pic .onefloor:eq("+TheObj.floorIndex+")").stop().animate({scrollLeft:index*760},500);
		}
	});
}

//默认显示
SlideClass.prototype.TheFrist=function(){
	$("#TheSlideDiv .ships_floor_jt").scrollTop(1080);
	$("#TheSlideDiv .ships_floor_pic").scrollTop(2400);
	this.ShowOneFloor();	
}

//显示一层楼的信息
SlideClass.prototype.ShowOneFloor=function(){
	this.ShowOneFloorNum();
}

//显示一层楼的编号信息
SlideClass.prototype.ShowOneFloorNum=function(){
	//显示左边的楼层F
	var EmList=$("#TheSlideDiv .floor li em");
	for(var i=0;i<EmList.length;i++){
		if(i==this.floorIndex){
			EmList[i].className=EmList[i].className.replace("_on","")+"_on";
		}else{
			EmList[i].className=EmList[i].className.replace("_on","");
		}
	}
	//显示船上的楼号
	var LiList=$("#TheSlideDiv .ships_floor_num li");
	for(var i=0;i<LiList.length;i++){
		if(i==this.floorIndex){
			LiList[i].className=LiList[i].className.replace("_on","")+"_on";
		}else{
			LiList[i].className=LiList[i].className.replace("_on","");
		}
	}
	//显示船上的每层缩略图
	$("#TheSlideDiv .ships_floor li:eq("+this.floorIndex+")").show().siblings("li").hide();	
	
	//滚动到指定层的平面图
	$("#TheSlideDiv .ships_floor_jt").stop().animate({scrollTop:this.floorIndex*120},500);
	
	//滚动到指定层的图片列表
	$("#TheSlideDiv .ships_floor_pic").stop().animate({scrollTop:this.floorIndex*300},500);
}

//字闪烁
SlideClass.prototype.TxtSh=function(){
	var theObj=this;
	$("#TheSlideDiv .ships_floor_jt .list").animate({opacity:0.2},1000,function(){
		$("#TheSlideDiv .ships_floor_jt .list").animate({opacity:1},1000,function(){
			theObj.TxtSh();
		});
	});
}