/*
                                   / _|
  __ _ _   _ _ __ ___  _ __ __ _  | |_ ___  ___ ___
 / _` | | | | '__/ _ \| '__/ _` | |  _/ _ \/ __/ __|
| (_| | |_| | | | (_) | | | (_| | | || (_) \__ \__ \
 \__,_|\__,_|_|  \___/|_|  \__,_| |_| \___/|___/___/

Copyright (C) 2018 Aurora Free Open Source Software.

This file is part of the Aurora Free Open Source Software. This
organization promote free and open source software that you can
redistribute and/or modify under the terms of the Boost Software License
Version 1.0 available in the package root path as 'LICENSE' file. Please
review the following information to ensure that the license requirements
meet the opensource guidelines at opensource.org .

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

NOTE: All products, services or anything associated to trademarks and
service marks used or referenced on this file are the property of their
respective companies/owners or its subsidiaries. Other names and brands
may be claimed as the property of others.
For more info about intellectual property visit: aurorafoss.org or
directly send an email to: contact (at) aurorafoss.org .
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
c_long Pa_GetStreamReadAvailable(PaStream* );
c_long Pa_GetStreamWriteAvailable(PaStream* );
PaError Pa_GetSampleSize(PaSampleFormat );
void Pa_Sleep(c_long );