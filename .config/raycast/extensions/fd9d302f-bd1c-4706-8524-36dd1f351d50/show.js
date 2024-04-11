"use strict";var In=Object.create;var K=Object.defineProperty;var En=Object.getOwnPropertyDescriptor;var Cn=Object.getOwnPropertyNames;var Tn=Object.getPrototypeOf,Pn=Object.prototype.hasOwnProperty;var l=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports),An=(e,t)=>{for(var r in t)K(e,r,{get:t[r],enumerable:!0})},Re=(e,t,r,n)=>{if(t&&typeof t=="object"||typeof t=="function")for(let o of Cn(t))!Pn.call(e,o)&&o!==r&&K(e,o,{get:()=>t[o],enumerable:!(n=En(t,o))||n.enumerable});return e};var ae=(e,t,r)=>(r=e!=null?In(Tn(e)):{},Re(t||!e||!e.__esModule?K(r,"default",{value:e,enumerable:!0}):r,e)),Gn=e=>Re(K({},"__esModule",{value:!0}),e);var Me=l((Ro,Le)=>{Le.exports=qe;qe.sync=kn;var Oe=require("fs");function $n(e,t){var r=t.pathExt!==void 0?t.pathExt:process.env.PATHEXT;if(!r||(r=r.split(";"),r.indexOf("")!==-1))return!0;for(var n=0;n<r.length;n++){var o=r[n].toLowerCase();if(o&&e.substr(-o.length).toLowerCase()===o)return!0}return!1}function Ne(e,t,r){return!e.isSymbolicLink()&&!e.isFile()?!1:$n(t,r)}function qe(e,t,r){Oe.stat(e,function(n,o){r(n,n?!1:Ne(o,e,t))})}function kn(e,t){return Ne(Oe.statSync(e),e,t)}});var Ue=l((Oo,Fe)=>{Fe.exports=Be;Be.sync=Rn;var He=require("fs");function Be(e,t,r){He.stat(e,function(n,o){r(n,n?!1:je(o,t))})}function Rn(e,t){return je(He.statSync(e),t)}function je(e,t){return e.isFile()&&On(e,t)}function On(e,t){var r=e.mode,n=e.uid,o=e.gid,s=t.uid!==void 0?t.uid:process.getuid&&process.getuid(),i=t.gid!==void 0?t.gid:process.getgid&&process.getgid(),a=parseInt("100",8),u=parseInt("010",8),c=parseInt("001",8),f=a|u,w=r&c||r&u&&o===i||r&a&&n===s||r&f&&s===0;return w}});var We=l((qo,De)=>{var No=require("fs"),X;process.platform==="win32"||global.TESTING_WINDOWS?X=Me():X=Ue();De.exports=ce;ce.sync=Nn;function ce(e,t,r){if(typeof t=="function"&&(r=t,t={}),!r){if(typeof Promise!="function")throw new TypeError("callback not provided");return new Promise(function(n,o){ce(e,t||{},function(s,i){s?o(s):n(i)})})}X(e,t||{},function(n,o){n&&(n.code==="EACCES"||t&&t.ignoreErrors)&&(n=null,o=!1),r(n,o)})}function Nn(e,t){try{return X.sync(e,t||{})}catch(r){if(t&&t.ignoreErrors||r.code==="EACCES")return!1;throw r}}});var Ze=l((Lo,Qe)=>{var C=process.platform==="win32"||process.env.OSTYPE==="cygwin"||process.env.OSTYPE==="msys",Ke=require("path"),qn=C?";":":",Xe=We(),Ve=e=>Object.assign(new Error(`not found: ${e}`),{code:"ENOENT"}),ze=(e,t)=>{let r=t.colon||qn,n=e.match(/\//)||C&&e.match(/\\/)?[""]:[...C?[process.cwd()]:[],...(t.path||process.env.PATH||"").split(r)],o=C?t.pathExt||process.env.PATHEXT||".EXE;.CMD;.BAT;.COM":"",s=C?o.split(r):[""];return C&&e.indexOf(".")!==-1&&s[0]!==""&&s.unshift(""),{pathEnv:n,pathExt:s,pathExtExe:o}},Ye=(e,t,r)=>{typeof t=="function"&&(r=t,t={}),t||(t={});let{pathEnv:n,pathExt:o,pathExtExe:s}=ze(e,t),i=[],a=c=>new Promise((f,w)=>{if(c===n.length)return t.all&&i.length?f(i):w(Ve(e));let m=n[c],y=/^".*"$/.test(m)?m.slice(1,-1):m,S=Ke.join(y,e),g=!y&&/^\.[\\\/]/.test(e)?e.slice(0,2)+S:S;f(u(g,c,0))}),u=(c,f,w)=>new Promise((m,y)=>{if(w===o.length)return m(a(f+1));let S=o[w];Xe(c+S,{pathExt:s},(g,E)=>{if(!g&&E)if(t.all)i.push(c+S);else return m(c+S);return m(u(c,f,w+1))})});return r?a(0).then(c=>r(null,c),r):a(0)},Ln=(e,t)=>{t=t||{};let{pathEnv:r,pathExt:n,pathExtExe:o}=ze(e,t),s=[];for(let i=0;i<r.length;i++){let a=r[i],u=/^".*"$/.test(a)?a.slice(1,-1):a,c=Ke.join(u,e),f=!u&&/^\.[\\\/]/.test(e)?e.slice(0,2)+c:c;for(let w=0;w<n.length;w++){let m=f+n[w];try{if(Xe.sync(m,{pathExt:o}))if(t.all)s.push(m);else return m}catch{}}}if(t.all&&s.length)return s;if(t.nothrow)return null;throw Ve(e)};Qe.exports=Ye;Ye.sync=Ln});var ue=l((Mo,le)=>{"use strict";var Je=(e={})=>{let t=e.env||process.env;return(e.platform||process.platform)!=="win32"?"PATH":Object.keys(t).reverse().find(n=>n.toUpperCase()==="PATH")||"Path"};le.exports=Je;le.exports.default=Je});var rt=l((Ho,nt)=>{"use strict";var et=require("path"),Mn=Ze(),Hn=ue();function tt(e,t){let r=e.options.env||process.env,n=process.cwd(),o=e.options.cwd!=null,s=o&&process.chdir!==void 0&&!process.chdir.disabled;if(s)try{process.chdir(e.options.cwd)}catch{}let i;try{i=Mn.sync(e.command,{path:r[Hn({env:r})],pathExt:t?et.delimiter:void 0})}catch{}finally{s&&process.chdir(n)}return i&&(i=et.resolve(o?e.options.cwd:"",i)),i}function Bn(e){return tt(e)||tt(e,!0)}nt.exports=Bn});var ot=l((Bo,fe)=>{"use strict";var de=/([()\][%!^"`<>&|;, *?])/g;function jn(e){return e=e.replace(de,"^$1"),e}function Fn(e,t){return e=`${e}`,e=e.replace(/(\\*)"/g,'$1$1\\"'),e=e.replace(/(\\*)$/,"$1$1"),e=`"${e}"`,e=e.replace(de,"^$1"),t&&(e=e.replace(de,"^$1")),e}fe.exports.command=jn;fe.exports.argument=Fn});var st=l((jo,it)=>{"use strict";it.exports=/^#!(.*)/});var ct=l((Fo,at)=>{"use strict";var Un=st();at.exports=(e="")=>{let t=e.match(Un);if(!t)return null;let[r,n]=t[0].replace(/#! ?/,"").split(" "),o=r.split("/").pop();return o==="env"?n:n?`${o} ${n}`:o}});var ut=l((Uo,lt)=>{"use strict";var pe=require("fs"),Dn=ct();function Wn(e){let r=Buffer.alloc(150),n;try{n=pe.openSync(e,"r"),pe.readSync(n,r,0,150,0),pe.closeSync(n)}catch{}return Dn(r.toString())}lt.exports=Wn});var mt=l((Do,pt)=>{"use strict";var Kn=require("path"),dt=rt(),ft=ot(),Xn=ut(),Vn=process.platform==="win32",zn=/\.(?:com|exe)$/i,Yn=/node_modules[\\/].bin[\\/][^\\/]+\.cmd$/i;function Qn(e){e.file=dt(e);let t=e.file&&Xn(e.file);return t?(e.args.unshift(e.file),e.command=t,dt(e)):e.file}function Zn(e){if(!Vn)return e;let t=Qn(e),r=!zn.test(t);if(e.options.forceShell||r){let n=Yn.test(t);e.command=Kn.normalize(e.command),e.command=ft.command(e.command),e.args=e.args.map(s=>ft.argument(s,n));let o=[e.command].concat(e.args).join(" ");e.args=["/d","/s","/c",`"${o}"`],e.command=process.env.comspec||"cmd.exe",e.options.windowsVerbatimArguments=!0}return e}function Jn(e,t,r){t&&!Array.isArray(t)&&(r=t,t=null),t=t?t.slice(0):[],r=Object.assign({},r);let n={command:e,args:t,options:r,file:void 0,original:{command:e,args:t}};return r.shell?n:Zn(n)}pt.exports=Jn});var yt=l((Wo,ht)=>{"use strict";var me=process.platform==="win32";function we(e,t){return Object.assign(new Error(`${t} ${e.command} ENOENT`),{code:"ENOENT",errno:"ENOENT",syscall:`${t} ${e.command}`,path:e.command,spawnargs:e.args})}function er(e,t){if(!me)return;let r=e.emit;e.emit=function(n,o){if(n==="exit"){let s=wt(o,t,"spawn");if(s)return r.call(e,"error",s)}return r.apply(e,arguments)}}function wt(e,t){return me&&e===1&&!t.file?we(t.original,"spawn"):null}function tr(e,t){return me&&e===1&&!t.file?we(t.original,"spawnSync"):null}ht.exports={hookChildProcess:er,verifyENOENT:wt,verifyENOENTSync:tr,notFoundError:we}});var xt=l((Ko,T)=>{"use strict";var St=require("child_process"),he=mt(),ye=yt();function gt(e,t,r){let n=he(e,t,r),o=St.spawn(n.command,n.args,n.options);return ye.hookChildProcess(o,n),o}function nr(e,t,r){let n=he(e,t,r),o=St.spawnSync(n.command,n.args,n.options);return o.error=o.error||ye.verifyENOENTSync(o.status,n),o}T.exports=gt;T.exports.spawn=gt;T.exports.sync=nr;T.exports._parse=he;T.exports._enoent=ye});var _t=l((Xo,bt)=>{"use strict";bt.exports=e=>{let t=typeof e=="string"?`
`:10,r=typeof e=="string"?"\r":13;return e[e.length-1]===t&&(e=e.slice(0,e.length-1)),e[e.length-1]===r&&(e=e.slice(0,e.length-1)),e}});var Et=l((Vo,L)=>{"use strict";var q=require("path"),vt=ue(),It=e=>{e={cwd:process.cwd(),path:process.env[vt()],execPath:process.execPath,...e};let t,r=q.resolve(e.cwd),n=[];for(;t!==r;)n.push(q.join(r,"node_modules/.bin")),t=r,r=q.resolve(r,"..");let o=q.resolve(e.cwd,e.execPath,"..");return n.push(o),n.concat(e.path).join(q.delimiter)};L.exports=It;L.exports.default=It;L.exports.env=e=>{e={env:process.env,...e};let t={...e.env},r=vt({env:t});return e.path=t[r],t[r]=L.exports(e),t}});var Tt=l((zo,Se)=>{"use strict";var Ct=(e,t)=>{for(let r of Reflect.ownKeys(t))Object.defineProperty(e,r,Object.getOwnPropertyDescriptor(t,r));return e};Se.exports=Ct;Se.exports.default=Ct});var At=l((Yo,z)=>{"use strict";var rr=Tt(),V=new WeakMap,Pt=(e,t={})=>{if(typeof e!="function")throw new TypeError("Expected a function");let r,n=0,o=e.displayName||e.name||"<anonymous>",s=function(...i){if(V.set(s,++n),n===1)r=e.apply(this,i),e=null;else if(t.throw===!0)throw new Error(`Function \`${o}\` can only be called once`);return r};return rr(s,e),V.set(s,n),s};z.exports=Pt;z.exports.default=Pt;z.exports.callCount=e=>{if(!V.has(e))throw new Error(`The given function \`${e.name}\` is not wrapped by the \`onetime\` package`);return V.get(e)}});var Gt=l(Y=>{"use strict";Object.defineProperty(Y,"__esModule",{value:!0});Y.SIGNALS=void 0;var or=[{name:"SIGHUP",number:1,action:"terminate",description:"Terminal closed",standard:"posix"},{name:"SIGINT",number:2,action:"terminate",description:"User interruption with CTRL-C",standard:"ansi"},{name:"SIGQUIT",number:3,action:"core",description:"User interruption with CTRL-\\",standard:"posix"},{name:"SIGILL",number:4,action:"core",description:"Invalid machine instruction",standard:"ansi"},{name:"SIGTRAP",number:5,action:"core",description:"Debugger breakpoint",standard:"posix"},{name:"SIGABRT",number:6,action:"core",description:"Aborted",standard:"ansi"},{name:"SIGIOT",number:6,action:"core",description:"Aborted",standard:"bsd"},{name:"SIGBUS",number:7,action:"core",description:"Bus error due to misaligned, non-existing address or paging error",standard:"bsd"},{name:"SIGEMT",number:7,action:"terminate",description:"Command should be emulated but is not implemented",standard:"other"},{name:"SIGFPE",number:8,action:"core",description:"Floating point arithmetic error",standard:"ansi"},{name:"SIGKILL",number:9,action:"terminate",description:"Forced termination",standard:"posix",forced:!0},{name:"SIGUSR1",number:10,action:"terminate",description:"Application-specific signal",standard:"posix"},{name:"SIGSEGV",number:11,action:"core",description:"Segmentation fault",standard:"ansi"},{name:"SIGUSR2",number:12,action:"terminate",description:"Application-specific signal",standard:"posix"},{name:"SIGPIPE",number:13,action:"terminate",description:"Broken pipe or socket",standard:"posix"},{name:"SIGALRM",number:14,action:"terminate",description:"Timeout or timer",standard:"posix"},{name:"SIGTERM",number:15,action:"terminate",description:"Termination",standard:"ansi"},{name:"SIGSTKFLT",number:16,action:"terminate",description:"Stack is empty or overflowed",standard:"other"},{name:"SIGCHLD",number:17,action:"ignore",description:"Child process terminated, paused or unpaused",standard:"posix"},{name:"SIGCLD",number:17,action:"ignore",description:"Child process terminated, paused or unpaused",standard:"other"},{name:"SIGCONT",number:18,action:"unpause",description:"Unpaused",standard:"posix",forced:!0},{name:"SIGSTOP",number:19,action:"pause",description:"Paused",standard:"posix",forced:!0},{name:"SIGTSTP",number:20,action:"pause",description:'Paused using CTRL-Z or "suspend"',standard:"posix"},{name:"SIGTTIN",number:21,action:"pause",description:"Background process cannot read terminal input",standard:"posix"},{name:"SIGBREAK",number:21,action:"terminate",description:"User interruption with CTRL-BREAK",standard:"other"},{name:"SIGTTOU",number:22,action:"pause",description:"Background process cannot write to terminal output",standard:"posix"},{name:"SIGURG",number:23,action:"ignore",description:"Socket received out-of-band data",standard:"bsd"},{name:"SIGXCPU",number:24,action:"core",description:"Process timed out",standard:"bsd"},{name:"SIGXFSZ",number:25,action:"core",description:"File too big",standard:"bsd"},{name:"SIGVTALRM",number:26,action:"terminate",description:"Timeout or timer",standard:"bsd"},{name:"SIGPROF",number:27,action:"terminate",description:"Timeout or timer",standard:"bsd"},{name:"SIGWINCH",number:28,action:"ignore",description:"Terminal window size changed",standard:"bsd"},{name:"SIGIO",number:29,action:"terminate",description:"I/O is available",standard:"other"},{name:"SIGPOLL",number:29,action:"terminate",description:"Watched event",standard:"other"},{name:"SIGINFO",number:29,action:"ignore",description:"Request for process information",standard:"other"},{name:"SIGPWR",number:30,action:"terminate",description:"Device running out of power",standard:"systemv"},{name:"SIGSYS",number:31,action:"core",description:"Invalid system call",standard:"other"},{name:"SIGUNUSED",number:31,action:"terminate",description:"Invalid system call",standard:"other"}];Y.SIGNALS=or});var ge=l(P=>{"use strict";Object.defineProperty(P,"__esModule",{value:!0});P.SIGRTMAX=P.getRealtimeSignals=void 0;var ir=function(){let e=kt-$t+1;return Array.from({length:e},sr)};P.getRealtimeSignals=ir;var sr=function(e,t){return{name:`SIGRT${t+1}`,number:$t+t,action:"terminate",description:"Application-specific signal (realtime)",standard:"posix"}},$t=34,kt=64;P.SIGRTMAX=kt});var Rt=l(Q=>{"use strict";Object.defineProperty(Q,"__esModule",{value:!0});Q.getSignals=void 0;var ar=require("os"),cr=Gt(),lr=ge(),ur=function(){let e=(0,lr.getRealtimeSignals)();return[...cr.SIGNALS,...e].map(dr)};Q.getSignals=ur;var dr=function({name:e,number:t,description:r,action:n,forced:o=!1,standard:s}){let{signals:{[e]:i}}=ar.constants,a=i!==void 0;return{name:e,number:a?i:t,description:r,supported:a,action:n,forced:o,standard:s}}});var Nt=l(A=>{"use strict";Object.defineProperty(A,"__esModule",{value:!0});A.signalsByNumber=A.signalsByName=void 0;var fr=require("os"),Ot=Rt(),pr=ge(),mr=function(){return(0,Ot.getSignals)().reduce(wr,{})},wr=function(e,{name:t,number:r,description:n,supported:o,action:s,forced:i,standard:a}){return{...e,[t]:{name:t,number:r,description:n,supported:o,action:s,forced:i,standard:a}}},hr=mr();A.signalsByName=hr;var yr=function(){let e=(0,Ot.getSignals)(),t=pr.SIGRTMAX+1,r=Array.from({length:t},(n,o)=>Sr(o,e));return Object.assign({},...r)},Sr=function(e,t){let r=gr(e,t);if(r===void 0)return{};let{name:n,description:o,supported:s,action:i,forced:a,standard:u}=r;return{[e]:{name:n,number:e,description:o,supported:s,action:i,forced:a,standard:u}}},gr=function(e,t){let r=t.find(({name:n})=>fr.constants.signals[n]===e);return r!==void 0?r:t.find(n=>n.number===e)},xr=yr();A.signalsByNumber=xr});var Lt=l((ti,qt)=>{"use strict";var{signalsByName:br}=Nt(),_r=({timedOut:e,timeout:t,errorCode:r,signal:n,signalDescription:o,exitCode:s,isCanceled:i})=>e?`timed out after ${t} milliseconds`:i?"was canceled":r!==void 0?`failed with ${r}`:n!==void 0?`was killed with ${n} (${o})`:s!==void 0?`failed with exit code ${s}`:"failed",vr=({stdout:e,stderr:t,all:r,error:n,signal:o,exitCode:s,command:i,escapedCommand:a,timedOut:u,isCanceled:c,killed:f,parsed:{options:{timeout:w}}})=>{s=s===null?void 0:s,o=o===null?void 0:o;let m=o===void 0?void 0:br[o].description,y=n&&n.code,g=`Command ${_r({timedOut:u,timeout:w,errorCode:y,signal:o,signalDescription:m,exitCode:s,isCanceled:c})}: ${i}`,E=Object.prototype.toString.call(n)==="[object Error]",D=E?`${g}
${n.message}`:g,W=[D,t,e].filter(Boolean).join(`
`);return E?(n.originalMessage=n.message,n.message=W):n=new Error(W),n.shortMessage=D,n.command=i,n.escapedCommand=a,n.exitCode=s,n.signal=o,n.signalDescription=m,n.stdout=e,n.stderr=t,r!==void 0&&(n.all=r),"bufferedData"in n&&delete n.bufferedData,n.failed=!0,n.timedOut=!!u,n.isCanceled=c,n.killed=f&&!u,n};qt.exports=vr});var Ht=l((ni,xe)=>{"use strict";var Z=["stdin","stdout","stderr"],Ir=e=>Z.some(t=>e[t]!==void 0),Mt=e=>{if(!e)return;let{stdio:t}=e;if(t===void 0)return Z.map(n=>e[n]);if(Ir(e))throw new Error(`It's not possible to provide \`stdio\` in combination with one of ${Z.map(n=>`\`${n}\``).join(", ")}`);if(typeof t=="string")return t;if(!Array.isArray(t))throw new TypeError(`Expected \`stdio\` to be of type \`string\` or \`Array\`, got \`${typeof t}\``);let r=Math.max(t.length,Z.length);return Array.from({length:r},(n,o)=>t[o])};xe.exports=Mt;xe.exports.node=e=>{let t=Mt(e);return t==="ipc"?"ipc":t===void 0||typeof t=="string"?[t,t,t,"ipc"]:t.includes("ipc")?t:[...t,"ipc"]}});var Bt=l((ri,J)=>{J.exports=["SIGABRT","SIGALRM","SIGHUP","SIGINT","SIGTERM"];process.platform!=="win32"&&J.exports.push("SIGVTALRM","SIGXCPU","SIGXFSZ","SIGUSR2","SIGTRAP","SIGSYS","SIGQUIT","SIGIOT");process.platform==="linux"&&J.exports.push("SIGIO","SIGPOLL","SIGPWR","SIGSTKFLT","SIGUNUSED")});var Wt=l((oi,k)=>{var d=global.process,v=function(e){return e&&typeof e=="object"&&typeof e.removeListener=="function"&&typeof e.emit=="function"&&typeof e.reallyExit=="function"&&typeof e.listeners=="function"&&typeof e.kill=="function"&&typeof e.pid=="number"&&typeof e.on=="function"};v(d)?(jt=require("assert"),G=Bt(),Ft=/^win/i.test(d.platform),M=require("events"),typeof M!="function"&&(M=M.EventEmitter),d.__signal_exit_emitter__?p=d.__signal_exit_emitter__:(p=d.__signal_exit_emitter__=new M,p.count=0,p.emitted={}),p.infinite||(p.setMaxListeners(1/0),p.infinite=!0),k.exports=function(e,t){if(v(global.process)){jt.equal(typeof e,"function","a callback must be provided for exit handler"),$===!1&&be();var r="exit";t&&t.alwaysLast&&(r="afterexit");var n=function(){p.removeListener(r,e),p.listeners("exit").length===0&&p.listeners("afterexit").length===0&&ee()};return p.on(r,e),n}},ee=function(){!$||!v(global.process)||($=!1,G.forEach(function(t){try{d.removeListener(t,te[t])}catch{}}),d.emit=ne,d.reallyExit=_e,p.count-=1)},k.exports.unload=ee,I=function(t,r,n){p.emitted[t]||(p.emitted[t]=!0,p.emit(t,r,n))},te={},G.forEach(function(e){te[e]=function(){if(v(global.process)){var r=d.listeners(e);r.length===p.count&&(ee(),I("exit",null,e),I("afterexit",null,e),Ft&&e==="SIGHUP"&&(e="SIGINT"),d.kill(d.pid,e))}}}),k.exports.signals=function(){return G},$=!1,be=function(){$||!v(global.process)||($=!0,p.count+=1,G=G.filter(function(t){try{return d.on(t,te[t]),!0}catch{return!1}}),d.emit=Dt,d.reallyExit=Ut)},k.exports.load=be,_e=d.reallyExit,Ut=function(t){v(global.process)&&(d.exitCode=t||0,I("exit",d.exitCode,null),I("afterexit",d.exitCode,null),_e.call(d,d.exitCode))},ne=d.emit,Dt=function(t,r){if(t==="exit"&&v(global.process)){r!==void 0&&(d.exitCode=r);var n=ne.apply(this,arguments);return I("exit",d.exitCode,null),I("afterexit",d.exitCode,null),n}else return ne.apply(this,arguments)}):k.exports=function(){};var jt,G,Ft,M,p,ee,I,te,$,be,_e,Ut,ne,Dt});var Xt=l((ii,Kt)=>{"use strict";var Er=require("os"),Cr=Wt(),Tr=1e3*5,Pr=(e,t="SIGTERM",r={})=>{let n=e(t);return Ar(e,t,r,n),n},Ar=(e,t,r,n)=>{if(!Gr(t,r,n))return;let o=kr(r),s=setTimeout(()=>{e("SIGKILL")},o);s.unref&&s.unref()},Gr=(e,{forceKillAfterTimeout:t},r)=>$r(e)&&t!==!1&&r,$r=e=>e===Er.constants.signals.SIGTERM||typeof e=="string"&&e.toUpperCase()==="SIGTERM",kr=({forceKillAfterTimeout:e=!0})=>{if(e===!0)return Tr;if(!Number.isFinite(e)||e<0)throw new TypeError(`Expected the \`forceKillAfterTimeout\` option to be a non-negative integer, got \`${e}\` (${typeof e})`);return e},Rr=(e,t)=>{e.kill()&&(t.isCanceled=!0)},Or=(e,t,r)=>{e.kill(t),r(Object.assign(new Error("Timed out"),{timedOut:!0,signal:t}))},Nr=(e,{timeout:t,killSignal:r="SIGTERM"},n)=>{if(t===0||t===void 0)return n;let o,s=new Promise((a,u)=>{o=setTimeout(()=>{Or(e,r,u)},t)}),i=n.finally(()=>{clearTimeout(o)});return Promise.race([s,i])},qr=({timeout:e})=>{if(e!==void 0&&(!Number.isFinite(e)||e<0))throw new TypeError(`Expected the \`timeout\` option to be a non-negative integer, got \`${e}\` (${typeof e})`)},Lr=async(e,{cleanup:t,detached:r},n)=>{if(!t||r)return n;let o=Cr(()=>{e.kill()});return n.finally(()=>{o()})};Kt.exports={spawnedKill:Pr,spawnedCancel:Rr,setupTimeout:Nr,validateTimeout:qr,setExitHandler:Lr}});var zt=l((si,Vt)=>{"use strict";var b=e=>e!==null&&typeof e=="object"&&typeof e.pipe=="function";b.writable=e=>b(e)&&e.writable!==!1&&typeof e._write=="function"&&typeof e._writableState=="object";b.readable=e=>b(e)&&e.readable!==!1&&typeof e._read=="function"&&typeof e._readableState=="object";b.duplex=e=>b.writable(e)&&b.readable(e);b.transform=e=>b.duplex(e)&&typeof e._transform=="function";Vt.exports=b});var Qt=l((ai,Yt)=>{"use strict";var{PassThrough:Mr}=require("stream");Yt.exports=e=>{e={...e};let{array:t}=e,{encoding:r}=e,n=r==="buffer",o=!1;t?o=!(r||n):r=r||"utf8",n&&(r=null);let s=new Mr({objectMode:o});r&&s.setEncoding(r);let i=0,a=[];return s.on("data",u=>{a.push(u),o?i=a.length:i+=u.length}),s.getBufferedValue=()=>t?a:n?Buffer.concat(a,i):a.join(""),s.getBufferedLength=()=>i,s}});var Zt=l((ci,H)=>{"use strict";var{constants:Hr}=require("buffer"),Br=require("stream"),{promisify:jr}=require("util"),Fr=Qt(),Ur=jr(Br.pipeline),re=class extends Error{constructor(){super("maxBuffer exceeded"),this.name="MaxBufferError"}};async function ve(e,t){if(!e)throw new Error("Expected a stream");t={maxBuffer:1/0,...t};let{maxBuffer:r}=t,n=Fr(t);return await new Promise((o,s)=>{let i=a=>{a&&n.getBufferedLength()<=Hr.MAX_LENGTH&&(a.bufferedData=n.getBufferedValue()),s(a)};(async()=>{try{await Ur(e,n),o()}catch(a){i(a)}})(),n.on("data",()=>{n.getBufferedLength()>r&&i(new re)})}),n.getBufferedValue()}H.exports=ve;H.exports.buffer=(e,t)=>ve(e,{...t,encoding:"buffer"});H.exports.array=(e,t)=>ve(e,{...t,array:!0});H.exports.MaxBufferError=re});var en=l((li,Jt)=>{"use strict";var{PassThrough:Dr}=require("stream");Jt.exports=function(){var e=[],t=new Dr({objectMode:!0});return t.setMaxListeners(0),t.add=r,t.isEmpty=n,t.on("unpipe",o),Array.prototype.slice.call(arguments).forEach(r),t;function r(s){return Array.isArray(s)?(s.forEach(r),this):(e.push(s),s.once("end",o.bind(null,s)),s.once("error",t.emit.bind(t,"error")),s.pipe(t,{end:!1}),this)}function n(){return e.length==0}function o(s){e=e.filter(function(i){return i!==s}),!e.length&&t.readable&&t.end()}}});var on=l((ui,rn)=>{"use strict";var nn=zt(),tn=Zt(),Wr=en(),Kr=(e,t)=>{t===void 0||e.stdin===void 0||(nn(t)?t.pipe(e.stdin):e.stdin.end(t))},Xr=(e,{all:t})=>{if(!t||!e.stdout&&!e.stderr)return;let r=Wr();return e.stdout&&r.add(e.stdout),e.stderr&&r.add(e.stderr),r},Ie=async(e,t)=>{if(e){e.destroy();try{return await t}catch(r){return r.bufferedData}}},Ee=(e,{encoding:t,buffer:r,maxBuffer:n})=>{if(!(!e||!r))return t?tn(e,{encoding:t,maxBuffer:n}):tn.buffer(e,{maxBuffer:n})},Vr=async({stdout:e,stderr:t,all:r},{encoding:n,buffer:o,maxBuffer:s},i)=>{let a=Ee(e,{encoding:n,buffer:o,maxBuffer:s}),u=Ee(t,{encoding:n,buffer:o,maxBuffer:s}),c=Ee(r,{encoding:n,buffer:o,maxBuffer:s*2});try{return await Promise.all([i,a,u,c])}catch(f){return Promise.all([{error:f,signal:f.signal,timedOut:f.timedOut},Ie(e,a),Ie(t,u),Ie(r,c)])}},zr=({input:e})=>{if(nn(e))throw new TypeError("The `input` option cannot be a stream in sync mode")};rn.exports={handleInput:Kr,makeAllStream:Xr,getSpawnedResult:Vr,validateInputSync:zr}});var an=l((di,sn)=>{"use strict";var Yr=(async()=>{})().constructor.prototype,Qr=["then","catch","finally"].map(e=>[e,Reflect.getOwnPropertyDescriptor(Yr,e)]),Zr=(e,t)=>{for(let[r,n]of Qr){let o=typeof t=="function"?(...s)=>Reflect.apply(n.value,t(),s):n.value.bind(t);Reflect.defineProperty(e,r,{...n,value:o})}return e},Jr=e=>new Promise((t,r)=>{e.on("exit",(n,o)=>{t({exitCode:n,signal:o})}),e.on("error",n=>{r(n)}),e.stdin&&e.stdin.on("error",n=>{r(n)})});sn.exports={mergePromise:Zr,getSpawnedPromise:Jr}});var un=l((fi,ln)=>{"use strict";var cn=(e,t=[])=>Array.isArray(t)?[e,...t]:[e],eo=/^[\w.-]+$/,to=/"/g,no=e=>typeof e!="string"||eo.test(e)?e:`"${e.replace(to,'\\"')}"`,ro=(e,t)=>cn(e,t).join(" "),oo=(e,t)=>cn(e,t).map(r=>no(r)).join(" "),io=/ +/g,so=e=>{let t=[];for(let r of e.trim().split(io)){let n=t[t.length-1];n&&n.endsWith("\\")?t[t.length-1]=`${n.slice(0,-1)} ${r}`:t.push(r)}return t};ln.exports={joinCommand:ro,getEscapedCommand:oo,parseCommand:so}});var yn=l((pi,R)=>{"use strict";var ao=require("path"),Ce=require("child_process"),co=xt(),lo=_t(),uo=Et(),fo=At(),oe=Lt(),fn=Ht(),{spawnedKill:po,spawnedCancel:mo,setupTimeout:wo,validateTimeout:ho,setExitHandler:yo}=Xt(),{handleInput:So,getSpawnedResult:go,makeAllStream:xo,validateInputSync:bo}=on(),{mergePromise:dn,getSpawnedPromise:_o}=an(),{joinCommand:pn,parseCommand:mn,getEscapedCommand:wn}=un(),vo=1e3*1e3*100,Io=({env:e,extendEnv:t,preferLocal:r,localDir:n,execPath:o})=>{let s=t?{...process.env,...e}:e;return r?uo.env({env:s,cwd:n,execPath:o}):s},hn=(e,t,r={})=>{let n=co._parse(e,t,r);return e=n.command,t=n.args,r=n.options,r={maxBuffer:vo,buffer:!0,stripFinalNewline:!0,extendEnv:!0,preferLocal:!1,localDir:r.cwd||process.cwd(),execPath:process.execPath,encoding:"utf8",reject:!0,cleanup:!0,all:!1,windowsHide:!0,...r},r.env=Io(r),r.stdio=fn(r),process.platform==="win32"&&ao.basename(e,".exe")==="cmd"&&t.unshift("/q"),{file:e,args:t,options:r,parsed:n}},B=(e,t,r)=>typeof t!="string"&&!Buffer.isBuffer(t)?r===void 0?void 0:"":e.stripFinalNewline?lo(t):t,ie=(e,t,r)=>{let n=hn(e,t,r),o=pn(e,t),s=wn(e,t);ho(n.options);let i;try{i=Ce.spawn(n.file,n.args,n.options)}catch(y){let S=new Ce.ChildProcess,g=Promise.reject(oe({error:y,stdout:"",stderr:"",all:"",command:o,escapedCommand:s,parsed:n,timedOut:!1,isCanceled:!1,killed:!1}));return dn(S,g)}let a=_o(i),u=wo(i,n.options,a),c=yo(i,n.options,u),f={isCanceled:!1};i.kill=po.bind(null,i.kill.bind(i)),i.cancel=mo.bind(null,i,f);let m=fo(async()=>{let[{error:y,exitCode:S,signal:g,timedOut:E},D,W,vn]=await go(i,n.options,c),Ae=B(n.options,D),Ge=B(n.options,W),$e=B(n.options,vn);if(y||S!==0||g!==null){let ke=oe({error:y,exitCode:S,signal:g,stdout:Ae,stderr:Ge,all:$e,command:o,escapedCommand:s,parsed:n,timedOut:E,isCanceled:f.isCanceled,killed:i.killed});if(!n.options.reject)return ke;throw ke}return{command:o,escapedCommand:s,exitCode:0,stdout:Ae,stderr:Ge,all:$e,failed:!1,timedOut:!1,isCanceled:!1,killed:!1}});return So(i,n.options.input),i.all=xo(i,n.options),dn(i,m)};R.exports=ie;R.exports.sync=(e,t,r)=>{let n=hn(e,t,r),o=pn(e,t),s=wn(e,t);bo(n.options);let i;try{i=Ce.spawnSync(n.file,n.args,n.options)}catch(c){throw oe({error:c,stdout:"",stderr:"",all:"",command:o,escapedCommand:s,parsed:n,timedOut:!1,isCanceled:!1,killed:!1})}let a=B(n.options,i.stdout,i.error),u=B(n.options,i.stderr,i.error);if(i.error||i.status!==0||i.signal!==null){let c=oe({stdout:a,stderr:u,error:i.error,signal:i.signal,exitCode:i.status,command:o,escapedCommand:s,parsed:n,timedOut:i.error&&i.error.code==="ETIMEDOUT",isCanceled:!1,killed:i.signal!==null});if(!n.options.reject)return c;throw c}return{command:o,escapedCommand:s,exitCode:0,stdout:a,stderr:u,failed:!1,timedOut:!1,isCanceled:!1,killed:!1}};R.exports.command=(e,t)=>{let[r,...n]=mn(e);return ie(r,n,t)};R.exports.commandSync=(e,t)=>{let[r,...n]=mn(e);return ie.sync(r,n,t)};R.exports.node=(e,t,r={})=>{t&&!Array.isArray(t)&&typeof t=="object"&&(r=t,t=[]);let n=fn.node(r),o=process.execArgv.filter(a=>!a.startsWith("--inspect")),{nodePath:s=process.execPath,nodeOptions:i=o}=r;return ie(s,[...i,e,...Array.isArray(t)?t:[]],{...r,stdin:void 0,stdout:void 0,stderr:void 0,stdio:n,shell:!1})}});var $o={};An($o,{default:()=>_n,onlyName:()=>bn,openIn:()=>N,terminal:()=>se});module.exports=Gn($o);var h=require("@raycast/api"),U=require("react");var Sn=ae(require("node:process"),1),gn=ae(yn(),1);async function _(e){if(Sn.default.platform!=="darwin")throw new Error("macOS only");let{stdout:t}=await(0,gn.default)("osascript",["-e",e]);return t}var F=require("@raycast/api"),O=ae(require("fs")),Eo=(0,F.getPreferenceValues)(),j=Eo.sshConfig.replace("~",process.env.HOME);function Co(e){let r=O.readFileSync(e,"utf8").split(`
`),n=[],o=null;for(let s of r){let i=s.trim();if(!(i.startsWith("#")||i==="")){if(i.startsWith("Host ")&&i!=="Host *")o!==null&&n.push(o),o={id:n.length.toString(),address:"",name:i.substring(5),user:""};else if(o!==null){let a=i.indexOf(" "),u=i.substring(0,a),c=i.substring(a+1);switch(u){case"HostName":o.address=c;break;case"User":o.user=c;break;case"Port":o.port=c;break;case"IdentityFile":o.sshKey=c;break;case"HostNameKey":break;case"RemoteCommand":o.command=c;break;default:break}}}}return o!==null&&n.push(o),n}function To(e,t){let r="";for(let n of t)r+=`Host ${n.name}
`,r+=`  HostName ${n.address}
`,n.user&&(r+=`  User ${n.user}
`),n.port&&(r+=`  Port ${n.port}
`),n.sshKey&&(r+=`  IdentityFile ${n.sshKey}
`),n.command&&(r+=`  RemoteCommand ${n.command}
`),r+=`
`;O.writeFileSync(e,r.trimEnd())}async function Te(){switch(j){case"localStorage":{let{connections:e}=await F.LocalStorage.allItems();return e?JSON.parse(e):[]}default:return O.existsSync(j)?Co(j):[]}}async function xn(e){switch(j){case"localStorage":await F.LocalStorage.setItem("connections",JSON.stringify(e));break;default:To(j,e);break}}var x=require("react/jsx-runtime"),Pe=(0,h.getPreferenceValues)(),se=Pe.terminal,N=Pe.openin,bn=Pe.onlyname;async function Po(e){let t;if(bn)t=["ssh",e.name].join(" ");else{let i="";e.sshKey&&(i=`-i ${e.sshKey} `);let a="";e.port&&(a=`-p ${e.port} `);let u="",c="";e.command&&(u=`\\"${e.command}\\" `,c="-t");let f=e.address;e.user&&(f=`${encodeURIComponent(e.user)}@${f}`),t=["ssh",c,i,f,a,u].filter(Boolean).join(" ")}let r=`
      -- For the latest version:
      -- https://github.com/DavidMChan/custom-alfred-warp-scripts

      -- Set this property to true to always open in a new window
      property open_in_new_window : ${N=="newWindow"}

      -- Set this property to true to always open in a new tab
      property open_in_new_tab : ${N=="newTab"}

      -- Don't change this :)
      property opened_new_window : false

      -- Handlers
      on new_window()
          tell application "System Events" to tell process "Warp"
              click menu item "New Window" of menu "File" of menu bar 1
              set frontmost to true
          end tell
          delay 0.5
      end new_window

      on new_tab()
          tell application "System Events" to tell process "Warp"
              click menu item "New Tab" of menu "File" of menu bar 1
              set frontmost to true
          end tell
      end new_tab

      on call_forward()
          tell application "Warp" to activate
      end call_forward

      on is_running()
          application "Warp" is running
      end is_running

      on has_windows()
          if not is_running() then return false
          tell application "System Events"
              if windows of process "Warp" is {} then return false
          end tell
          true
      end has_windows

      on send_text(custom_text)
          tell application "System Events"
              keystroke custom_text
          end tell
      end send_text


      -- Main
      if not is_running() then
          call_forward()
          set opened_new_window to true
      else
          call_forward()
          set opened_new_window to false
      end if

      if has_windows() then
          if open_in_new_window and not opened_new_window then
              new_window()
          else if open_in_new_tab and not opened_new_window then
              new_tab()
          end if
      else
          new_window()
      end if


      -- Make sure a window exists before we continue, or the write may fail
      repeat until has_windows()
          delay 0.5
      end repeat
      delay 0.5

      send_text("${t}")
      call_forward()
  `,n=`
    tell application "Terminal"
      do script ""
      activate
      set position of front window to {1, 1}
      set shell to do script "${t}" in window 1
    end tell

    tell application "System Events" to tell process "Terminal"
        set frontmost to true
        windows where title contains "bash"
        if result is not {} then perform action "AXRaise" of item 1 of result
    end tell
  `,o=`
    -- Set this property to true to open in a new window instead of a new tab
    property open_in_new_window : ${N=="newWindow"}

    on new_window()
    	tell application "iTerm" to create window with default profile
    end new_window

    on new_tab()
    	tell application "iTerm" to tell the first window to create tab with default profile
    end new_tab

    on call_forward()
    	tell application "iTerm" to activate
    end call_forward

    on is_running()
    	application "iTerm" is running
    end is_running

    on is_processing()
    	tell application "iTerm" to tell the first window to tell current session to get is processing
    end is_processing

    on has_windows()
    	if not is_running() then return false
    	if windows of application "iTerm" is {} then return false
    	true
    end has_windows

    on send_text(custom_text)
    	tell application "iTerm" to tell the first window to tell current session to write text custom_text
    end send_text

    -- Main
    if has_windows() then
      if open_in_new_window then
        new_window()
      else
        new_tab()
      end if
    else
    	-- If iTerm is not running and we tell it to create a new window, we get two
    	-- One from opening the application, and the other from the command
    	if is_running() then
    		new_window()
    	else
    		call_forward()
    	end if
    end if

    -- Make sure a window exists before we continue, or the write may fail
    repeat until has_windows()
    	delay 0.01
    end repeat

    send_text("${t}")
    call_forward()
  `,s=`
  -- Set this property to true to always open in a new window
  property open_in_new_window : ${N=="newWindow"}

  -- Set this property to true to always open in a new tab
  property open_in_new_tab : ${N=="newTab"}

  -- Don't change this :)
  property opened_new_window : false

  -- Handlers
  on new_window()
      tell application "Alacritty"
          activate
          delay 0.5
          tell application "System Events" to tell process "Alacritty"
              keystroke "n" using {command down}
          end tell
      end tell
      delay 0.5
  end new_window

  on new_tab()
      tell application "Alacritty"
          activate
          tell application "System Events" to tell process "Alacritty"
              keystroke "t" using {command down}
          end tell
      end tell
      delay 0.5
  end new_tab

  on call_forward()
      tell application "Alacritty" to activate
      tell application "Alacritty" to reopen
  end call_forward

  on is_running()
      application "Alacritty" is running
  end is_running

  on has_windows()
      if not is_running() then return false
      tell application "System Events"
          if windows of process "Alacritty" is {} then return false
      end tell
      true
  end has_windows

  on send_text(custom_text)
      tell application "System Events" to tell process "Alacritty"
          keystroke custom_text
      end tell
  end send_text


  -- Main
  if not is_running() then
      call_forward()
      set opened_new_window to true
  else
      call_forward()
      set opened_new_window to false
  end if

  if not has_windows() then
    tell application "Alacritty" to reopen
    delay 0.2
    tell application "Alacritty" to activate
  end if

  if open_in_new_window and not opened_new_window then
      new_window()
  else if open_in_new_tab and not opened_new_window then
      new_tab()
  end if


  -- Make sure a window exists before we continue, or the write may fail
  repeat until has_windows()
      delay 0.5
  end repeat
  delay 0.5
  send_text("${t}
") -- Enter at the end of string
  call_forward()
  `;if(se=="iTerm")try{await _(o)}catch(i){await _(n),console.log(i)}else if(se=="Warp")try{await _(r)}catch(i){await _(n),console.log(i)}else if(se=="Alacritty")try{await(0,h.closeMainWindow)(),await _(s)}catch(i){await _(n),console.log(i)}else await _(n);await(0,h.showHUD)("Success \u2705")}function _n(){let[e,t]=(0,U.useState)([]),[r,n]=(0,U.useState)(!0);(0,U.useEffect)(()=>{(async()=>{n(!0);let s=await Te();t(s),n(!1)})()},[]);async function o(s){let i=await Te();i=i.filter(a=>a.id!==s.id),await xn(i),t(i)}return(0,x.jsx)(h.List,{isLoading:r,children:e.map(s=>(0,x.jsx)(h.List.Item,{actions:(0,x.jsx)(Ao,{item:s,onItemRemove:o}),id:s.id,title:s.name,subtitle:Go(s)},s.name))})}function Ao({item:e,onItemRemove:t}){return(0,x.jsx)(x.Fragment,{children:(0,x.jsxs)(h.ActionPanel,{children:[(0,x.jsx)(h.ActionPanel.Item,{title:"Connect",onAction:async()=>{await Po(e)}}),(0,x.jsx)(h.ActionPanel.Item,{title:"Remove",onAction:async()=>{await t(e)}})]})})}function Go(e){return`${e.user?e.user+"@":""}${e.address}${e.port?" Port: "+e.port:""}${e.sshKey?" SSH Key: "+e.sshKey:""} ${e.command?' Command: "'+e.command+'"':""}`}0&&(module.exports={onlyName,openIn,terminal});
