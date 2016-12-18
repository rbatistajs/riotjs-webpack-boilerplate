<page-http>
    <!-- layout -->
    <div class="container">
        <div class="card-panel grey lighten-5 z-depth-1">
            <div class="row valign-wrapper" if={ user }>
                <div class="col s2">
                  <img src={ user.avatar_url } alt="" class="circle responsive-img"> <!-- notice the "circle" class -->
                </div>
                <div class="col s10">
                    <h3>{ user.login }</h3>
                    <span class="black-text">
                        <a href={ user.html_url }>{ user.html_url }</a>
                    </span>
                </div>
            </div>


            <div style="margin: 0 auto; display: block;" class="preloader-wrapper big active" if={ !user }>
                <div class="spinner-layer spinner-blue-only">
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>
                    <div class="gap-patch">
                        <div class="circle"></div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- script -->
    <script>
        import $http from '~/utils/http'

        $http.get("https://api.github.com/users/rbatistajs")
        .then((response) => {
            this.user = response.data
            setTimeout(this.update, 1000)
        })
    </script>

</page-http>
