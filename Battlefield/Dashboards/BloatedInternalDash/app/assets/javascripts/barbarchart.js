ctx.canvas.originalwidth = ctx.canvas.width;
ctx.canvas.originalheight = ctx.canvas.height;

function drawchart() {
    ctx.canvas.width = ctx.canvas.originalwidth;
    ctx.canvas.height = ctx.canvas.originalheight;

    var chartctx = new Chart(ctx);
    myNewBarChart = chartctx.Bar(data, chartSettings);
}