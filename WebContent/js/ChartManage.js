
$(document).ready(function(){
	var dount_ctx = document.getElementById("dount").getContext("2d");
    window.myDoughnut = new Chart(dount_ctx, doughnut_config);

    var radar_ctx = document.getElementById("radar").getContext("2d");
    window.myRadar = new Chart(radar_ctx, radar_config);
    
    var line_ctx = document.getElementById("line").getContext("2d");
    window.myLine = new Chart(line_ctx, line_config);
	
});
var radar_config = {
    type: 'radar',
    data: {
        labels: labels,
        datasets: radar_datasets
    },
    options: {
        legend: {
            display: false
        },
        title: {
            display: false
        },
        scale: {
	        ticks: {
	        	display:false,
	            beginAtZero: false
	        }
        }
    }
};
var doughnut_config = {
    type: 'doughnut',
    data: {
        datasets: [{
            data:doughnut_data ,
            backgroundColor: ["#5a9bd5", "#ed7d31", "#a5a5a5", "#ffc000", "#416fc5"],
            //label: 'Dataset 1'
        }],
        labels: labels
    },
    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        },
        title: {
            display: false,
        },
        animation: {
            animateScale: true,
            animateRotate: true
        }
    }
};

var line_config = {
    type: 'line',
    data: {
        datasets:line_datasets 
    },
    options: {
        responsive: true,
        title:{
            display:false
        },
        tooltips: {
            mode: 'index',
            intersect: false,
        },
        hover: {
            mode: 'nearest',
            intersect: true
        },
        scales: {
            xAxes: [{
            	type: 'time',
            	time: {
            		unit: unit_type,
            		unitStepSize:2,
            		tooltipFormat: format_type
            	},
            	ticks:{
            		max:3,
            		min:0,
            		stepSize: 0.5
            	},
                display: true
            }],
            yAxes: [{
                display: true
            }]
        }
    }
};