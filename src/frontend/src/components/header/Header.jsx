import React from 'react';
import { Link } from 'react-router';
import LogoutButton from './LogoutButton.jsx';

const Header = () => (
  <div className="page-header-menu header-admin" >
    <div className="page-header-menu">
      <div className="row menu">
        <div className="hor-menu">
          <div className="page-header-inner ">
            <div className="page-logo" />
            <div className="top-menu">
              <ul className="nav navbar-nav pull-right">
                <li className="uppercase menu-btn">
                  <Link to="/admin/listUsers" activeClassName="active">Users</Link>
                </li>
                <li className="uppercase menu-btn">
                  <Link to="/admin/providers" activeClassName="active">Providers</Link>
                </li>
                <li className="uppercase menu-btn">
                  <Link to="/admin/services" activeClassName="active">Services</Link>
                </li>
                <li className="uppercase menu-btn">
                  <Link to="/admin/industries" activeClassName="active">Industries</Link>
                </li>
                <li className="uppercase menu-btn" activeClassName="active">
                  <LogoutButton />
                </li>
              </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

);

export default Header;
