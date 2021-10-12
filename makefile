# https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html#Phony-Targets
.PHONY : hugo
.RECIPEPREFIX = -

hugo : openActions open
-  hugo --buildDrafts --source hugo -p 4242 server

hugoP : open # as published; there might be differences as there are isServer queries
-  hugo --environment production --source hugo -p 4242 server

hugoS : openS # staging; without drafts
-  hugo --environment staging --source hugo -p 4242 server

hugoSD : openSD # staging; like production but with drafts
-  hugo --buildDrafts --environment stagingdrafts --source hugo -p 4242 server

c :
-	git add .
-	git commit -m "$m"


# variable definition is executed when needed
# variable can also be set when calling target, e.g.
#    make deploy tag=v0.42
# zum ausprobieren
# tag = $(shell echo DEF_TAG)
tag = $(shell bin/hugo_deployment/gitautotag.sh --minor)

tag : check_on_main
-	echo "created new tag $(tag)"

deploy : check_on_main
-	git push origin main
-	git push origin $(tag)

ERR = $(error error is "not on main branch")
current_branch = $(shell git branch --show-current)

check_on_main :
ifneq ($(current_branch),main)
- echo $(ERR)
endif

open :
-  open http://localhost:4242
openS :
-  open http://localhost:4242/staging
openSD :
-  open http://localhost:4242/stagingdrafts
openGH :
- gh browse
openActions :
- open https://github.com/bkleinen/bkleinen.github.io/actions
openSites:
- open https://home.htw-berlin.de/~kleinen/
- open https://bkleinen.github.io/
- open https://bkleinen.github.io/staging/
- open https://bkleinen.github.io/stagingdrafts/
openI:
- open 	http://localhost:4242/classes/ws2021/info2/
