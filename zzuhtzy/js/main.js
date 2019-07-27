Ractive.DEBUG = false;

var _config = {
    blog_name       : 'Blog',
    owner           : 'renyuzhuo',
    repo            : 'Blog',
    access_token    : '6c42564c0e7fb298df020'+'38caae586fcdd0ef18d'
}

var baseUrl = "https://api.github.com/repos/"+_config['owner']+"/"+_config['repo']+"/issues";

function highlight(){
  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
}

function showLoading(){
    $('#containergif').html('<center><img src="./zzuhtzy/images/loading.gif" alt="loading" class="loading"></center>');
}

function labels(label){
    window._G = window._G || {post: {}, postList: {}};
    if(_G._ALIST != undefined){
      $('#containergif').html(_G._ALIST);
      return;
    }

    $.ajax({
        url:baseUrl + "?sort=created&labels=" + label,
        data:{
            filter       : 'created',
            access_token : _config['access_token'],
            per_page     : 10000
        },
        beforeSend:function(){
          showLoading();
        },
        success:function(data, textStatus){
            var ractive = new Ractive({
                template : '#listTpl',
                data     : {
                    posts : data
                }
            });
            window._G._ALIST = ractive.toHTML();
            $('#containergif').html(window._G._ALIST);
            for(i in data){
              var ractive = new Ractive({
                  template : '#detailTpl',
                  data     : {post: data[i]}
              });
              window._G.post[data[i].number] = {};
              window._G.post[data[i].number].body = ractive.toHTML();
            }
        }
    });
}

function issues(id){
    if(!window._G){
      window._G = {post: {}, postList: {}};
      window._G.post[id] = {};
    }

    if(_G.post[id] != undefined && _G.post[id].body != undefined){
      $('#containergif').html(_G.post[id].body);
      highlight();
      return;
    }
    $.ajax({
        url:baseUrl + "/" + id,
        data:{
            access_token:_config['access_token']
        },
        beforeSend:function(){
          showLoading();
        },
        success:function(data){
            var ractive = new Ractive({
                 el: "#containergif",
                 template: '#detailTpl',
                 data: {post: data}
            });

            highlight();
        }
    });
}

function htmlWrite(title, h1, h2, home, homeBlog, vogithub, footer_title){
    $("title").html(title);
    $("#header_h1").html(h1);
    
    if(home == undefined){
        $("#home").hide();
    }else{
        $("#home").attr("href", home);
        $("#home").show();
    }
    
    if(homeBlog == undefined){
        $("#home_blog").hide();
    }else{
        $("#home_blog").show();
    }
    
    if(vogithub == undefined){
        $("#view-on-github").hide();
    }else{
        $("#view-on-github").attr("href", vogithub);
        $("#view-on-github").show();
    }

    $("#footer_title").html(footer_title);
}

function MIT(){
    htmlWrite("MIT", "LICENSE", "/", undefined, undefined, "MIT");
    issues(12);
}

function index(){
    htmlWrite("Blog", "Blog", "/", undefined, undefined, "Blog");
    labels("Blog");
}

var helpers = Ractive.defaults.data;
helpers.markdown2HTML = function(content){
    return marked(content);
}
helpers.formatTime = function(time){
    return time.substr(0,10);
}

var routes = {
    '/': index,
    'issues/:postId': issues,
    'MIT': MIT
};

var router = Router(routes);
router.init();

function go(){
    var url = location.href;
    console.log(url);
    if(url.includes("renyuzhuo.cn/#/issues")){
        console.log("issues");
        router.init(url);
        return;
    }
    if(url.includes("renyuzhuo.cn/MIT")){
        console.log("MIT");
        MIT();
        return;
    }
    if(url.includes("renyuzhuo.cn/index") || url.includes("renyuzhuo.cn/index.html") || url.length == 21 || url.length == 20 || url.includes("127.0.0.1:3000/404.html")){
        console.log("index");
        index();
        return;
    }
    console.log("404");
    if(url !== "https://renyuzhuo.cn" && url !== "https://renyuzhuo.cn/"){
        location.href = "https://renyuzhuo.cn";
    }
    return;
}

go();

function goBack() {
    window.history.back();
}
