//////////////////////////////////////////////////////////////////////////////
// SPDX-FileCopyrightText: 2021 , Dinesh Annayya
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0
// SPDX-FileContributor: Created by Dinesh Annayya <dinesha@opencores.org>
//
//-----------------------------------------------------------------
//                     USB Full Speed Host
//                           V0.6
//                     Ultra-Embedded.com
//                     Copyright 2015-2020
//
//                 Email: admin@ultra-embedded.com
//
//                         License: GPL
// If you would like a version with a more permissive license for
// use in closed source commercial applications please contact me
// for details.
//-----------------------------------------------------------------
//
// This file is open source HDL; you can redistribute it and/or
// modify it under the terms of the GNU General Public License as
// published by the Free Software Foundation; either version 2 of
// the License, or (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public
// License along with this file; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
// USA
//-----------------------------------------------------------------

//-----------------------------------------------------------------
//                          Generated File
//-----------------------------------------------------------------
//-----------------------------------------------------------------
// Module: 5-bit CRC used by USB tokens
//-----------------------------------------------------------------
module usbh_crc5
	(
		input  [4:0]     crc_i,
		input  [10:0]    data_i,
		output [4:0]     crc_o
	);

//-----------------------------------------------------------------
// Implementation
//-----------------------------------------------------------------
	assign crc_o[0] =    data_i[10] ^ data_i[9] ^ data_i[6] ^ data_i[5] ^ data_i[3] ^ data_i[0] ^
		crc_i[0] ^ crc_i[3] ^ crc_i[4];

	assign crc_o[1] =    data_i[10] ^ data_i[7] ^ data_i[6] ^ data_i[4] ^ data_i[1] ^
		crc_i[0] ^ crc_i[1] ^ crc_i[4];

	assign crc_o[2] =    data_i[10] ^ data_i[9] ^ data_i[8] ^ data_i[7] ^ data_i[6] ^ data_i[3] ^ data_i[2] ^ data_i[0] ^
		crc_i[0] ^ crc_i[1] ^ crc_i[2] ^ crc_i[3] ^ crc_i[4];

	assign crc_o[3] =    data_i[10] ^ data_i[9] ^ data_i[8] ^ data_i[7] ^ data_i[4] ^ data_i[3] ^ data_i[1] ^
		crc_i[1] ^ crc_i[2] ^ crc_i[3] ^ crc_i[4];

	assign crc_o[4] =    data_i[10] ^ data_i[9] ^ data_i[8] ^ data_i[5] ^ data_i[4] ^ data_i[2] ^
		crc_i[2] ^ crc_i[3] ^ crc_i[4];

endmodule
