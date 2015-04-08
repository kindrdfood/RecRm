/**
 * fullPage 2.5.9
 * https://github.com/alvarotrigo/fullPage.js
 * MIT licensed
 *
 * Copyright (C) 2013 alvarotrigo.com - A project by Alvaro Trigo
 */
var JqueryFullpage = {
 	adjustBody: function(){
 		$("html, body").css("margin", 0).css("padding", 0).css("overflow", "hidden");

//  //   Avoid flicker on slides transitions for mobile phones #336 
//     -webkit-tap-highlight-color: rgba(0,0,0,0);
// }
 	},
 	run: function(){

/*! Copyright (c) 2011 Piotr Rochala (http://rocha.la)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * Version: 1.3.2 (modified for fullpage.js)
 *
 */
 //slimscroll minimized code
(function(f){jQuery.fn.extend({slimScroll:function(g){var a=f.extend({width:"auto",height:"250px",size:"7px",color:"#000",position:"right",distance:"1px",start:"top",opacity:.4,alwaysVisible:!1,disableFadeOut:!1,railVisible:!1,railColor:"#333",railOpacity:.2,railDraggable:!0,railClass:"slimScrollRail",barClass:"slimScrollBar",wrapperClass:"slimScrollDiv",allowPageScroll:!1,wheelStep:20,touchScrollStep:200,borderRadius:"7px",railBorderRadius:"7px"},g);this.each(function(){function s(d){d=d||window.event;
var c=0;d.wheelDelta&&(c=-d.wheelDelta/120);d.detail&&(c=d.detail/3);f(d.target||d.srcTarget||d.srcElement).closest("."+a.wrapperClass).is(b.parent())&&m(c,!0);d.preventDefault&&!k&&d.preventDefault();k||(d.returnValue=!1)}function m(d,f,g){k=!1;var e=d,h=b.outerHeight()-c.outerHeight();f&&(e=parseInt(c.css("top"))+d*parseInt(a.wheelStep)/100*c.outerHeight(),e=Math.min(Math.max(e,0),h),e=0<d?Math.ceil(e):Math.floor(e),c.css({top:e+"px"}));l=parseInt(c.css("top"))/(b.outerHeight()-c.outerHeight());
e=l*(b[0].scrollHeight-b.outerHeight());g&&(e=d,d=e/b[0].scrollHeight*b.outerHeight(),d=Math.min(Math.max(d,0),h),c.css({top:d+"px"}));b.scrollTop(e);b.trigger("slimscrolling",~~e);u();p()}function C(){window.addEventListener?(this.addEventListener("DOMMouseScroll",s,!1),this.addEventListener("mousewheel",s,!1)):document.attachEvent("onmousewheel",s)}function v(){r=Math.max(b.outerHeight()/b[0].scrollHeight*b.outerHeight(),D);c.css({height:r+"px"});var a=r==b.outerHeight()?"none":"block";c.css({display:a})}
function u(){v();clearTimeout(A);l==~~l?(k=a.allowPageScroll,B!=l&&b.trigger("slimscroll",0==~~l?"top":"bottom")):k=!1;B=l;r>=b.outerHeight()?k=!0:(c.stop(!0,!0).fadeIn("fast"),a.railVisible&&h.stop(!0,!0).fadeIn("fast"))}function p(){a.alwaysVisible||(A=setTimeout(function(){a.disableFadeOut&&w||x||y||(c.fadeOut("slow"),h.fadeOut("slow"))},1E3))}var w,x,y,A,z,r,l,B,D=30,k=!1,b=f(this);if(b.parent().hasClass(a.wrapperClass)){var n=b.scrollTop(),c=b.parent().find("."+a.barClass),h=b.parent().find("."+
a.railClass);v();if(f.isPlainObject(g)){if("height"in g&&"auto"==g.height){b.parent().css("height","auto");b.css("height","auto");var q=b.parent().parent().height();b.parent().css("height",q);b.css("height",q)}if("scrollTo"in g)n=parseInt(a.scrollTo);else if("scrollBy"in g)n+=parseInt(a.scrollBy);else if("destroy"in g){c.remove();h.remove();b.unwrap();return}m(n,!1,!0)}}else{a.height="auto"==g.height?b.parent().height():g.height;n=f("<div></div>").addClass(a.wrapperClass).css({position:"relative",
overflow:"hidden",width:a.width,height:a.height});b.css({overflow:"hidden",width:a.width,height:a.height});var h=f("<div></div>").addClass(a.railClass).css({width:a.size,height:"100%",position:"absolute",top:0,display:a.alwaysVisible&&a.railVisible?"block":"none","border-radius":a.railBorderRadius,background:a.railColor,opacity:a.railOpacity,zIndex:90}),c=f("<div></div>").addClass(a.barClass).css({background:a.color,width:a.size,position:"absolute",top:0,opacity:a.opacity,display:a.alwaysVisible?
"block":"none","border-radius":a.borderRadius,BorderRadius:a.borderRadius,MozBorderRadius:a.borderRadius,WebkitBorderRadius:a.borderRadius,zIndex:99}),q="right"==a.position?{right:a.distance}:{left:a.distance};h.css(q);c.css(q);b.wrap(n);b.parent().append(c);b.parent().append(h);a.railDraggable&&c.bind("mousedown",function(a){var b=f(document);y=!0;t=parseFloat(c.css("top"));pageY=a.pageY;b.bind("mousemove.slimscroll",function(a){currTop=t+a.pageY-pageY;c.css("top",currTop);m(0,c.position().top,!1)});
b.bind("mouseup.slimscroll",function(a){y=!1;p();b.unbind(".slimscroll")});return!1}).bind("selectstart.slimscroll",function(a){a.stopPropagation();a.preventDefault();return!1});h.hover(function(){u()},function(){p()});c.hover(function(){x=!0},function(){x=!1});b.hover(function(){w=!0;u();p()},function(){w=!1;p()});b.bind("touchstart",function(a,b){a.originalEvent.touches.length&&(z=a.originalEvent.touches[0].pageY)});b.bind("touchmove",function(b){k||b.originalEvent.preventDefault();b.originalEvent.touches.length&&
(m((z-b.originalEvent.touches[0].pageY)/a.touchScrollStep,!0),z=b.originalEvent.touches[0].pageY)});v();"bottom"===a.start?(c.css({top:b.outerHeight()-c.outerHeight()}),m(0,!0)):"top"!==a.start&&(m(f(a.start).position().top,null,!0),a.alwaysVisible||c.hide());C()}});return this}});jQuery.fn.extend({slimscroll:jQuery.fn.slimScroll})})(jQuery);


// fulllpage minimized code
		(function(c,k,g,l,D){c.fn.fullpage=function(d){function Aa(a){a.find(".fp-slides").after('<div class="fp-controlArrow fp-prev"></div><div class="fp-controlArrow fp-next"></div>');"#fff"!=d.controlArrowColor&&(a.find(".fp-controlArrow.fp-next").css("border-color","transparent transparent transparent "+d.controlArrowColor),a.find(".fp-controlArrow.fp-prev").css("border-color","transparent "+d.controlArrowColor+" transparent transparent"));d.loopHorizontal||a.find(".fp-controlArrow.fp-prev").hide()}
		function Ba(){c("body").append('<div id="fp-nav"><ul></ul></div>');q=c("#fp-nav");q.addClass(d.navigationPosition);for(var a=0;a<c(".fp-section").length;a++){var b="";d.anchors.length&&(b=d.anchors[a]);var b='<li><a href="#'+b+'"><span></span></a>',h=d.navigationTooltips[a];"undefined"!==typeof h&&""!==h&&(b+='<div class="fp-tooltip '+d.navigationPosition+'">'+h+"</div>");b+="</li>";q.find("ul").append(b)}}function Z(){c(".fp-section").each(function(){var a=c(this).find(".fp-slide");a.length?a.each(function(){E(c(this))}):
		E(c(this))});c.isFunction(d.afterRender)&&d.afterRender.call(this)}function aa(){var a;if(!d.autoScrolling||d.scrollBar){for(var b=c(k).scrollTop(),h=0,F=l.abs(b-g.getElementsByClassName("fp-section")[0].offsetTop),e=g.getElementsByClassName("fp-section"),f=0;f<e.length;++f){var w=l.abs(b-e[f].offsetTop);w<F&&(h=f,F=w)}a=c(e).eq(h)}if(!d.autoScrolling||d.scrollBar){if(!a.hasClass("active")){Q=!0;b=c(".fp-section.active");h=b.index(".fp-section")+1;F=R(a);e=a.data("anchor");f=a.index(".fp-section")+
		1;w=a.find(".fp-slide.active");if(w.length)var n=w.data("anchor"),m=w.index();r&&(a.addClass("active").siblings().removeClass("active"),c.isFunction(d.onLeave)&&d.onLeave.call(b,h,f,F),c.isFunction(d.afterLoad)&&d.afterLoad.call(a,e,f),G(e,f-1),d.anchors.length&&(u=e,S(m,n,e,f)));clearTimeout(ba);ba=setTimeout(function(){Q=!1},100)}d.fitToSection&&(clearTimeout(ca),ca=setTimeout(function(){r&&(c(".fp-section.active").is(a)&&(v=!0),t(a),v=!1)},1E3))}}function da(a){return a.find(".fp-slides").length?
		a.find(".fp-slide.active").find(".fp-scrollable"):a.find(".fp-scrollable")}function H(a,b){if(m[a]){var c,d;"down"==a?(c="bottom",d=e.moveSectionDown):(c="top",d=e.moveSectionUp);if(0<b.length)if(c="top"===c?!b.scrollTop():"bottom"===c?b.scrollTop()+1+b.innerHeight()>=b[0].scrollHeight:void 0,c)d();else return!0;else d()}}function Ca(a){var b=a.originalEvent;if(!ea(a.target)&&fa(b)){d.autoScrolling&&a.preventDefault();a=c(".fp-section.active");var h=da(a);r&&!x&&(b=ga(b),z=b.y,I=b.x,a.find(".fp-slides").length&&
		l.abs(J-I)>l.abs(A-z)?l.abs(J-I)>c(k).width()/100*d.touchSensitivity&&(J>I?m.right&&e.moveSlideRight():m.left&&e.moveSlideLeft()):d.autoScrolling&&l.abs(A-z)>c(k).height()/100*d.touchSensitivity&&(A>z?H("down",h):z>A&&H("up",h)))}}function ea(a,b){b=b||0;var h=c(a).parent();return b<d.normalScrollElementTouchThreshold&&h.is(d.normalScrollElements)?!0:b==d.normalScrollElementTouchThreshold?!1:ea(h,++b)}function fa(a){return"undefined"===typeof a.pointerType||"mouse"!=a.pointerType}function Da(a){a=
		a.originalEvent;d.fitToSection&&c("html,body").stop();fa(a)&&(a=ga(a),A=a.y,J=a.x)}function ha(a,b){for(var c=0,d=a.slice(l.max(a.length-b,1)),e=0;e<d.length;e++)c+=d[e];return l.ceil(c/b)}function y(a){if(d.autoScrolling){a=k.event||a;var b=a.wheelDelta||-a.deltaY||-a.detail,h=l.max(-1,l.min(1,b));149<B.length&&B.shift();B.push(l.abs(b));d.scrollBar&&(a.preventDefault?a.preventDefault():a.returnValue=!1);a=c(".fp-section.active");a=da(a);if(r){var b=ha(B,10),e=ha(B,70);b>=e&&(0>h?H("down",a):H("up",
		a))}return!1}d.fitToSection&&c("html,body").stop()}function ia(a){var b=c(".fp-section.active").find(".fp-slides");if(b.length&&!x){var h=b.find(".fp-slide.active"),e=null,e="prev"===a?h.prev(".fp-slide"):h.next(".fp-slide");if(!e.length){if(!d.loopHorizontal)return;e="prev"===a?h.siblings(":last"):h.siblings(":first")}x=!0;C(b,e)}}function ja(){c(".fp-slide.active").each(function(){T(c(this))})}function t(a,b,h){var e=a.position();if("undefined"!==typeof e&&(b={element:a,callback:b,isMovementUp:h,
		dest:e,dtop:e.top,yMovement:R(a),anchorLink:a.data("anchor"),sectionIndex:a.index(".fp-section"),activeSlide:a.find(".fp-slide.active"),activeSection:c(".fp-section.active"),leavingSection:c(".fp-section.active").index(".fp-section")+1,localIsResizing:v},!(b.activeSection.is(a)&&!v||d.scrollBar&&c(k).scrollTop()===b.dtop))){if(b.activeSlide.length)var f=b.activeSlide.data("anchor"),g=b.activeSlide.index();d.autoScrolling&&d.continuousVertical&&"undefined"!==typeof b.isMovementUp&&(!b.isMovementUp&&
		"up"==b.yMovement||b.isMovementUp&&"down"==b.yMovement)&&(b.isMovementUp?c(".fp-section.active").before(b.activeSection.nextAll(".fp-section")):c(".fp-section.active").after(b.activeSection.prevAll(".fp-section").get().reverse()),p(c(".fp-section.active").position().top),ja(),b.wrapAroundElements=b.activeSection,b.dest=b.element.position(),b.dtop=b.dest.top,b.yMovement=R(b.element));a.addClass("active").siblings().removeClass("active");r=!1;S(g,f,b.anchorLink,b.sectionIndex);c.isFunction(d.onLeave)&&
		!b.localIsResizing&&d.onLeave.call(b.activeSection,b.leavingSection,b.sectionIndex+1,b.yMovement);Ea(b);u=b.anchorLink;G(b.anchorLink,b.sectionIndex)}}function Ea(a){if(d.css3&&d.autoScrolling&&!d.scrollBar)ka("translate3d(0px, -"+a.dtop+"px, 0px)",!0),setTimeout(function(){la(a)},d.scrollingSpeed);else{var b=Fa(a);c(b.element).animate(b.options,d.scrollingSpeed,d.easing).promise().done(function(){la(a)})}}function Fa(a){var b={};d.autoScrolling&&!d.scrollBar?(b.options={top:-a.dtop},b.element="."+
		ma):(b.options={scrollTop:a.dtop},b.element="html, body");return b}function Ga(a){a.wrapAroundElements&&a.wrapAroundElements.length&&(a.isMovementUp?c(".fp-section:first").before(a.wrapAroundElements):c(".fp-section:last").after(a.wrapAroundElements),p(c(".fp-section.active").position().top),ja())}function la(a){Ga(a);c.isFunction(d.afterLoad)&&!a.localIsResizing&&d.afterLoad.call(a.element,a.anchorLink,a.sectionIndex+1);r=!0;setTimeout(function(){c.isFunction(a.callback)&&a.callback.call(this)},
		600)}function na(){if(!Q){var a=k.location.hash.replace("#","").split("/"),b=a[0],a=a[1];if(b.length){var c="undefined"===typeof u,d="undefined"===typeof u&&"undefined"===typeof a&&!x;(b&&b!==u&&!c||d||!x&&U!=a)&&V(b,a)}}}function Ha(a){r&&(a.pageY<K?e.moveSectionUp():a.pageY>K&&e.moveSectionDown());K=a.pageY}function C(a,b){var h=b.position(),e=a.find(".fp-slidesContainer").parent(),f=b.index(),g=a.closest(".fp-section"),k=g.index(".fp-section"),l=g.data("anchor"),n=g.find(".fp-slidesNav"),m=b.data("anchor"),
		r=v;if(d.onSlideLeave){var t=g.find(".fp-slide.active"),p=t.index(),q;q=p==f?"none":p>f?"left":"right";r||"none"===q||c.isFunction(d.onSlideLeave)&&d.onSlideLeave.call(t,l,k+1,p,q)}b.addClass("active").siblings().removeClass("active");"undefined"===typeof m&&(m=f);!d.loopHorizontal&&d.controlArrows&&(g.find(".fp-controlArrow.fp-prev").toggle(0!==f),g.find(".fp-controlArrow.fp-next").toggle(!b.is(":last-child")));g.hasClass("active")&&S(f,m,l,k);var u=function(){r||c.isFunction(d.afterSlideLoad)&&
		d.afterSlideLoad.call(b,l,k+1,m,f);x=!1};d.css3?(h="translate3d(-"+h.left+"px, 0px, 0px)",oa(a.find(".fp-slidesContainer"),0<d.scrollingSpeed).css(pa(h)),setTimeout(function(){u()},d.scrollingSpeed,d.easing)):e.animate({scrollLeft:h.left},d.scrollingSpeed,d.easing,function(){u()});n.find(".active").removeClass("active");n.find("li").eq(f).find("a").addClass("active")}function qa(){ra();if(L){var a=c(g.activeElement);a.is("textarea")||a.is("input")||a.is("select")||(a=c(k).height(),l.abs(a-W)>20*l.max(W,
		a)/100&&(e.reBuild(!0),W=a))}else clearTimeout(sa),sa=setTimeout(function(){e.reBuild(!0)},500)}function ra(){if(d.responsive){var a=f.hasClass("fp-responsive");c(k).width()<d.responsive?a||(e.setAutoScrolling(!1,"internal"),e.setFitToSection(!1,"internal"),c("#fp-nav").hide(),f.addClass("fp-responsive")):a&&(e.setAutoScrolling(M.autoScrolling,"internal"),e.setFitToSection(M.autoScrolling,"internal"),c("#fp-nav").show(),f.removeClass("fp-responsive"))}}function oa(a){var b="all "+d.scrollingSpeed+
		"ms "+d.easingcss3;a.removeClass("fp-notransition");return a.css({"-webkit-transition":b,transition:b})}function X(a){return a.addClass("fp-notransition")}function Ia(a,b){if(825>a||900>b){var d=l.min(100*a/825,100*b/900).toFixed(2);c("body").css("font-size",d+"%")}else c("body").css("font-size","100%")}function G(a,b){d.menu&&(c(d.menu).find(".active").removeClass("active"),c(d.menu).find('[data-menuanchor="'+a+'"]').addClass("active"));d.navigation&&(c("#fp-nav").find(".active").removeClass("active"),
		a?c("#fp-nav").find('a[href="#'+a+'"]').addClass("active"):c("#fp-nav").find("li").eq(b).find("a").addClass("active"))}function R(a){var b=c(".fp-section.active").index(".fp-section");a=a.index(".fp-section");return b==a?"none":b>a?"up":"down"}function E(a){a.css("overflow","hidden");var b=a.closest(".fp-section"),c=a.find(".fp-scrollable"),e;c.length?e=c.get(0).scrollHeight:(e=a.get(0).scrollHeight,d.verticalCentered&&(e=a.find(".fp-tableCell").get(0).scrollHeight));b=n-parseInt(b.css("padding-bottom"))-
		parseInt(b.css("padding-top"));e>b?c.length?c.css("height",b+"px").parent().css("height",b+"px"):(d.verticalCentered?a.find(".fp-tableCell").wrapInner('<div class="fp-scrollable" />'):a.wrapInner('<div class="fp-scrollable" />'),a.find(".fp-scrollable").slimScroll({allowPageScroll:!0,height:b+"px",size:"10px",alwaysVisible:!0})):ta(a);a.css("overflow","")}function ta(a){a.find(".fp-scrollable").children().first().unwrap().unwrap();a.find(".slimScrollBar").remove();a.find(".slimScrollRail").remove()}
		function ua(a){a.addClass("fp-table").wrapInner('<div class="fp-tableCell" style="height:'+va(a)+'px;" />')}function va(a){var b=n;if(d.paddingTop||d.paddingBottom)b=a,b.hasClass("fp-section")||(b=a.closest(".fp-section")),a=parseInt(b.css("padding-top"))+parseInt(b.css("padding-bottom")),b=n-a;return b}function ka(a,b){b?oa(f):X(f);f.css(pa(a));setTimeout(function(){f.removeClass("fp-notransition")},10)}function V(a,b){var d;"undefined"===typeof b&&(b=0);d=isNaN(a)?c('[data-anchor="'+a+'"]'):c(".fp-section").eq(a-
		1);a===u||d.hasClass("active")?wa(d,b):t(d,function(){wa(d,b)})}function wa(a,b){if("undefined"!=typeof b){var c=a.find(".fp-slides"),d=c.find('[data-anchor="'+b+'"]');d.length||(d=c.find(".fp-slide").eq(b));d.length&&C(c,d)}}function Ja(a,b){a.append('<div class="fp-slidesNav"><ul></ul></div>');var c=a.find(".fp-slidesNav");c.addClass(d.slidesNavPosition);for(var e=0;e<b;e++)c.find("ul").append('<li><a href="#"><span></span></a></li>');c.css("margin-left","-"+c.width()/2+"px");c.find("li").first().find("a").addClass("active")}
		function S(a,b,c,e){var f="";d.anchors.length?(a?("undefined"!==typeof c&&(f=c),"undefined"===typeof b&&(b=a),U=b,xa(f+"/"+b)):("undefined"!==typeof a&&(U=b),xa(c)),N(location.hash)):"undefined"!==typeof a?N(e+"-"+a):N(String(e))}function xa(a){if(d.recordHistory)location.hash=a;else if(L||Y)history.replaceState(D,D,"#"+a);else{var b=k.location.href.split("#")[0];k.location.replace(b+"#"+a)}}function N(a){a=a.replace("/","-").replace("#","");c("body")[0].className=c("body")[0].className.replace(/\b\s?fp-viewing-[^\s]+\b/g,
		"");c("body").addClass("fp-viewing-"+a)}function Ka(){var a=g.createElement("p"),b,c={webkitTransform:"-webkit-transform",OTransform:"-o-transform",msTransform:"-ms-transform",MozTransform:"-moz-transform",transform:"transform"};g.body.insertBefore(a,null);for(var d in c)a.style[d]!==D&&(a.style[d]="translate3d(1px,1px,1px)",b=k.getComputedStyle(a).getPropertyValue(c[d]));g.body.removeChild(a);return b!==D&&0<b.length&&"none"!==b}function La(){if(L||Y){var a=ya();c(g).off("touchstart "+a.down).on("touchstart "+
		a.down,Da);c(g).off("touchmove "+a.move).on("touchmove "+a.move,Ca)}}function Ma(){if(L||Y){var a=ya();c(g).off("touchstart "+a.down);c(g).off("touchmove "+a.move)}}function ya(){return k.PointerEvent?{down:"pointerdown",move:"pointermove"}:{down:"MSPointerDown",move:"MSPointerMove"}}function ga(a){var b=[];b.y="undefined"!==typeof a.pageY&&(a.pageY||a.pageX)?a.pageY:a.touches[0].pageY;b.x="undefined"!==typeof a.pageX&&(a.pageY||a.pageX)?a.pageX:a.touches[0].pageX;return b}function T(a){e.setScrollingSpeed(0,
		"internal");C(a.closest(".fp-slides"),a);e.setScrollingSpeed(M.scrollingSpeed,"internal")}function p(a){d.scrollBar?f.scrollTop(a):d.css3?ka("translate3d(0px, -"+a+"px, 0px)",!1):f.css("top",-a)}function pa(a){return{"-webkit-transform":a,"-moz-transform":a,"-ms-transform":a,transform:a}}function Na(){p(0);c("#fp-nav, .fp-slidesNav, .fp-controlArrow").remove();c(".fp-section").css({height:"","background-color":"",padding:""});c(".fp-slide").css({width:""});f.css({height:"",position:"","-ms-touch-action":"",
		"touch-action":""});c(".fp-section, .fp-slide").each(function(){ta(c(this));c(this).removeClass("fp-table active")});X(f);X(f.find(".fp-easing"));f.find(".fp-tableCell, .fp-slidesContainer, .fp-slides").each(function(){c(this).replaceWith(this.childNodes)});c("html, body").scrollTop(0)}function O(a,b,c){d[a]=b;"internal"!==c&&(M[a]=b)}function P(a,b){console&&console[a]&&console[a]("fullPage: "+b)}var e=c.fn.fullpage;d=c.extend({menu:!1,anchors:[],navigation:!1,navigationPosition:"right",navigationTooltips:[],
		slidesNavigation:!1,slidesNavPosition:"bottom",scrollBar:!1,css3:!0,scrollingSpeed:700,autoScrolling:!0,fitToSection:!0,easing:"easeInOutCubic",easingcss3:"ease",loopBottom:!1,loopTop:!1,loopHorizontal:!0,continuousVertical:!1,normalScrollElements:null,scrollOverflow:!1,touchSensitivity:5,normalScrollElementTouchThreshold:5,keyboardScrolling:!0,animateAnchor:!0,recordHistory:!0,controlArrows:!0,controlArrowColor:"#fff",verticalCentered:!0,resize:!1,sectionsColor:[],paddingTop:0,paddingBottom:0,fixedElements:null,
		responsive:0,sectionSelector:".section",slideSelector:".slide",afterLoad:null,onLeave:null,afterRender:null,afterResize:null,afterReBuild:null,afterSlideLoad:null,onSlideLeave:null},d);(function(){d.continuousVertical&&(d.loopTop||d.loopBottom)&&(d.continuousVertical=!1,P("warn","Option `loopTop/loopBottom` is mutually exclusive with `continuousVertical`; `continuousVertical` disabled"));d.continuousVertical&&d.scrollBar&&(d.continuousVertical=!1,P("warn","Option `scrollBar` is mutually exclusive with `continuousVertical`; `continuousVertical` disabled"));
		c.each(d.anchors,function(a,b){(c("#"+b).length||c('[name="'+b+'"]').length)&&P("error","data-anchor tags can not have the same value as any `id` element on the site (or `name` element for IE).")})})();c.extend(c.easing,{easeInOutCubic:function(a,b,c,d,e){return 1>(b/=e/2)?d/2*b*b*b+c:d/2*((b-=2)*b*b+2)+c}});c.extend(c.easing,{easeInQuart:function(a,b,c,d,e){return d*(b/=e)*b*b*b+c}});e.setAutoScrolling=function(a,b){O("autoScrolling",a,b);var h=c(".fp-section.active");d.autoScrolling&&!d.scrollBar?
		(c("html, body").css({overflow:"hidden",height:"100%"}),e.setRecordHistory(d.recordHistory,"internal"),f.css({"-ms-touch-action":"none","touch-action":"none"}),h.length&&p(h.position().top)):(c("html, body").css({overflow:"visible",height:"initial"}),e.setRecordHistory(!1,"internal"),f.css({"-ms-touch-action":"","touch-action":""}),p(0),h.length&&c("html, body").scrollTop(h.position().top))};e.setRecordHistory=function(a,b){O("recordHistory",a,b)};e.setScrollingSpeed=function(a,b){O("scrollingSpeed",
		a,b)};e.setFitToSection=function(a,b){O("fitToSection",a,b)};e.setMouseWheelScrolling=function(a){a?g.addEventListener?(g.addEventListener("mousewheel",y,!1),g.addEventListener("wheel",y,!1)):g.attachEvent("onmousewheel",y):g.addEventListener?(g.removeEventListener("mousewheel",y,!1),g.removeEventListener("wheel",y,!1)):g.detachEvent("onmousewheel",y)};e.setAllowScrolling=function(a,b){"undefined"!=typeof b?(b=b.replace(" ","").split(","),c.each(b,function(b,c){switch(c){case "up":m.up=a;break;case "down":m.down=
		a;break;case "left":m.left=a;break;case "right":m.right=a;break;case "all":e.setAllowScrolling(a)}})):a?(e.setMouseWheelScrolling(!0),La()):(e.setMouseWheelScrolling(!1),Ma())};e.setKeyboardScrolling=function(a){d.keyboardScrolling=a};e.moveSectionUp=function(){var a=c(".fp-section.active").prev(".fp-section");a.length||!d.loopTop&&!d.continuousVertical||(a=c(".fp-section").last());a.length&&t(a,null,!0)};e.moveSectionDown=function(){var a=c(".fp-section.active").next(".fp-section");a.length||!d.loopBottom&&
		!d.continuousVertical||(a=c(".fp-section").first());a.length&&t(a,null,!1)};e.moveTo=function(a,b){var d="",d=isNaN(a)?c('[data-anchor="'+a+'"]'):c(".fp-section").eq(a-1);"undefined"!==typeof b?V(a,b):0<d.length&&t(d)};e.moveSlideRight=function(){ia("next")};e.moveSlideLeft=function(){ia("prev")};e.reBuild=function(a){if(!f.hasClass("fp-destroyed")){v=!0;var b=c(k).width();n=c(k).height();d.resize&&Ia(n,b);c(".fp-section").each(function(){var a=c(this).find(".fp-slides"),b=c(this).find(".fp-slide");
		d.verticalCentered&&c(this).find(".fp-tableCell").css("height",va(c(this))+"px");c(this).css("height",n+"px");d.scrollOverflow&&(b.length?b.each(function(){E(c(this))}):E(c(this)));b.length&&C(a,a.find(".fp-slide.active"))});b=c(".fp-section.active");b.index(".fp-section")&&t(b);v=!1;c.isFunction(d.afterResize)&&a&&d.afterResize.call(f);c.isFunction(d.afterReBuild)&&!a&&d.afterReBuild.call(f)}};var x=!1,L=navigator.userAgent.match(/(iPhone|iPod|iPad|Android|playbook|silk|BlackBerry|BB10|Windows Phone|Tizen|Bada|webOS|IEMobile|Opera Mini)/),
		Y="ontouchstart"in k||0<navigator.msMaxTouchPoints||navigator.maxTouchPoints,f=c(this),n=c(k).height(),v=!1,u,U,r=!0,B=[],q,ma="fullpage-wrapper",m={up:!0,down:!0,left:!0,right:!0},M=c.extend(!0,{},d);e.setAllowScrolling(!0);f.removeClass("fp-destroyed");d.css3&&(d.css3=Ka());c(this).length?(f.css({height:"100%",position:"relative"}),f.addClass(ma)):P("error","Error! Fullpage.js needs to be initialized with a selector. For example: $('#myContainer').fullpage();");c(d.sectionSelector).each(function(){c(this).addClass("fp-section")});
		c(d.slideSelector).each(function(){c(this).addClass("fp-slide")});d.navigation&&Ba();c(".fp-section").each(function(a){var b=c(this),e=c(this).find(".fp-slide"),f=e.length;a||0!==c(".fp-section.active").length||c(this).addClass("active");c(this).css("height",n+"px");(d.paddingTop||d.paddingBottom)&&c(this).css("padding",d.paddingTop+" 0 "+d.paddingBottom+" 0");"undefined"!==typeof d.sectionsColor[a]&&c(this).css("background-color",d.sectionsColor[a]);"undefined"!==typeof d.anchors[a]&&(c(this).attr("data-anchor",
		d.anchors[a]),c(this).hasClass("active")&&G(d.anchors[a],a));if(1<f){a=100*f;var g=100/f;e.wrapAll('<div class="fp-slidesContainer" />');e.parent().wrap('<div class="fp-slides" />');c(this).find(".fp-slidesContainer").css("width",a+"%");d.controlArrows&&Aa(c(this));d.slidesNavigation&&Ja(c(this),f);e.each(function(a){c(this).css("width",g+"%");d.verticalCentered&&ua(c(this))});b=b.find(".fp-slide.active");b.length?T(b):e.eq(0).addClass("active")}else d.verticalCentered&&ua(c(this))}).promise().done(function(){e.setAutoScrolling(d.autoScrolling,
		"internal");var a=c(".fp-section.active").find(".fp-slide.active");a.length&&(0!==c(".fp-section.active").index(".fp-section")||0===c(".fp-section.active").index(".fp-section")&&0!==a.index())&&T(a);d.fixedElements&&d.css3&&c(d.fixedElements).appendTo("body");d.navigation&&(q.css("margin-top","-"+q.height()/2+"px"),q.find("li").eq(c(".fp-section.active").index(".fp-section")).find("a").addClass("active"));d.menu&&d.css3&&c(d.menu).closest(".fullpage-wrapper").length&&c(d.menu).appendTo("body");d.scrollOverflow?
		("complete"===g.readyState&&Z(),c(k).on("load",Z)):c.isFunction(d.afterRender)&&d.afterRender.call(f);ra();a=k.location.hash.replace("#","").split("/")[0];if(a.length){var b=c('[data-anchor="'+a+'"]');!d.animateAnchor&&b.length&&(d.autoScrolling?p(b.position().top):(p(0),N(a),c("html, body").scrollTop(b.position().top)),G(a,null),c.isFunction(d.afterLoad)&&d.afterLoad.call(b,a,b.index(".fp-section")+1),b.addClass("active").siblings().removeClass("active"))}c(k).on("load",function(){var a=k.location.hash.replace("#",
		"").split("/"),b=a[0],a=a[1];b&&V(b,a)})});var ba,ca,Q=!1;c(k).on("scroll",aa);var A=0,J=0,z=0,I=0;c(k).on("hashchange",na);c(k).keydown(function(a){clearTimeout(za);var b=c(g.activeElement);b.is("textarea")||b.is("input")||b.is("select")||!d.keyboardScrolling||!d.autoScrolling||(-1<[40,38,32,33,34].indexOf(a.which)&&a.preventDefault(),za=setTimeout(function(){var b=a.shiftKey;switch(a.which){case 38:case 33:e.moveSectionUp();break;case 32:if(b){e.moveSectionUp();break}case 40:case 34:e.moveSectionDown();
		break;case 36:e.moveTo(1);break;case 35:e.moveTo(c(".fp-section").length);break;case 37:e.moveSlideLeft();break;case 39:e.moveSlideRight()}},150))});var za;f.mousedown(function(a){2==a.which&&(K=a.pageY,f.on("mousemove",Ha))});f.mouseup(function(a){2==a.which&&f.off("mousemove")});var K=0;c(g).on("click touchstart","#fp-nav a",function(a){a.preventDefault();a=c(this).parent().index();t(c(".fp-section").eq(a))});c(g).on("click touchstart",".fp-slidesNav a",function(a){a.preventDefault();a=c(this).closest(".fp-section").find(".fp-slides");
		var b=a.find(".fp-slide").eq(c(this).closest("li").index());C(a,b)});d.normalScrollElements&&(c(g).on("mouseenter",d.normalScrollElements,function(){e.setMouseWheelScrolling(!1)}),c(g).on("mouseleave",d.normalScrollElements,function(){e.setMouseWheelScrolling(!0)}));c(".fp-section").on("click touchstart",".fp-controlArrow",function(){c(this).hasClass("fp-prev")?e.moveSlideLeft():e.moveSlideRight()});c(k).resize(qa);var W=n,sa;e.destroy=function(a){e.setAutoScrolling(!1,"internal");e.setAllowScrolling(!1);
		e.setKeyboardScrolling(!1);f.addClass("fp-destroyed");c(k).off("scroll",aa).off("hashchange",na).off("resize",qa);c(g).off("click","#fp-nav a").off("mouseenter","#fp-nav li").off("mouseleave","#fp-nav li").off("click",".fp-slidesNav a").off("mouseover",d.normalScrollElements).off("mouseout",d.normalScrollElements);c(".fp-section").off("click",".fp-controlArrow");a&&Na()}}})(jQuery,window,document,Math);
			// inititate
			
		$('#fullpage').fullpage({navigation: true, scrollOverflow: true, responsive: 768});
		// set links individual sections
		$(".section-link").on("click", function(e){
			e.preventDefault();
			var section = $(this).data("section");
			$.fn.fullpage.moveTo(section);
		});
		// set sign up buttons to scroll to slide 1 form
		$(".sign-up-button").on("click", function(e){
			e.preventDefault();
			$.fn.fullpage.moveTo(1);
		});
		// set sign up modal buttons to open modal
		$(".sign-up-modal-button").on("click", function(e){
			e.preventDefault();
			$("#signUpModal").modal();
		});
		// set join beta button to trigger pop up if on small screen
		$("#join-beta-button").on("click", function(e){
			if ($(".home-page-form").css("display") === "none"){
				$("#signUpModal").modal();
			}else {
				$.fn.fullpage.moveTo(1);				
			}
		});
 	}
}
