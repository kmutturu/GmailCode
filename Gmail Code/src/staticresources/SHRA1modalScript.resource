/*
	Author		:	Shravan Bowrampet
	Created On	:	04/01/2010
*/
function showModal()
{
            var backDivHeight = $(document).height();
            var backDivWidth = $(window).width();
            
            $("#backgrounddiv").css({'width':backDivWidth,'height':backDivHeight});
            
            $("#backgrounddiv").fadeIn(100);
            $("#backgrounddiv").fadeTo("fast",0.2);
            
            var top = backDivHeight/3 - $("#testdiv").height()/2;
            var left = backDivWidth/2 - $("#testdiv").width()/2;
            //alert(top);
            
            $("#testdiv").css('top', top);
            $("#testdiv").css('left', left);
            
            $("#testdiv").fadeIn(200);
}
function hideModal()
{
            $("#backgrounddiv").hide();
            $("#testdiv").hide();
}