import '~/tags/app-main.tag'

// Pages
import '~/tags/page-home.tag'
import '~/tags/page-todo-list.tag'
import '~/tags/page-http.tag'

const tagname = 'app-main'

describe(tagname + '.tag', () => {
    let tag, elm

    beforeEach(() => {
        elm = document.createElement(tagname)
        document.body.appendChild(elm)
    })

    it('mount app-main tag', () => {

        tag = riot.mount(tagname)
        expect(tag).to.exist
    })

})
