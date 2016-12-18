<app-main>

    <!-- layout -->
    <h1 style="text-align: center;"> { title } </h1>
    <div id="container"></div>

    <!-- script -->
    <script>
        import route from 'riot-route'
        import routes from '~/services/routes'

        let currentTagName

        let mountTag = (tagname) => {
            if(currentTagName && currentTagName == tagname)
                return;

            let tagElm = document.createElement(tagname)

            document.querySelector('div#container').innerHTML = ''
            document.querySelector('div#container').appendChild(tagElm)

            let tagInst = riot.mount(tagElm, tagname)[0]

            routes.trigger(
                'change-route',
                '/' + window.location.hash.replace('#', ''),
                { name: tagname, instance: tagInst }
            )

            currentTagName = tagname
        }

        this.on('mount', () => {
            route.base('#')

            routes.forEach((r) => {
                console.log('create route', r.path)
                route(r.rule || r.path, () => {
                    this.title = r.title
                    mountTag(r.tagname)
                    this.update()
                })
            })

            route.start(true)
        })
    </script>
</app-main>
