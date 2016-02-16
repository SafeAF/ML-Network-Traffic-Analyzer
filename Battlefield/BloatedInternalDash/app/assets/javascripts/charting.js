//Chart.defaults.global = {
//    animationSteps : 50,
//    tooltipYPadding : 16,
//    tooltipCornerRadius : 0,
//    tooltipTitleFontStyle : 'normal',
//    tooltipFillColor : 'rgba(0,160,0,0.8)',
//    animationEasing : 'easeOutBounce',
//    scaleLineColor : 'black',
//    scaleFontSize : 16
//}




var ctx = document.getElementById("canvas").getContext("2d");
ctx.canvas.width = 300;
ctx.canvas.height = 300;
var myDoughnut = new Chart(ctx).Doughnut(doughnutData);