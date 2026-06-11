Use the Command Line (Safe for Shared Branches)If the web button is unavailable, or you prefer working in the terminal, you can manually issue a revert. This creates a new commit that mirrors and neutralizes the merged changes without altering existing commit history.

1. Switch to your main target branch and sync your local environment:
bash
git checkout main
git pull origin main
2. Open your commit history to locate the merge commit hash: 
bash
git log --oneline

"q" key to exit log

3. Run the revert command. You must include the -m 1 flag to specify that you want to keep the main branch's line of history as the parent:
bash
git revert -m 1 <merge_commit_hash>
4. Save the commit message, then push the new revert commit to your remote server:
bash
git push origin main
