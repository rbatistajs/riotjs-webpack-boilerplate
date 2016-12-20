import './styles/base.scss'

//libs
import './utils/riot-attribute'




// main
import './tags/app-menu.tag'
import './tags/app-main.tag'

// Pages
import './tags/page-home.tag'
import './tags/page-todo-list.tag'
import './tags/page-http.tag'

riot.mount('app-menu, app-main')
