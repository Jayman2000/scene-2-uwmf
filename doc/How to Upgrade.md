# How to Upgrade to a New Version of Scene 2 UWMF

1. Open a terminal emulator. You’ll need to enter the commands for the next
steps into a terminal. If you’re running Windows, make sure that you open a
Git CMD or Git Bash window.
2. Change directory to the root of the Scene 2 UWMF directory:

		cd <path-to-scene-2-uwmf>

3. Make sure that you don’t have any uncommitted changes:
	1. Check to see if you have any uncommitted changes. Run:

			git status

		If you see something like this:

			On branch example-branch nothing to commit, working tree
			clean

		then you don’t have any uncommitted changes. If you see
		something like this:

			On branch example-branch Untracked files: (use "git add
			<file>..." to include in what will be committed)
			project/user_maps/

			nothing added to commit but untracked files present (use
			"git add" to track)

		then you do have uncommitted changes.

	2. If you have any uncommitted changes, then commit them:
		1. Stage any changes you made:

				git add .

		2. Start committing those changes:

				git commit

		3. Write a commit message, save it, and then exit the text
		editor. Here are some tips to help you do that:
			- When you ran the `git commit` command in step 2, a
			  text editor should have opened.
			- The text editor that Git will use depends on your
			  system and Git configuration.
			- The default commit message editor on your system is
			  probably [Vi](https://ex-vi.sourceforge.net/) or
			  something similar.
			- If you’ve never used Vi before, then you will probably
			  find it difficult to use. Hopefully, you’ll find [this
			  page][exit vi] helpful.
			- If you don’t like Git’s default text editor, then [you
			  can always change it.][git default editor]

4. Download any changes that the upstream Scene 2 UWMF project has made:

		git fetch origin

5. Apply those changes to your branch:

		git merge origin/main

6. If running that command opened up a text editor, save the file and then exit
out of the editor. See the previous tips about Vi for more information.

[exit vi]: https://stackoverflow.com/questions/11828270/how-do-i-exit-vim
[git default editor]: https://stackoverflow.com/questions/2596805/how-do-i-make-git-use-the-editor-of-my-choice-for-editing-commit-messages
