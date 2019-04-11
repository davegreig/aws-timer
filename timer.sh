#!/bin/bash

PATTERN="prod-"

function currentUnixTime() {
  (date +%s)
}

function timeRemaining() {
  if [[ -n $AWS_SESSION_EXPIRES_UNIX_TIME ]]
    then expr $( (expr $AWS_SESSION_EXPIRES_UNIX_TIME - $( (currentUnixTime) )) ) / 60
  fi
}

function awsTimeRemaining() {
  if [[ $(timeRemaining) -gt 0 && $(timeRemaining) -le 5 ]]
    then echo -n "%F{160}%B$\uf56a (timeRemaining) min%b"
  elif [[ $(timeRemaining) -gt 5 ]]
    then echo -n "%F{000}\uf56a $(timeRemaining) min"
  fi
}

function awsRoleMessage() {
  if [[ $(timeRemaining) -gt 0 && $AWS_ROLE =~ $PATTERN ]]
    then echo -n "%F{231}\ue7ad %F{160}%B\uf071 ${AWS_ROLE}%b"
  elif [[ $(timeRemaining) -gt 5 ]]
    then echo -n "%F{231}\ue7ad %b${AWS_ROLE}"
  fi
}
