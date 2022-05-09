import ALink from '../../../features/alink';
import {cartPriceTotal, cartQtyTotal} from '../../../../utils/index';

function CartMenu(props) {
    const cartlist = [];

    return (
        <div className="dropdown cart-dropdown"><a className="dropdown-toggle" href="#">
            <div className="icon"><i className="icon-shopping-cart"></i><span className="cart-count">0</span></div></a>
            <div className="dropdown-menu dropdown-menu-right text-center"><p>No products in the cart.</p></div>
        </div>
    );
}


export default CartMenu;