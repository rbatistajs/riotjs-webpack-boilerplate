<page-todo-list>

    <!-- layout -->
    <div class="row">
        <div class="col s12 m10 offset-m1">
            <div class="card-panel red lighten-2">

                <div class="input-field white-text">
                    <input ref="input" onkeyup={ add } placeholder="What needs to be done?">
                </div>

                <ul class="collection" if={ getList().length }>

                    <li
                        each={ item, index in getList() }
                        class="collection-item row { completed: item.completed }">
                        <todo-list-item item="{ item }" index="{ index }"/>
                    </li>

                </ul>

                <div class="row white-text" style="margin: 0;">
                    <div class="col s3">{ list.length } item{list.length > 1 ? 's': ''} left</div>
                    <div class="col s8 offset-s1">
                        <a href="#todo-list/all" class="btn-flat { active: filter == 'all' } white-text">All</a>
                        <a href="#todo-list/active" class="btn-flat { active: filter == 'active' } white-text">Active</a>
                        <a href="#todo-list/completed" class="btn-flat  { active: filter == 'completed' } white-text">Completed</a>
                    </div>

                </div>

            </div>
        </div>
    </div>

    <!-- script -->
    <script>
        import route from 'riot-route'

        this.filter = 'all'
        this.list = []

        this.on('mount', () => {
            let $route = route.create()

            $route((base, filter) => {
                this.filter = filter || 'all'
                this.update()
            })

            route.exec()
        })

        getList(){
            switch (this.filter) {
                case 'active':
                    return this.list.filter(o=>!o.completed)
                    break;
                case 'completed':
                    return this.list.filter(o=>o.completed)
                    break;
                default:
                    return this.list
            }
        }

        add(e){
            if (e.which === 13) { // enter key
                let input = this.refs.input
    			let value = input.value && input.value.trim()

    			if (!value) {
    				return
    			}

                this.list.push({ title: value, completed: false })
    			input.value = ''
    		}
        }

    </script>

    <!-- styles -->
    <style type="text/scss">
        :scope {

            li.collection-item  label{
                display: block;
            }

            li.completed {
                label {
                    color: #c3c3c3;
                    text-decoration: line-through;
                }
            }

            .item-title {
                width: calc(100% - 60px);
            }

            .item-actions {
                padding-left: 0;
                padding-right: 0;
                width: 60px;
                a {
                    transition: opacity 0.2s ease-in;
                    opacity: 0;
                    width: 25px;
                    height: 25px;
                    vertical-align: initial;
                    i {
                        line-height: 26px;
                        font-size: 16px;
                    }
                }
            }

            li.collection-item:hover .item-actions a {
                opacity: 1;
            }

            li.collection-item {
                padding-left: 10px;
                padding-right: 10px;
            }

            a.active {
                background-color: rgba(0,0,0,0.1);
                box-shadow: none;
            }
        }
    </style>

</page-todo-list>

<todo-list-item>

    <!-- layout -->
    <div class="col item-title">
        <span if={ !opts.item.edit }>
            <input
                type="checkbox"
                id={'item'+opts.index}
                onclick={ toggle }
                checked="{ opts.item.completed }"/>
            <label for={ 'item'+opts.index }>
                { opts.item.title }
            </label>
        </span>

        <span if={ opts.item.edit }>
            <div class="input-field">
                <input ref="input" onkeyup={ save } placeholder="What needs to be done?">
            </div>
        </span>
    </div>
    <div class="col item-actions" if={ !opts.item.edit }>
        <a class="btn-floating" onclick={ edit }>
            <i class="material-icons">&#xE254;</i>
        </a>
        <a class="btn-floating" onclick={ remove }>
            <i class="material-icons">&#xE872;</i>
        </a>
    </div>


    <!-- script -->
    <script>
        var parent = this.parent;

        toggle() {
            opts.item.completed = !opts.item.completed
            parent.update()
            return true
        }

        edit() {
            opts.item.edit = true
            parent.update()

            this.refs.input.value = opts.item.title
            this.refs.input.focus()
        }

        save(e) {
            if (e.which === 13) { // enter key
    			let value = this.refs.input.value && this.refs.input.value.trim()

    			if (!value) {
    				return
    			}

                opts.item.title = value
                delete opts.item.edit
    		}
        }

        remove() {
            let index = parent.list.indexOf(opts.item)
            parent.list.splice(index, 1)
            parent.update()
        }
    </script>

</todo-list-item>
