function loadPlot(projectName) {
    Highcharts.ajax({
        url: '/events/project/' + projectName,
        success: function(data) {
            showPlot(data, projectName);
        }
    });
}

function showPlot(statistics, projectName) {
    const chart = Highcharts.chart('chartContainer', {
        chart: {
            zoomType: 'x'
        },
        title: {
            text: ''
        },
        xAxis: {
            type: 'datetime'
        },
        yAxis: {
            title: {
                text: 'Seconds'
            }
        },
        series: [{
            name: 'Average build time for ' + projectName,
            data: statistics.events.map(event => {
                return [event.startTime, event.duration];
            })
        }]
    });
}
