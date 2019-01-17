# Vim Notes

Coming Home to Vim

https://news.ycombinator.com/item?id=4218575


NERD Commenter:
https://github.com/scrooloose/nerdcommenter/

  * `[count]<leader>cc` **|NERDComComment|**

    Comment out the current line or text selected in visual mode.


AG File Search

https://github.com/rking/ag.vim

:Ags [options] {pattern} [{directory}]



=============================================================
MAPPINGS                                         *ags-mappings*

Once inside the search results window:~

    p    - navigate file paths forward
    P    - navigate files paths backwards
    r    - navigate results forward
    R    - navigate results backwards
    a    - display the file path for current results
    c    - copy to clipboard the file path for current results
    E    - enter edit mode

    oa   - open file above the results window
    ob   - open file below the results window
    ol   - open file to the left of the results window
    or   - open file to the right of the results window
    os   - open file in the results window
    ou   - open file in a previously opened window
    xu   - open file in a previously opened window and close the search results
    <CR> - open file in a previously opened window

    q    - close the search results window
    u    - displays these key mappings



CTRLP
https://github.com/ctrlpvim/ctrlp.vim


## Basic Usage
* Run `:CtrlP` or `:CtrlP [starting-directory]` to invoke CtrlP in find file mode.

vim-surround

https://github.com/tpope/vim-surround





