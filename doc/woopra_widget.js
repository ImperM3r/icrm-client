
function WoopraWidgets() {
  
  this.bar = null;
  this.barul = null;
  this.widgets = {};
  this.myCss={};

  this.init = function() {
    this.createWoopraBar();
    this.addWoopraLogo();
    this.attachReadiness();
  }
  
  this.update = function(ref, update) {

    for(k in update.items){

      if(ref.widgets[k]){
      }else{
        if(k==='chat'){
          ref.widgets[k]=new WoopraChatWidget();
        }
        if(k==='visitors'){
          ref.widgets[k]=new WoopraVisitorsWidget();
        }
        ref.widgets[k].init(ref);
      }

      if(update.items[k].enabled==true){
        ref.widgets[k].update(ref.widgets[k], update.items[k]);
      }
    }
    
    if(update.properties.cssurl==''){
      update.properties.cssurl='//static.woopra.com/css/woopra.widgets.2.css?version=1.2';
    }

    if(ref.myCss.href != update.properties.cssurl){
      ref.myCss.href = update.properties.cssurl;
    }
    if (update.properties.hide_logo==='true') {
      document.getElementById('_woopra_logo').style.display = 'none';
    } else {
      document.getElementById('_woopra_logo').style.display = 'block';
    }

    var count=0;
    
                for (var k in update.items) {
                        var item = update.items[k];

                        if(update.items[k].enabled==true){
        count++;
        ref.widgets[k].show(ref.widgets[k]);
      }else{
        ref.widgets[k].hide(ref.widgets[k]);
      }
                }

    if(count==0){
      this.bar.style.display='none';
    }else{
      this.bar.style.display='block';
    }
  }
  
  // Stop modifying here...
  

  this.createWoopraBar = function() {
    this.bar = document.createElement("div");
    this.bar.id = 'woopra_bar';
    
    this.bar.style.display='none';

    this.barul = document.createElement("ul");
    this.barul.id = 'woopra_barul';
    this.bar.appendChild(this.barul);
  }
  
  this.addWoopraLogo = function() {
    li = this.createWidget('_woopra_logo');
    var domain = window.location.hostname;
    li.innerHTML = '<a class="woopra_logotab" href="http://www.woopra.com/?woo_campaign=chatbar&woo_medium=widget&woo_source=' + domain + '" target="_blank"><img style="margin: 6px 6px 0 6px" src="//static.woopra.com/images/woopra_widget.gif" alt="Woopra"></a>';
  }
  
  this.createWidget = function(id) {
    var li = document.createElement('li');
    li.className = 'woopra_barli';
    if (id) {
      li.id = id;
    }
    var lastItem = document.getElementById('_woopra_logo');
    if (lastItem) {
      this.barul.insertBefore(li,lastItem);
    } else {
      this.barul.appendChild(li);
    }
    return li;
  }
  
  this.createWidgetTab = function() {
    var a = document.createElement('a');
    a.className = 'woopra_tab';
    a.href = '#';
    
    var id = 'box_' + this.randomId();
    a.onclick = function() {
      box = document.getElementById(id);
      if (box.style.display != 'block') {
        box.style.display = 'block';
      } else {
        box.style.display = 'none';
      }
      return false;
    }
    var box = document.createElement('div');
    box.id = id;
    box.className = 'woopra_widgetbox';
    var boxhead = document.createElement('div');
    boxhead.className = 'wwb_head';
    box.appendChild(boxhead);
    var boxcontent = document.createElement('div');
    boxcontent.className = 'wwb_content';
    box.appendChild(boxcontent);
    
    return {"link": a, "box": box, "boxhead": boxhead, "boxcontent": boxcontent};
  }
  
  this.loadToDOM = function() {
    this.myCss = document.createElement('link');
    this.myCss.rel = 'stylesheet';
    this.myCss.type = 'text/css';
    this.myCss.href = '';
    document.getElementsByTagName("head")[0].appendChild(this.myCss);
    document.body.appendChild(this.bar);
  }
  
  this.attachReadiness = function() {
    if (document.body) {
      this.loadToDOM();
      return;
    }
    var ptr = this;
    if (document.addEventListener){
        document.addEventListener("DOMContentLoaded", function(){ptr.loadToDOM()}, false)
    }else{
        document.write('<script type="text/javascript" id="contentloadtag" defer="defer" src="javascript:void(0)"><\/script>')
        var contentloadtag=document.getElementById("contentloadtag")
        contentloadtag.onreadystatechange=function(){
            if (this.readyState=="complete"){
                ptr.loadToDOM();
            }
        }
    }
  }
  
  this.randomId = function() {
    var text = "";
        var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  
        for( var i=0; i < 5; i++ ){
            text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
      return text;
  }
  
  this.getElementWidth = function(Elem) {
    if (typeof Elem.clip !== "undefined") {
            return Elem.clip.width;
      } else {
            if (Elem.style.pixelWidth) {
              return Elem.style.pixelWidth;
            } else {
              return Elem.offsetWidth;
            }
      }
  }
  
  this.init();
}


function WoopraVisitorsWidget(){

  this.init=function(ref){
    this.widget=ref.createWidget('_woopra_visitors_widget');
    this.tab=ref.createWidgetTab();
    this.tab.box.className=this.tab.box.className+' woopra_presence';
    this.widget.appendChild(this.tab.link);
    this.widget.appendChild(this.tab.box);
  }
  
  this.update=function(me, data){
    me.tab.link.innerHTML = 'Online Visitors: '+data.count;
  }

  this.show=function(me){
                 me.widget.style.display='block';
        }

        this.hide=function(me){
                me.widget.style.display='none';
        }

}

function WoopraChatWidget(widgets) {
  this.widgets = widgets;
  this.tab;
  this.content;
  this.widget;
  this._shouldHide;
  this.onlineAgents = new Array();
  
  this.init = function(ref) {
    // Create the widget LI
    this.widget = ref.createWidget('_woopra_chat_widget');
    // Create the tab anchor
    this.tab = ref.createWidgetTab();
    this.tab.box.className = this.tab.box.className + ' woopra_presence';
    // Append it to the widget
    this.widget.appendChild(this.tab.link);
    this.widget.appendChild(this.tab.box);
  }
  
  this.openChat = function(username) {
    window.open(this.onlineAgents[username].chat_url,'chatwindow','width=400,height=600,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,copyhistory=no, resizable=yes')
    return false;
  }

  this.show=function(me){
     me.widget.style.display='block';
  }

  this.hide=function(me){
    me.widget.style.display='none';
  }

  this.update = function(me, data) {
    
    var _bc = '<ul>';
    for (i=0; i<data.agents.length; i++) {
      agent = data.agents[i];
      if (!agent.chat_title || agent.chat_title=='') {agent.chat_title='Agent';}
      this.onlineAgents[agent.username] = agent;
      _bc+='<li>';
      _bc+='<a href="#" onclick="woopraWidgets.widgets[\'chat\'].openChat(\''+agent.username+'\')">';
      _bc+='<img class="wwcp_avatar" src="'+agent.chat_avatar+'"/>'; //remove http: to support SSL
      _bc+=agent.chat_name +' ('+agent.chat_status+')';
      _bc+='<br/>';
      _bc+='<span class="wwcp_meta">' + agent.chat_title + '</span>';
      _bc+='</a>';
      _bc+='</li>';
    }
    _bc += '</ul>';
    this.tab.boxcontent.innerHTML = _bc;
    this.tab.boxhead.innerHTML = 'Online Agents';
    
    if (data.agents.length>0) {
      me.tab.link.innerHTML = data.properties.online_text+' <strong>' + data.agents.length + ' online</strong>';
    } else {
      me.tab.link.innerHTML = data.properties.offline_text;
      me.tab.boxcontent.innerHTML = '<div class="wwb_desc">'+data.properties.offline_text+'</div>';
    }
  }
}

