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