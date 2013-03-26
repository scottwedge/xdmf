/*****************************************************************************/
/*                                    XDMF                                   */
/*                       eXtensible Data Model and Format                    */
/*                                                                           */
/*  Id : XdmfSharedPtr.hpp                                                   */
/*                                                                           */
/*  Author:                                                                  */
/*     Kenneth Leiter                                                        */
/*     kenneth.leiter@arl.army.mil                                           */
/*     US Army Research Laboratory                                           */
/*     Aberdeen Proving Ground, MD                                           */
/*                                                                           */
/*     Copyright @ 2011 US Army Research Laboratory                          */
/*     All Rights Reserved                                                   */
/*     See Copyright.txt for details                                         */
/*                                                                           */
/*     This software is distributed WITHOUT ANY WARRANTY; without            */
/*     even the implied warranty of MERCHANTABILITY or FITNESS               */
/*     FOR A PARTICULAR PURPOSE.  See the above copyright notice             */
/*     for more information.                                                 */
/*                                                                           */
/*****************************************************************************/

#ifndef XDMFSHAREDPTR_HPP_
#define XDMFSHAREDPTR_HPP_

#include "XdmfConfig.hpp"
#include <boost/shared_ptr.hpp>

using boost::shared_ptr;

#ifdef HAVE_BOOST_SHARED_DYNAMIC_CAST

using boost::shared_dynamic_cast;

#else

using boost::dynamic_pointer_cast;
template <typename T, typename U>
shared_ptr<T> shared_dynamic_cast(shared_ptr<U> const & r) 
{
  return dynamic_pointer_cast<T>(r);
}

#endif /* HAVE_BOOST_SHARED_DYNAMIC_CAST */

#endif /* XDMFSHAREDPTR_HPP_ */
