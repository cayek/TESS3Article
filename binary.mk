.PHONY: push_binary pull_binary rm_binary

BINARY_FILE_ALL = $(wildcard Figure4/Experiments/Results/*.RData Figure3/Experiments/Results/*.RData Figure2/Experiments/Results/*.RData Figure1/Experiments/Results/*.RData Figure5/Experiments/Results/TAIR9/*.RData Figure5/Experiments/Results/TAIR8/*.RData Data/AthalianaGegMapLines/call_method_75/*.RData)
# filter too big file
BINARY_FILE = $(filter-out Figure5/Experiments/Results/TAIR9/tess3.K110.rep5.RData, $(BINARY_FILE_ALL))

push_binary:
	git checkout binary
	git add $(BINARY_FILE)
	git commit -m "binary"
	git push -f binary_remote binary:master
	git reset --soft HEAD~
	git reset
	git checkout master

pull_binary:
	git fetch git@github.com:cayek/TESS3ArticleBinary.git master --depth=1
	git merge FETCH_HEAD -m "binary"
	git reset --soft HEAD~
	git reset

rm_binary:
	rm -i $(BINARY_FILE)
