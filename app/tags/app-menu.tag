<app-menu>
    <!-- layout -->
    <nav>
        <div class="nav-wrapper">
            <a href="#" class="brand-logo left">Logo</a>
            <ul class="right">
                <li class={ active: isActive('/') }>
                    <a href="#">Home</a>
                </li>
                <li class={ active: isActive('/todo-list') }>
                    <a href="#todo-list">Todo List</a>
                </li>
                <li class={ active: isActive('/http') }>
                    <a href="#http">Http</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- script -->
    <script>
        import routes from '~/services/routes'

        this.routes = routes

        let currentPath

        routes.on('change-route', (path) => {
            console.log('change route', path)
            currentPath = path
            this.update()
        })

        isActive(path) {
            return currentPath == path
        }

    </script>

</app-menu>
