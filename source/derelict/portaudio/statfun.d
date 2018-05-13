/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/

module derelict.portaudio.statfun;

///TODO: Write documentation for everithing else

@nogc nothrow extern(C):

/** Retrieve the release number of the currently running PortAudio build.
 * For example, for version "19.5.1" this will return 0x00130501.
 * @see paMakeVersionNumber
 */
int Pa_GetVersion();

/**
 * Retrieve a textual description of the current PortAudio build.
 * e.g. "PortAudio V19.5.0-devel, revision 1952M".
 * The format of the text may change in the future. Do not try to parse the
 * returned string.
 * @deprecated As of 19.5.0, use Pa_GetVersionInfo()->versionText instead.
 */
const(char)* Pa_GetVersionText();

const(PaVersionInfo)* Pa_GetVersionInfo();

const(char)* Pa_GetErrorText(PaError );

PaError Pa_Initialize();
PaError Pa_Terminate();

PaHostApiIndex Pa_GetHostApiCount();
PaHostApiIndex Pa_GetDefaultHostApi();

const(PaHostApiInfo)* Pa_GetHostApiInfo(PaHostApiIndex );
PaHostApiIndex Pa_HostApiTypeIdToHostApiIndex(PaHostApiTypeId );
PaDeviceIndex Pa_HostApiDeviceIndexToDeviceIndex(PaHostApiIndex , int hostApiDeviceIndex );

const(PaHostErrorInfo)* Pa_GetLastHostErrorInfo();

PaDeviceIndex Pa_GetDeviceCount();
PaDeviceIndex Pa_GetDefaultInputDevice();
PaDeviceIndex Pa_GetDefaultOutputDevice();

const(PaDeviceInfo)* Pa_GetDeviceInfo(PaDeviceIndex );

PaError Pa_IsFormatSupported(const PaStreamParameters* , const PaStreamParameters* , double );

PaError Pa_OpenStream(PaStream** , const PaStreamParameters* , const PaStreamParameters* , double , c_ulong , PaStreamFlags , PaStreamCallback , void* );
PaError Pa_OpenDefaultStream(PaStream** , int , int , PaSampleFormat , double , c_ulong , PaStreamCallback , void* );
PaError Pa_CloseStream(PaStream* );

PaError Pa_SetStreamFinishedCallback(PaStream* , PaStreamFinishedCallback );
PaError Pa_StartStream(PaStream* );
PaError Pa_StopStream(PaStream* );
PaError Pa_AbortStream(PaStream* );


PaError Pa_IsStreamStopped(PaStream* );
PaError Pa_IsStreamActive(PaStream* );

const(PaStreamInfo)* Pa_GetStreamInfo(PaStream* );
PaTime Pa_GetStreamTime(PaStream* );
double Pa_GetStreamCpuLoad(PaStream* );
PaError Pa_ReadStream(PaStream* , void* , c_ulong );
PaError Pa_WriteStream(PaStream* , const void* , c_ulong );
long Pa_GetStreamReadAvailable(PaStream* );
long Pa_GetStreamWriteAvailable(PaStream* );
PaError Pa_GetSampleSize(PaSampleFormat );
void Pa_Sleep(long );