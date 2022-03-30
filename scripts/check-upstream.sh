#!/usr/bin/env bash
exit "$(curl -s https://api.github.com/repos/"$1"/commits/"$2" | jq -r "((now - (.commit.author.date | fromdateiso8601) )  / (60*60*24)  | trunc)")"