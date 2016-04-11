#!/bin/sh -e
for branch in `git branch | sed 's/..//'`; do
  echo git checkout $branch
  git checkout $branch

  echo "old HEAD: `git-hash`"

  for new_root in "${@:-HEAD}"; do
    new_root_hash=`git log -n1 --format=%H "$new_root"`
    echo "$new_root_hash"
  done >.git/info/grafts
  git filter-branch -f
  echo "new HEAD: `git-hash`"
done

rm .git/info/grafts
confirm git-gc-all-ferocious $AGGRESSIVE # --aggressive
