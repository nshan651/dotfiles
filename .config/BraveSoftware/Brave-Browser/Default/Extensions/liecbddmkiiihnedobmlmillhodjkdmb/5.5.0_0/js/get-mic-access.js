(function(E){var o={};function n(t){if(o[t])return o[t].exports;var i=o[t]={i:t,l:!1,exports:{}};return E[t].call(i.exports,i,i.exports,n),i.l=!0,i.exports}return n.m=E,n.c=o,n.d=function(t,i,s){n.o(t,i)||Object.defineProperty(t,i,{enumerable:!0,get:s})},n.r=function(t){typeof Symbol!="undefined"&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},n.t=function(t,i){if(i&1&&(t=n(t)),i&8||i&4&&typeof t=="object"&&t&&t.__esModule)return t;var s=Object.create(null);if(n.r(s),Object.defineProperty(s,"default",{enumerable:!0,value:t}),i&2&&typeof t!="string")for(var u in t)n.d(s,u,function(r){return t[r]}.bind(null,u));return s},n.n=function(t){var i=t&&t.__esModule?function(){return t.default}:function(){return t};return n.d(i,"a",i),i},n.o=function(t,i){return Object.prototype.hasOwnProperty.call(t,i)},n.p="",n(n.s=622)})({15:function(E,o,n){"use strict";n.d(o,"b",function(){return t}),n.d(o,"d",function(){return i}),n.d(o,"g",function(){return s}),n.d(o,"i",function(){return u}),n.d(o,"h",function(){return r}),n.d(o,"j",function(){return d}),n.d(o,"k",function(){return c}),n.d(o,"c",function(){return f}),n.d(o,"m",function(){return e}),n.d(o,"l",function(){return T}),n.d(o,"p",function(){return O}),n.d(o,"o",function(){return l}),n.d(o,"n",function(){return S}),n.d(o,"t",function(){return I}),n.d(o,"r",function(){return R}),n.d(o,"s",function(){return N}),n.d(o,"u",function(){return g}),n.d(o,"w",function(){return M}),n.d(o,"y",function(){return m}),n.d(o,"x",function(){return A}),n.d(o,"z",function(){return C}),n.d(o,"e",function(){return D}),n.d(o,"a",function(){return a}),n.d(o,"q",function(){return L}),n.d(o,"f",function(){return G}),n.d(o,"v",function(){return P});const t="allow-loom-urls",i="disallow-loom-urls",s="get-cam-permission",u="get-mic-permission",r="get-mic-and-cam-permissions",d="get-session-details",c="get-session-details-from-alias-id",f="check-content-connection",e="inject-intercom-link-expand-script",T="initiate-loom-recorder-from-script",O="open-gmail-integration-walkthrough-from-gmail-composer",l="log-exception",S="log-crumb",I="request-tab-id",R="request-active-tab",N="request-devices",g="request-thumb-exists",M="track-event",m="update-integration-settings",A="update-companion-settings",C="user-login",D="extension-clicked",a="add-log-entry",L="loom-recording-started",G="fetch-camfort-thumbnail",P="switch-to-recording-tab"},622:function(E,o,n){"use strict";n.r(o);var t=n(15);const i="PermissionDismissedError",s="DevicesNotFoundError";function u(r){const d=new RegExp("^([a-zA-Z0-9]{16})$");(!r||d.test(r))&&window.navigator.webkitGetUserMedia({audio:{deviceId:{exact:r}},video:!1},c=>{c.getTracks().forEach(f=>{f.stop()}),window.top.postMessage({accessGranted:!0,type:"mic"},"*")},c=>{const f=c.name===i?null:!1,e=c.name!==s;window.top.postMessage({accessGranted:f,type:"mic",micsAvailable:e},"*")})}window.addEventListener("message",r=>{switch(r.data.type){case t.i:u(r.data.deviceID);break;default:break}},!1)}});