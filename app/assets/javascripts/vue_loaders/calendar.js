LearnSched.VueLoaders.Calendar= function(element) {

    $(element).fullCalendar({
        weekNumbers: true,
        firstDay: 1,
        height: window.innerHeight - 110,
        header: {
            left: 'today prev,next',
            center: 'title',
            right: 'month,basicWeek,agendaWeek'
        },
        windowResize: function (view) {
            $(this).fullCalendar('option', 'height', window.innerHeight - 110);
        },
        events: function (start, end, timezone, callback) {
            $.ajax({
                url: '/tasks.json',
                type: 'GET',
                data: {
                    start: start.format('YYYY-MM-DD'),
                    end: end.format('YYYY-MM-DD')
                },
                success: function (data) {
                    var events = [];
                    for (id in data) {
                        var item = data[id];
                        events.push({
                            title: item.task_name,
                            start: item.start,
                            end: item.end,
                            url: '/goals/' + item.goal_id + '/task/' + item.id
                        });
                    }
                    callback(events);
                }
            });
        }
    });
}