let routes = [
    {
        path: '/',
        label: 'Home',
        title: 'My Home Page',
        tagname: 'page-home'
    },
    {
        path: '/todo-list',
        rule: '/todo-list..',
        label: 'Todo List',
        title: 'Todo List Page',
        tagname: 'page-todo-list'
    },
    {
        path: '/http',
        label: 'Http Request',
        title: 'Http Request Page',
        tagname: 'page-http'
    }
]

riot.observable(routes)

export default routes
