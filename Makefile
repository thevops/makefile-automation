# source: https://github.com/vizarch/makefile-automation
.RECIPEPREFIX +=
# if make > 4.3 then use: .RECIPEPREFIX := $(.RECIPEPREFIX)<space>
.ONESHELL:
SHELL:=/bin/bash
.SHELLFLAGS := -eu -o pipefail -c # exit if error in pipe

# optionally load env vars from .env
include .env

args=$(filter-out $@,$(MAKECMDGOALS))

##
## ----------------------------------------------------------------------------
##   NAME
## ----------------------------------------------------------------------------
##


#------------------------------------------#
##          Example group
#------------------------------------------#

task-one: ## Simple task
    @echo "This is simple task"


#------------------------------------------#
##
##          Another group
#------------------------------------------#

task-two: ## Print vars from .env file
    @echo $(somevariable)

task-three: ## Print bash variable inside
    @hello="world"
    @echo $$hello

task-four: ## Print args from command line
    @echo "run: make task-four foo bar"
    @echo $(args)

task-five: ## Run command inside
    @get_comment=$$(grep other .env)
    @echo $$get_comment


# -----------------------------   DO NOT CHANGE   -----------------------------
help:
    @grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) \
        | sed -e 's/^.*Makefile://g' \
        | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' \
        | sed -e 's/\[32m##/[33m/'
    @echo

%:      # do not change
    @:    # do not change

.DEFAULT_GOAL := help
