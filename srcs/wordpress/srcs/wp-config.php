<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wpdb' );

/** MySQL database username */
define( 'DB_USER', 'admin' );

/** MySQL database password */
define( 'DB_PASSWORD', 'admin' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql:3306' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '$9%+cO7mP*YA:;O^X&exxy-1^*u(HWK@]eY#=8VC<;=0?-9*r0f{9!+gyehnK+PD' );
define( 'SECURE_AUTH_KEY',  'W;&$lw!+X@4{f?=2+7>/BCx|iPP?4w?mzqB-JpI<V |vKn1X=Hs8 !W]/JwJ&T`g' );
define( 'LOGGED_IN_KEY',    '&CezjJ]5aqLyp1XAkY{=!hBw2)=[pkzhs{::{^m+HSKaq6yT@v%QP,,:s6g@7rXI' );
define( 'NONCE_KEY',        ']l,#3DIa1g@5L4U=aX];D;#{ ` e4jz9i(^cdU}fdw.c9t~o?r+UrWDmy0g%0uQz' );
define( 'AUTH_SALT',        '4@UW)J}PwcbhZ@u]|3U,`,XKjWh>pJh1!HK=XiqKxd!}z(~YK#7+3l&-wv$R;~W/' );
define( 'SECURE_AUTH_SALT', 'jF-[w _J>et;-lekx8?]{~7W+_+WYS}z^ln(&cNgxc3|7,sz2^,>UCcyml,@`kdZ' );
define( 'LOGGED_IN_SALT',   'k$>{JHOJ_;yog/L-k_hQJaj,=SPa(i;/[4A)V+DK4E2/vj1[v_6@24kP^](6wHi{' );
define( 'NONCE_SALT',       'C-5oYIUd, V(cMtX`Smqw(EiRfeeQLP-DrGf}X-|/Vev.$49p?Jd>I6HYan~n<l4' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';