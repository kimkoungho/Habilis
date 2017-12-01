function NumKey(){
	
	if(event.ctrlKey || event.shiftKey || event.altKey){
		event.returnValue=false;
		return false;
	}
	
	if( (event.keyCode==8 || event.keyCode==9 || event.keyCode==35 || event.keyCode==36 || event.keyCode==37 ||
			event.keyCode==39 || event.keyCode==45 || event.keyCode==46 || 
			(event.keyCode>=48 && event.keyCode<=57) || 
			(event.keyCode>=96 && event.keyCode<=105))){
		
		event.returnValue=true;
		return true;
	}
	else{
		event.returnValue=false;
		return false;
	}
	
}
