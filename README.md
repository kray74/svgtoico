# SVG to ICO converter.
Convert svg to ico for using in Windows explorer.

Output ICO contains 6 pictures with sizes 16x16, 24x24, 32x32, 48x48, 64x64, 256x256
according to [MS guide](https://docs.microsoft.com/en-us/windows/win32/uxguide/vis-icons):
> Size requirements ...
>
> Application icons and Control Panel items:
> The full set includes 16x16, 32x32, 48x48, and 256x256
> (code scales between 32 and 256). The .ico file format is required.
> For Classic Mode, the full set is 16x16, 24x24, 32x32, 48x48 and 64x64."
>
> List item icon options: Use live thumbnails or file icons of the file type
> (for example, .doc); full set."

## Usage
`svgtoico SVG-file ICO-file`

SVG-file - path to input .svg file.

ICO-file - path to output .ico file. File will be overwritten if exists.
If path specified without file name there will be icon.ico.

## Dependencies:
* [Inkscape](https://inkscape.org/). inkscape.exe must be in `PATH`
environment variable.
* [Python3](https://www.python.org/). py.exe launcher must be in `PATH`
(installed to C:\windows by default).

Required python modules:
* Pillow (use command `py -m pip install Pillow`).
* [iconify.py](https://learning-python.com/iconify.html) not from the pip!
PyPI has iconify package but it's not what we need.
Place iconify.py to your python site-packages directory
(something like "C:\Python38\Lib\site-packages"),
so you can call it with `py -m iconify` command.
