DerelictPA
==========

*Warning: this an unofficial Derelict binding.*

A dynamic binding to [PortAudio][1] for the D Programming Language.

Please see the sections on [Compiling and Linking][2] and [The Derelict Loader][3], in the Derelict documentation, for information on how to build DerelictPA and load PortAudio at run time. In the meantime, here's some sample code.

```D
import derelict.portaudio;

void main() {
    // Load the PortAudio library.
    DerelictPA.load();

    // Now PortAudio functions can be called.
    ...
}
```

Also thanks to [Ianis G. Vasilev][4] for the static binds.

[1]: http://www.portaudio.com/
[2]: http://derelictorg.github.io/building/overview/
[3]: http://derelictorg.github.io/loading/loader/
[4]: https://github.com/v--/portaudio/