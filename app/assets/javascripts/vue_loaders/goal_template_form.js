LearnSched.VueLoaders.GoalTemplateForm = function(element) {
    window.vueI = new Vue({
        el: element,
        data: {
            errors: [],
            name: '',
            public: false,
            levels: []
        },

        methods: {
            addLevel: function() {
                this.levels.push({
                    id: new Date().valueOf(),
                    name: 'Level name ...',
                    persisted: false,
                    editing: false,
                    tasks: []
                })
            },
            removeLevel: function(level) {
                index = this.levels.indexOf(level);
                this.levels.splice(index, 1);
            },
            editLevelName: function(level) {
                level.editing = true;
                self = this;
                Vue.nextTick(function () {
                    self.$refs['level_name_' + level.id][0].focus();
                });
            },
            stopEditingLevelName: function(level){
                if(level.name == '') {
                    level.name = 'Level name ...';
                }
                level.editing = false;
            },

            addTask: function(level) {
                level.tasks.push({
                    id: new Date().valueOf(),
                    persisted: false,
                    name: 'Task name ... ',
                    description: 'Description',
                    resources: 'Resources',
                    estimated_time: null,
                    editing: false
                })
            },

            removeTask: function(task, level) {
                index = level.tasks.indexOf(task);
                level.tasks.splice(index, 1);
            },

            editTask: function(task, level) {
                task.editing = !task.editing;
            },
            stopEditingTaskName: function(level){
                if(level.name == '') {
                    level.name = 'Task name ...';
                }
                level.editing = false;
            },

            submitForm: function () {
                params = {
                    name: this.name,
                    public: this.public,
                    levels: this.levels.map(function (l) {
                        level = {name: l.name};
                        if (l.persisted) level.id = l.id;
                        level.tasks = l.tasks.map(function (t) {
                            task = {
                                name: t.name,
                                description: t.description,
                                resources: t.resources,
                                estimated_time: t.estimated_time
                            };
                            if (t.persisted) task.id = t.id;
                            return task;
                        });

                        return level;
                    })
                };

                settings = {
                    data: {goal_template_form: params},
                    method: $(this.$el).data('method')
                };

                $.ajax($(this.$el).data('url'), settings).done(function (json) {
                    if(json.errors) this.errors = json.errors;
                    if(json.redirect_to) Turbolinks.visit(json.redirect_to);
                }.bind(this)).fail(function (result) {
                    this.errors = ["Internal server error"];
                }.bind(this));

            },

            updateDescription: function() {
                console.log(this);
            }
        }, /* methods: */
        mounted: function () {
            prepopulateData = $(this.$el).data('pre');
            if(prepopulateData) {
                this.name = prepopulateData.name;
                this.public = prepopulateData.public;

                this.levels = [];
                self = this;
                $.each(prepopulateData.levels, function(_, level){
                    l = { id: level.id, name: level.name, tasks: [], editing: false, persisted: true };
                    $.each(level.tasks, function(_, task) {
                        t = { id: task.id, name: task.name, editing: false, persisted: true, description: task.description, resources: task.resources, estimated_time: task.estimated_time };
                        l.tasks.push(t);
                    })
                    self.levels.push(l);
                });
            }
        }

    });
};