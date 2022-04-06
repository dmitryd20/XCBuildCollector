function loadPlot(period) {
    Highcharts.ajax({
        url: '/users/average/' + convertToParameter(period),
        success: function(data) {
            showPlot(data, period);
        }
    });
}

function showPlot(statistics, period) {
    const chart = Highcharts.chart('chartContainer', {
        chart: {
            type: 'bar'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: statistics.buildTimes.map(item => {
                return item.email;
            })
        },
        yAxis: {
            title: {
                text: 'Seconds'
            }
        },
        series: [{
            name: 'Average build time for ' + period,
            data: statistics.buildTimes.map(item => {
                return item.averageBuildTime;
            })
        }]
    });
}
