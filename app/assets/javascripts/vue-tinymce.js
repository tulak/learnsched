Vue.component('tinymce-textarea', {
    template: '<textarea></textarea>',

    props: ['value'],
    data: function() {
      return {
          content: ''
      }
    },

    mounted: function() {
        self = this;
        // $(this.$el).find().attr('id', this.value);

        Vue.nextTick(function() {
            ta = $(this.$el);
            console.log(this, 'NT');
            ta.summernote({
                callbacks: {
                    onChange: function() {
                        console.log(ta.val());
                    }
                }
            });
        }.bind(this));


        //
        // ta.summernote('editor.insertText', this.value);
        // $(this.$el).on('change', function() {
        //     console.log('change', self);
        // });

        // tinymce.init({
        //     target: self.$el,
        //     setup: function(editor) {
        //
        //         // when typing keyup event
        //         editor.on('keyup change', function() {
        //
        //             console.log('change mce', self.id, editor);
        //             // get new value
        //             var new_value = editor.getContent();
        //
        //             self.$emit('input', new_value);
        //         });
        //     }
        // });


        // var editor = new tinymce.Editor(this.$el, {}, tinymce.EditorManager);
        //
        // editor.on('keyup change', function() {
        //     var new_value = editor.getContent();
        //     self.$emit('input', new_value);
        // });
        //
        // editor.render();

        // editor.setContent(this.value);
    },

    methods: {
        changed: function() {
            console.log(this.content);
        }
    }
});