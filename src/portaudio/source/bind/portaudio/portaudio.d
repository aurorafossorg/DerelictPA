module bind.portaudio.portaudio;

/** @file bind/portaudio/portaudio.d
 * @brief The portable PortAudio API.
 */

@nogc @system nothrow extern(C):

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

	/**
	 * Generate a packed integer version number in the same format used
	 * by Pa_GetVersion(). Use this to compare a specified version number with
	 * the currently running version. For example:
	 * @code
	 *     if( Pa_GetVersion() < paMakeVersionNumber(19,5,1) ) {}
	 * @endcode
	 * @see Pa_GetVersion, Pa_GetVersionInfo
	 * @version Available as of 19.5.0.
	 */
	deprecated pragma(inline, true) int paMakeVersionNumber(ref int major, ref int minor, ref int subminor)
	{
		return (((major)&0xFF)<<16 | ((minor)&0xFF)<<8 | ((subminor)&0xFF));
	}

	struct PaVersionInfo {
		int versionMajor;
		int versionMinor;
		int versionSubMinor;
		const(char)* versionControlRevision;
		const(char)* versionText;
	}

	const(PaVersionInfo)* Pa_GetVersionInfo();

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

	const(char)* Pa_GetErrorText(PaError );

	PaError Pa_Initialize();
	PaError Pa_Terminate();

	alias PaDeviceIndex = int;

	enum paNoDevice = cast(PaDeviceIndex)-1;
	enum paUseHostApiSpecificDeviceSpecification = cast(PaDeviceIndex)-2;

	alias PaHostApiIndex = int;

	PaHostApiIndex Pa_GetHostApiCount();
	PaHostApiIndex Pa_GetDefaultHostApi();

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

	const(PaHostApiInfo)* Pa_GetHostApiInfo(PaHostApiIndex );
	PaHostApiIndex Pa_HostApiTypeIdToHostApiIndex(PaHostApiTypeId );
	PaDeviceIndex Pa_HostApiDeviceIndexToDeviceIndex(PaHostApiIndex , int hostApiDeviceIndex );

	struct PaHostErrorInfo {
		PaHostApiTypeId hostApiType;
		long errorCode;
		const(char)* errorText;
	}

	const(PaHostErrorInfo)* Pa_GetLastHostErrorInfo();

	PaDeviceIndex Pa_GetDeviceCount();
	PaDeviceIndex Pa_GetDefaultInputDevice();
	PaDeviceIndex Pa_GetDefaultOutputDevice();

	alias PaTime = double;
	alias PaSampleFormat = ulong;

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

	const(PaDeviceInfo)* Pa_GetDeviceInfo(PaDeviceIndex );

	struct PaStreamParameters
	{
		PaDeviceIndex device;
		int channelCount;
		PaSampleFormat sampleFormat;
		PaTime suggestedLatency;
		void* hostApiSpecificStreamInfo;
	}

	enum paFormatIsSupported = 0;

	PaError Pa_IsFormatSupported(const PaStreamParameters* , const PaStreamParameters* , double );

	alias PaStream = void;

	enum paFramesPerBufferUnspecified = 0;

	alias PaStreamFlags = ulong;

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


	alias PaStreamCallbackFlags = ulong;

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

	alias PaStreamCallback = int function(const(void)*, void*, ulong, const(PaStreamCallbackTimeInfo)*, PaStreamCallbackFlags, void*);

	PaError Pa_OpenStream(PaStream** , const PaStreamParameters* , const PaStreamParameters* , double , ulong , PaStreamFlags , PaStreamCallback , void* );
	PaError Pa_OpenDefaultStream(PaStream** , int , int , PaSampleFormat , double , ulong , PaStreamCallback , void* );
	PaError Pa_CloseStream(PaStream* );

	alias PaStreamFinishedCallback = void function(void*);

	PaError Pa_SetStreamFinishedCallback(PaStream* , PaStreamFinishedCallback );
	PaError Pa_StartStream(PaStream* );
	PaError Pa_StopStream(PaStream* );
	PaError Pa_AbortStream(PaStream* );


	PaError Pa_IsStreamStopped(PaStream* );
	PaError Pa_IsStreamActive(PaStream* );

	struct PaStreamInfo
	{
		int structVersion;
		PaTime inputLatency;
		PaTime outputLatency;
		double sampleRate;
	}

	const(PaStreamInfo)* Pa_GetStreamInfo(PaStream* );
	PaTime Pa_GetStreamTime(PaStream* );
	double Pa_GetStreamCpuLoad(PaStream* );
	PaError Pa_ReadStream(PaStream* , void* , ulong );
	PaError Pa_WriteStream(PaStream* , const void* , ulong );
	long Pa_GetStreamReadAvailable(PaStream* );
	long Pa_GetStreamWriteAvailable(PaStream* );
	PaError Pa_GetSampleSize(PaSampleFormat );
	void Pa_Sleep(long );
