/*
 * Some or all of this work - Copyright (c) 2006 - 2010, Intel Corp.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * Neither the name of Intel Corporation nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * Bug 208 (local-bugzilla-343):
 *
 * SUMMARY: Store-to-Debug operation falls into infinite loop for ring of Index references
 *
 * Note: add verifications while sorting out and fixing the bug (CH03/CH04/..)
 */

Method(m818)
{
	Method(m000)
	{
		Name(p000, Package() {0x10,0x11,0x12,0x13})

		Store(Index(p000, 0), Index(p000, 1))
		Store(Index(p000, 1), Index(p000, 2))
		Store(Index(p000, 2), Index(p000, 0))

		Store(Index(p000, 0), Local0)

		Store(Local0, Debug)

		/* RING_OF_REFS_EXCEPTION? */
	}

	Method(m001)
	{
		Name(p000, Package() {0x10,0x11,0x12,0x13})
		Name(p001, Package() {0x20,0x21,0x22,0x23})

		Store(Index(p000, 0), Index(p001, 1))
		Store(Index(p001, 0), Index(p000, 1))

		Store(Index(p000, 0), Local0)

		Store(Local0, Debug)

		/* RING_OF_REFS_EXCEPTION? */
	}

	Method(m002)
	{
		Name(p000, Package() {0x10,0x11,0x12,0x13})

		Store(Index(p000, 0), Index(p000, 1))

		Store(Index(p000, 3), Local0)

		Store(Local0, Debug)

		/* RING_OF_REFS_EXCEPTION? */
	}
	m000()
	m001()
	m002()
}
