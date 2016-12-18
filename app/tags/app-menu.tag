<app-menu>
    <!-- layout -->
    <nav>
        <div class="nav-wrapper">
            <a href="#" class="brand-logo left">Logo</a>
            <ul class="right">
                <li each={ route in routes } class={ active: isActive(route.path) }>
                    <a href={ route.path.replace('/', '#') }>{ route.label }</a>
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
