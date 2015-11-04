require('jquery/src/sizzle/dist/sizzle.js');
require('imports?define=>false!qtip2/jquery.qtip.js');
require('jquery-ui/jquery-ui.js');
require('katex/dist/katex.min.js');

require('qtip2/jquery.qtip.css');

$(document).ready(() => $('.tooltip').qtip({attr: 'tooltip', hide: {when: {event: 'unfocus'}}}));
