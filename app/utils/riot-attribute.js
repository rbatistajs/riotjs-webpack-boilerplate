let attrs = []
let chacheMount = riot.mount
let nextId = 0

const getAttr = (attrName) => {
    let attr = attrs.filter(a=>a.name == attrName)
    return attr && attr[0] ? attr[0] : null
}

const searchAttr = (dom, attrName) => {
    let elms = []

    if(dom.getAttribute && dom.getAttribute(attrName) != null)
        elements.push(dom)

    elms = elms.concat(
        Array.prototype.slice.call(dom.querySelectorAll(`[${attrName}]`))
    )

    return elms;
}


riot.mount = function() {

    let elms;

    if(riot.util.check.isString(arguments[0]))
        elms = Array.prototype.slice.call(document.querySelectorAll(arguments[0]))
    else
        elms = [document.createElement(arguments[1])]

    var implTags = elms.map(el=>riot.util.tags.getTag(el))

    attrs.forEach((attr) => {

        implTags.forEach((impl) => {

            let parseDom = document.createElement('div')
            parseDom.innerHTML = impl.tmpl

            searchAttr(parseDom, attr.name).forEach((dom) => {

                let exp = dom.getAttribute(attr.name)

                nextId++;
                let ref = dom.getAttribute('ref') || `${attr.name}-${nextId}`
                dom.setAttribute('ref', ref)

                let fn = `{__attrUpdate('${ref}', '${attr.name}', '${exp}')}`
                dom.setAttribute('__attrUpdate', fn)
            })

            impl.tmpl = parseDom.innerHTML

        })
    })

    return chacheMount.apply(riot, arguments);
}


riot.attribute = (name, opts) => {
    attrs.push({name: name, opts: opts})
}

riot.mixin("__riotattribute__", {
    init: function() {

        this.__attrUpdate = function(id, attrName, exp) {
            let attr, elm, value

            attr = getAttr(attrName)
            elm = this.refs[id]

            function mountAttr(){
                elm.removeAttribute("ref")
                let value = riot.util.tmpl(exp, this)
                attr.opts.init.apply(attr.opts, [elm, value]);
            }
            this.off('mount', mountAttr)
            this.on('mount', mountAttr)

            value = riot.util.tmpl(exp, this)
            attr.opts.update.apply(attr.opts, [elm, value]);
        }

    }
}, true)

window.riot = riot;
riot.attribute("my-attr", {
    init: (element, value) => {
        console.log("init my-attr", element, value);
    },
    update: (element, value) => {
        console.log("update my-attr", element, value);
    }
})
