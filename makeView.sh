#!/bin/bash

# Make a view

VAR="$1"
while ! [ -z "${VAR//[a-zA-Z0-9]}" ] || [ -z $VAR ]
do
  echo ""
  echo "# ###########################################"
    echo "# "
    echo "# ERROR Meteor need to set a VIEWNAME ! "
    echo "# Enter a valid value or only alphanumeric lowercase characters"
    echo "# "
  echo "# ###########################################"
  echo ""
  echo "$ ./makeview.sh VIEWNAME"
  echo ""
    read VAR
done

MAJVAR="$(tr '[:lower:]' '[:upper:]' <<< ${VAR:0:1})${VAR:1}"

mkdir "client/views/$VAR"

echo "
<template name=\"$VAR\">
	<div class=\"container\">
		<h1>$MAJVAR</h1>
	</div>
</template>
" >> "client/views/$VAR/$VAR.html"

echo "console.log('[CLIENT] Loading $VAR.js ...');

"$MAJVAR"Controller = AppController.extend({
  // template: '$VAR',

  // layoutTemplate: 'layout',
  yieldRegions: {
    'navbar': {to: 'header'},
    'footer': {to: 'footer'},
  },

  waitOn: function () {
    console.log(this.url);
    console.log('Method waitOn');
  },

  /**
   * @desc : Called when the route is first run. It is not called again 
   * if the route reruns because of a computation invalidation.
   */
  onRun: function () {
    console.log('Method onRun');
    this.next();
  },

  /**
   * @desc : Called if the route reruns because its computation is invalidated.
   */
  onRerun: function () {
    console.log('Method onRerun');
    this.next();
  },

  load: function () {
    console.log('Method load +-------------------------------');
    this.next();
  },

  /**
   * @desc : Called before the route or \"action\" function is run. These hooks 
   * behave specially. If you want to continue calling the next function you 
   * must call this.next(). If you don't, downstream onBeforeAction hooks and 
   * your action function will not be called.
   */
  onBeforeAction: function () {
    console.log('Method onBeforeAction');
    this.next();
  },

  before: function () {
    console.log('Method before');
    this.next();
  },

  action: function () {
    console.log('Method action');
    this.render();
  },

  /**
   * @desc : Called after your route/action function has run or had a chance to run. 
   * These hooks behave like normal hooks and you don't need to call this.next() 
   * to move from one to the next.
   */
  onAfterAction: function () {
    console.log('Method onAfterAction');
  },

  after: function () {
    console.log('Method after');
  },

  /**
   * @desc : Access this data from the associated template.
   */
  data: function () {
    console.log('Method data');
    return {};
  },

  /**
   * @desc : Called when the route is stopped, typically right before a new route is run.
   */
  /*
  stop: function () {
    console.log('Method stop');
    // return false;
    this.next();
  },
  */

  /**
   * @desc : This is called when you navigate to a new route
   */
  unload: function () {
    console.log('Method unload -------------------------------');
    console.log('');
    // this.next();
    return '';
  },

});
" >> "client/views/$VAR/$VAR.js"