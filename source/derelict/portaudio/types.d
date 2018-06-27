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

module derelict.portaudio.types;

public import core.stdc.config : c_ulong;

struct PaVersionInfo {
	int versionMajor;
	int versionMinor;
	int versionSubMinor;
	const(char)* versionControlRevision;
	const(char)* versionText;
}

alias PaError = int;

enum PaErrorCode
{
	paNoError = 0,
	paNotInitialized = -10000,
	paUnanticipatedHostError,
	paInvalidChannelCount,
	paInvalidSampleRate,
	paInvalidDevice,
	paInvalidFlag,
	paSampleFormatNotSupported,
	paBadIODeviceCombination,
	paInsufficientMemory,
	paBufferTooBig,
	paBufferTooSmall,
	paNullCallback,
	paBadStreamPtr,
	paTimedOut,
	paInternalError,
	paDeviceUnavailable,
	paIncompatibleHostApiSpecificStreamInfo,
	paStreamIsStopped,
	paStreamIsNotStopped,
	paInputOverflowed,
	paOutputUnderflowed,
	paHostApiNotFound,
	paInvalidHostApi,
	paCanNotReadFromACallbackStream,
	paCanNotWriteToACallbackStream,
	paCanNotReadFromAnOutputOnlyStream,
	paCanNotWriteToAnInputOnlyStream,
	paIncompatibleStreamHostApi,
	paBadBufferPtr
}

alias PaDeviceIndex = int;

enum paNoDevice = cast(PaDeviceIndex)-1;
enum paUseHostApiSpecificDeviceSpecification = cast(PaDeviceIndex)-2;

alias PaHostApiIndex = int;

enum PaHostApiTypeId
{
	paInDevelopment,
	paDirectSound,
	paMME,
	paASIO,
	paSoundManager,
	paCoreAudio,
	paOSS=7,
	paALSA,
	paAL,
	paBeOS,
	paWDMKS,
	paJACK,
	paWASAPI,
	paAudioScienceHPI
}

struct PaHostApiInfo {
	int structVersion;
	PaHostApiTypeId type;
	const(char)* name;
	int deviceCount;
	PaDeviceIndex defaultInputDevice;
	PaDeviceIndex defaultOutputDevice;
}

struct PaHostErrorInfo {
	PaHostApiTypeId hostApiType;
	long errorCode;
	const(char)* errorText;
}

alias PaTime = double;
alias PaSampleFormat = c_ulong;

enum paFloat32 = cast(PaSampleFormat)0x00000001;
enum paInt32 = cast(PaSampleFormat)0x00000002;
enum paInt24 = cast(PaSampleFormat)0x00000004;
enum paInt16 = cast(PaSampleFormat)0x00000008;
enum paInt8 = cast(PaSampleFormat)0x00000010;
enum paUInt8 = cast(PaSampleFormat)0x00000020;
enum paCustomFormat = cast(PaSampleFormat)0x00010000;
enum paNonInterleaved = cast(PaSampleFormat)0x80000000;

struct PaDeviceInfo
{
	int structVersion;
	const(char) *name;
	PaHostApiIndex hostApi;

	int maxInputChannels;
	int maxOutputChannels;

	PaTime defaultLowInputLatency;
	PaTime defaultLowOutputLatency;
	PaTime defaultHighInputLatency;
	PaTime defaultHighOutputLatency;

	double defaultSampleRate;
}

struct PaStreamParameters
{
	PaDeviceIndex device;
	int channelCount;
	PaSampleFormat sampleFormat;
	PaTime suggestedLatency;
	void* hostApiSpecificStreamInfo;
}

enum paFormatIsSupported = 0;

alias PaStream = void;

enum paFramesPerBufferUnspecified = 0;

alias PaStreamFlags = c_ulong;

enum paNoFlag = cast(PaStreamFlags)0;
enum paClipOff = cast(PaStreamFlags)0x00000001;
enum paDitherOff = cast(PaStreamFlags)0x00000002;
enum paNeverDropInput = cast(PaStreamFlags)0x00000004;
enum paPrimeOutputBuffersUsingStreamCallback = cast(PaStreamFlags)0x00000008;
enum paPlatformSpecificFlags = cast(PaStreamFlags)0xFFFF0000;

struct PaStreamCallbackTimeInfo{
	PaTime inputBufferAdcTime;
	PaTime currentTime;
	PaTime outputBufferDacTime;
};


alias PaStreamCallbackFlags = c_ulong;

enum paInputUnderflow = cast(PaStreamCallbackFlags)0x00000001;
enum paInputOverflow = cast(PaStreamCallbackFlags)0x00000002;
enum paOutputUnderflow = cast(PaStreamCallbackFlags)0x00000004;
enum paOutputOverflow = cast(PaStreamCallbackFlags)0x00000008;
enum paPrimingOutput = cast(PaStreamCallbackFlags)0x00000010;

alias PaStreamCallbackResult = int;

enum
{
	paContinue,
	paComplete,
	paAbort
}

alias PaStreamCallback = int function(const(void)*, void*, c_ulong, const(PaStreamCallbackTimeInfo)*, PaStreamCallbackFlags, void*);
alias PaStreamFinishedCallback = void function(void*);

struct PaStreamInfo
{
	int structVersion;
	PaTime inputLatency;
	PaTime outputLatency;
	double sampleRate;
}