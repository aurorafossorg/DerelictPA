module derelict.portaudio.portaudio;

/** Generate a packed integer version number in the same format used
 * by Pa_GetVersion(). Use this to compare a specified version number with
 * the currently running version. For example:
 * @code
 *     if( Pa_GetVersion() < paMakeVersionNumber(19,5,1) ) {}
 * @endcode
 * @see Pa_GetVersion, Pa_GetVersionInfo
 * @version Available as of 19.5.0.
 */
int paMakeVersionNumber(ref int major, ref int minor, ref int subminor)
{
	return (((major)&0xFF)<<16 | ((minor)&0xFF)<<8 | ((subminor)&0xFF));
}

public:
	version(DerelictAL_Static)
		import derelict.portaudio.statfun;
	else
		import derelict.portaudio.dynload;