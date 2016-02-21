jQuery ->
  data = {
    labels : ["January","February","March","April"],
    datasets : [
      {
        fillColor : "rgba(151,187,205,0.5)",
        strokeColor : "rgba(151,187,205,1)",
        pointColor : "rgba(151,187,205,1)",
        pointStrokeColor : "#fff",
        data : [10000,11000,23000,12000]
      }
    ]
  }

  myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Line(data)