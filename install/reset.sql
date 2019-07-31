-- RESET
SET NAMES utf8;
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

-- 1. Recreate tables that may be altered

-- 2. Clean all tables

TRUNCATE TABLE `__PREFIX__cache`;
TRUNCATE TABLE `__PREFIX__ip_log`;
TRUNCATE TABLE `__PREFIX__mailog`;
TRUNCATE TABLE `__PREFIX__menu_item`;
TRUNCATE TABLE `__PREFIX__menu_set`;
TRUNCATE TABLE `__PREFIX__module`;
TRUNCATE TABLE `__PREFIX__module_pos`;
TRUNCATE TABLE `__PREFIX__notification`;
TRUNCATE TABLE `__PREFIX__page`;
TRUNCATE TABLE `__PREFIX__page_cat`;
TRUNCATE TABLE `__PREFIX__page_group`;
TRUNCATE TABLE `__PREFIX__permalink`;
TRUNCATE TABLE `__PREFIX__qform_log`;
TRUNCATE TABLE `__PREFIX__qcomment`;
TRUNCATE TABLE `__PREFIX__qcomment_set`;
TRUNCATE TABLE `__PREFIX__user`;

-- 3. Refill tables

INSERT INTO `__PREFIX__menu_item` (`idx`, `menu_id`, `menu_parent`, `menu_item`, `menu_url`, `menu_permalink`, `menu_order`, `ref_idx`) VALUES
(1,	1,	0,	'Home',	'__SITE__/index.php',	'',	100,	0),
(2,	1,	0,	'About Us',	'4',	'',	110,	0),
(3,	1,	0,	'Contact Us',	'__SITE__/contact.php',	'',	120,	0),
(4,	2,	0,	'Contact Us',	'__SITE__/contact.php',	'',	100,	0),
(5,	2,	0,	'Site Map',	'__SITE__/sitemap.php',	'',	110,	0),
(7,	2,	0,	'Tell a Friend',	'__SITE__/tell.php',	'',	120,	0),
(8,	3,	0,	'Privacy Policy',	'2',	'',	100,	0),
(9,	3,	0,	'Terms &amp; Conditions',	'7',	'',	110,	0),
(10,	3,	0,	'Powered by qEngine',	'8',	'',	130,	0),
(11,	3,	0,	'FAQ',	'3',	'',	120,	0);

INSERT INTO `__PREFIX__menu_set` (`idx`, `menu_id`, `menu_title`, `menu_preset`, `menu_class`, `menu_notes`, `menu_cache`, `menu_locked`, `ref_idx`) VALUES
(1, 'main_menu', 'Main Menu', 'bsnav', '', 'Main menu, usually located at the top of the page.', '<ul id=\"qmenu_main_menu\" class=\"nav navbar-nav\">\n	<li><a href=\"__SITE__/index.php\">Home</a></li>\n	<li><a href=\"__SITE__/about-us.php\">About Us</a></li>\n	<li><a href=\"__SITE__/contact.php\">Contact Us</a></li>\n</ul>\n', '0', 0),
(2, 'footer_menu', 'Footer Menu', 'list_1', '', 'Footer menu, usually located at the end of the page.', '<ul id=\"qmenu_footer_menu\" class=\"list_1\">\n	<li><a href=\"__SITE__/contact.php\">Contact Us</a></li>\n	<li><a href=\"__SITE__/sitemap.php\">Site Map</a></li>\n	<li><a href=\"__SITE__/tell.php\">Tell a Friend</a></li>\n</ul>\n', '0', 0),
(3, 'page_menu', 'Page Menu', 'list_1', '', 'Menu linking to some important, but not that important pages.', '<ul id=\"qmenu_page_menu\" class=\"list_1\">\n	<li><a href=\"__SITE__/privacy-policy.php\">Privacy Policy</a></li>\n	<li><a href=\"__SITE__/terms-and-conditions.php\">Terms & Conditions</a></li>\n	<li><a href=\"__SITE__/faqs.php\">FAQ</a></li>\n	<li><a href=\"__SITE__/powered-by-qengine.php\">Powered by qEngine</a></li>\n</ul>\n', '0', 0);

INSERT INTO `__PREFIX__module` (`mod_id`, `mod_type`, `mod_name`, `mod_desc`, `mod_version`, `mod_css`, `mod_js`, `mod_enabled`) VALUES
('ztopwatch',	'general',	'Ztopwatch',	'This module replace the old stopwatch in qEngine 1',	'1.0.0',	'',	'',	'1'),
('qbanner',	'general',	'qBanner',	'Use this module to upload & display banners.',	'1.0.0',	'',	'',	'1'),
('page_gallery',	'general',	'Page Gallery',	'Display selected pages or categories or groups anywhere!',	'2.0.0',	'',	'',	'1'),
('box',	'general',	'Box',	'A simple module to display static html for your page, without editing .tpl files, best used with qE 4.x\'s Module Manager.',	'1.0.0',	'',	'',	'1'),
('qcomment',	'general',	'qComment',	'Add user comments & user ratings to your site and your modules, easily!',	'3.0.0',	'',	'',	'1'),
('qmenu',	'general',	'qMenu',	'Use qMenu module to display your designed menu easily!',	'1.0.0',	'',	'',	'1'),
('slideshow',	'general',	'Slideshow',	'This module to replace qEngine\'s old featured contents.',	'1.0.0',	'slideshow.css',	'',	'1'),
('qstats',	'general',	'Simple Stats',	'This module replaces qEngine\'s old simple statistics of visitors\' hits & visits.',	'1.0.0',	'',	'',	'1');

INSERT INTO `__PREFIX__module_pos` (`idx`, `mod_id`, `mod_title`, `mod_config`, `mod_pos`) VALUES
(1,	'box',	'Add Anything!',	'&lt;p&gt;You can easily adds any HTML or JavaScript tags by editing this module, or create a new box, by using Box Module in ACP &gt; Modules &gt; Layout.&lt;/p&gt;\r\n\r\n&lt;p&gt;Add Google AdSense, Facebook Feeds, Twitter Updates, by editing this module.&lt;/p&gt;',	'R1'),
(2,	'box',	'Info Box',	'&lt;p&gt;Manage this module from ACP. Display up to 40 modules easily!&lt;/p&gt;\r\n\r\n&lt;p&gt;You can also remove this information from Module Management.&lt;/p&gt;\r\n\r\n&lt;p&gt;In default skin, this module appears on the right.&lt;/p&gt;',	'L2'),
(4,	'qmenu',	'Tools',	'menu=footer_menu',	'B1'),
(5,	'qmenu',	'Pages',	'menu=page_menu',	'B1'),
(3,	'qbanner',	'Banner',	'',	'L1'),
(9,	'qstats',	'Simple Stats',	'',	'R2');

INSERT INTO `__PREFIX__page` (`group_id`, `cat_id`, `page_id`, `permalink`, `page_image`, `page_date`, `page_time`, `page_unix`, `page_title`, `page_keyword`, `page_body`, `page_author`, `page_related`, `page_allow_comment`, `last_update`, `page_rating`, `page_comment`, `page_list`, `page_hit`, `page_img_tmp`, `page_attachment`, `page_attachment_stat`, `page_pinned`, `page_status`, `page_template`) VALUES
('GENPG',	1,	1,	'welcome.php',	'',	'2011-11-11',	'14:15:00',	1321017300,	'Welcome',	'add,your,keyword,here,qengine,c97net',	'<p>Welcome to our site, please enjoy your stay here. If you have any question, please contact us.</p>\r\n<p>This is an example of a page, you could edit this to put information about yourself or your site so readers know where you are coming from. As mentioned before, you can create as many pages like this one.</p>\r\n<p>You can edit this text in Admin &gt; Page Manager.</p>\r\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent placerat eros vitae dolor pellentesque at tristique sapien vehicula. Mauris sed ligula enim, hendrerit viverra turpis. Sed pretium pharetra convallis. Fusce ac velit eget libero dapibus vehicula. Etiam ullamcorper congue odio eget porta. Praesent accumsan, dui ac condimentum congue, nisi odio auctor enim, a aliquam est enim condimentum risus. Sed in nisl placerat magna mattis auctor eu in erat.</p>\r\n<p>This is an example of a page, you could edit this to put information about yourself so readers know where you are coming from. You can create as many pages like this one.</p>\r\n<p>Aenean pellentesque metus at purus pretium sed vehicula tortor aliquam. Curabitur erat turpis, rhoncus et molestie id, pharetra non turpis. Pellentesque ultricies, urna sed lobortis tincidunt, dolor orci dapibus lectus, in aliquet ipsum sapien ac tortor. Suspendisse eu ante nibh, vel aliquam magna. Proin vel felis libero. Nullam mauris neque, suscipit sit amet placerat rutrum, vestibulum sed mauris. Sed magna nulla, tristique sit amet volutpat sed, cursus sit amet purus. Nam lobortis odio eu nunc fermentum adipiscing. Pellentesque congue ornare ipsum venenatis porta. Aenean scelerisque porttitor metus, a ornare ante rhoncus nec. Etiam metus risus, porttitor luctus iaculis sed, elementum in odio. Etiam metus leo, interdum vitae gravida sit amet, tincidunt id velit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>',	'admin',	'',	'0',	1447165085,	0.00,	0,	'0',	111,	'',	'',	0,	'0',	'P',	'page_default.tpl'),
('GENPG',	1,	2,	'privacy-policy.php',	'',	'2011-11-11',	'14:30:00',	1320996600,	'Privacy Policy',	'',	'<h2>Information that is gathered from visitors</h2>\r\n<p>In common with other websites, log files are stored on the web server saving details such as the visitor\'s IP address, browser type, referring page and time of visit.</p>\r\n<p>Cookies may be used to remember visitor preferences when interacting with the website.</p>\r\n<p>Where registration is required, the visitor\'s email and a username will be stored on the server.</p>\r\n<h2>How the Information is used</h2>\r\n<p>The information is used to enhance the vistor\'s experience when using the website to display personalised content and possibly advertising.</p>\r\n<p>E-mail addresses will not be sold, rented or leased to 3rd parties.</p>\r\n<p>E-mail may be sent to inform you of news of our services or offers by us or our affiliates.</p>\r\n<h2>Visitor Options</h2>\r\n<p>If you have subscribed to one of our services, you may unsubscribe by following the instructions which are included in e-mail that you receive.</p>\r\n<p>You may be able to block cookies via your browser settings but this may prevent you from access to certain features of the website.</p>\r\n<h2>Cookies</h2>\r\n<p>Cookies are small digital signature files that are stored by your web browser that allow your preferences to be recorded when visiting the website. Also they may be used to track your return visits to the website.</p>\r\n<p>3rd party advertising companies may also use cookies for tracking purposes.</p>\r\n<h2>Google Ads</h2>\r\n<p>Google, as a third party vendor, uses cookies to serve ads.</p>\r\n<p>Google\'s use of the DART cookie enables it to serve ads to visitors based on their visit to sites they visit on the Internet.</p>\r\n<p>Website visitors may opt out of the use of the DART cookie by visiting the Google ad and content network privacy policy.</p>\r\n<p>(last updated March 2009)<br />Based on <a href=\"http://www.freeprivacypolicy.org/\">FPP</a></p>',	'admin',	'',	'1',	1366442573,	0.00,	0,	'1',	52,	'',	'',	0,	'0',	'P',	'page_default.tpl'),
('GENPG',	1,	3,	'faqs.php',	'',	'2011-11-11',	'00:00:00',	1320944400,	'FAQ&#039;s',	'',	'<p>Here you will find answers to many of your questions. If there is something which you cannot find the answer to, let us know and we will add your question to this list.</p>',	'admin',	'',	'1',	1366442718,	0.00,	0,	'1',	8,	'',	'',	0,	'0',	'P',	'page_default.tpl'),
('GENPG',	1,	4,	'about-us.php',	'',	'2011-11-11',	'00:00:00',	1320966000,	'About Us',	'',	'<p>Tell who you are, what you do, and anything else. Company history and the chairman will be a nice addition.</p>',	'admin',	'',	'1',	1443117458,	0.00,	0,	'1',	336,	'',	'',	3,	'0',	'P',	'page_default.tpl'),
('GENPG',	1,	6,	'contact-us.php',	'',	'2011-11-11',	'00:00:00',	1320944400,	'Contact Us',	'',	'<p>Put your contact information here, such as office hour, parking spot, direction, etc.</p>\r\n<p>Change this text in Admin &gt; Page Manager</p>',	'admin',	'',	'0',	1366442727,	0.00,	0,	'0',	0,	'',	'',	0,	'0',	'P',	'page_default.tpl'),
('GENPG',	1,	7,	'terms-and-conditions.php',	'',	'2011-11-11',	'00:00:00',	1320944400,	'Terms &amp; Conditions',	'',	'<p>Welcome to our website. If you continue to browse and use this website, you are agreeing to comply with and be bound by the following terms and conditions of use, which together with our privacy policy govern [business name]\'s relationship with you in relation to this website. If you disagree with any part of these terms and conditions, please do not use our website.</p>\r\n<p>The term \'[business name]\' or \'us\' or \'we\' refers to the owner of the website whose registered office is [address]. Our company registration number is [company registration number and place of registration]. The term \'you\' refers to the user or viewer of our website.</p>\r\n<p>The use of this website is subject to the following terms of use:</p>\r\n<ul>\r\n<li>The content of the pages of this website is for your general information and use only. It is subject to change without notice.</li>\r\n<li>This website uses cookies to monitor browsing preferences. If you do allow cookies to be used, the following personal information may be stored by us for use by third parties: [insert list of information].</li>\r\n<li>Neither we nor any third parties provide any warranty or guarantee as to the accuracy, timeliness, performance, completeness or suitability of the information and materials found or offered on this website for any particular purpose. You acknowledge that such information and materials may contain inaccuracies or errors and we expressly exclude liability for any such inaccuracies or errors to the fullest extent permitted by law.</li>\r\n<li>Your use of any information or materials on this website is entirely at your own risk, for which we shall not be liable. It shall be your own responsibility to ensure that any products, services or information available through this website meet your specific requirements.</li>\r\n<li>This website contains material which is owned by or licensed to us. This material includes, but is not limited to, the design, layout, look, appearance and graphics. Reproduction is prohibited other than in accordance with the copyright notice, which forms part of these terms and conditions.</li>\r\n<li>All trade marks reproduced in this website which are not the property of, or licensed to, the operator are acknowledged on the website.</li>\r\n<li>Unauthorised use of this website may give rise to a claim for damages and/or be a criminal offence.</li>\r\n<li>From time to time this website may also include links to other websites. These links are provided for your convenience to provide further information. They do not signify that we endorse the website(s). We have no responsibility for the content of the linked website(s).</li>\r\n<li>Your use of this website and any dispute arising out of such use of the website is subject to the laws of England, Northern Ireland,&nbsp;Scotland and Wales.</li>\r\n</ul>',	'admin',	'',	'1',	1366442731,	0.00,	0,	'1',	30,	'',	'',	0,	'0',	'P',	'page_default.tpl'),
('GENPG',	1,	8,	'powered-by-qengine.php',	'',	'2011-11-11',	'00:00:00',	1320944400,	'Powered by qEngine',	'',	'<p>This site is using qEngine CMS, a simple CMS engine created by <a href=\"http://www.c97.net\">C97.net</a>. qEngine is very easy to use &amp; maintain, no need to understand PHP, and it\'s <strong>FREE!</strong> If you are interested to use this awesome script please visit <a href=\"http://www.c97.net\">www.c97.net</a> now!</p>',	'admin',	'',	'1',	1366442735,	0.00,	0,	'1',	24,	'',	'',	0,	'0',	'P',	'page_default.tpl'),
('NEWS',	2,	9,	'news/site-is-now-up-and-ready.php',	'',	'2011-11-11',	'00:00:00',	1320966000,	'Site is Now Up &amp; Ready',	'',	'<h2>Congratulations!</h2>\r\n<p>You have succesfully installed qEngine!<br />To learn more about qEngine, please visit <a href=\"http://www.c97.net\" target=\"_blank\">www.c97.net</a>.<br /><br />(To remove this message, go to ACP &gt; Contents &gt; Manage Contents)</p>',	'admin',	'',	'0',	1469804396,	0.00,	0,	'1',	83,	'',	'',	0,	'0',	'P',	'page_default.tpl'),
('QBANR',	0,	10,	'',	'banner2.jpg',	'0000-00-00',	'00:00:00',	0,	'The Banner',	'#',	'This page is part of qBanner module. Please use qBanner Manager to edit this page.',	'',	'',	'',	0,	0.00,	0,	'',	0,	'',	'',	0,	'0',	'P',	''),
('SSHOW',	0,	11,	'',	'slide1.jpg',	'0000-00-00',	'00:00:00',	0,	'Change this content from ACP',	'#',	'This page is part of SlideShow module. Please use SlideShow Manager to edit this page.',	'',	'',	'',	0,	0.00,	0,	'',	0,	'',	'',	0,	'0',	'P',	''),
('SSHOW',	0,	12,	'',	'slide2.jpg',	'0000-00-00',	'00:00:00',	0,	'The Mountain',	'#',	'This page is part of SlideShow module. Please use SlideShow Manager to edit this page.',	'',	'',	'',	0,	0.00,	0,	'',	0,	'',	'',	0,	'0',	'P',	''),
('SSHOW',	0,	13,	'',	'slide3.jpg',	'0000-00-00',	'00:00:00',	0,	'The city',	'#',	'This page is part of SlideShow module. Please use SlideShow Manager to edit this page.',	'',	'',	'',	0,	0.00,	0,	'',	0,	'',	'',	0,	'0',	'P',	'');

INSERT INTO `__PREFIX__page_cat` (`idx`, `group_id`, `parent_id`, `permalink`, `cat_name`, `cat_details`, `cat_image`) VALUES
(1,	'GENPG',	0,	'general-pages.php',	'General Pages',	'<p>General Pages</p>',	''),
(2,	'NEWS',	0,	'news.php',	'General News',	'<p>General News</p>',	'');

INSERT INTO `__PREFIX__page_group` (`idx`, `group_id`, `group_title`, `group_notes`, `all_cat_list`, `cat_list`, `page_cat`, `page_image`, `page_image_size`, `page_thumb`, `page_gallery`, `page_gallery_thumb`, `page_author`, `page_comment`, `page_attachment`, `page_date`, `page_folder`, `page_sort`, `group_template`, `page_template`, `hidden_private`) VALUES
(1,	'GENPG',	'Common Page',	'General pages, eg: company history, about you, etc. (please do NOT remove this content type, you can edit this message in ACP &gt; Contents &gt; Manage Types)',	'1',	'1',	'1',	'1',	500,	200,	'1',	200,	'1',	'pagecomment',	'0',	'0',	'',	't',	'body_default.tpl',	'page_default.tpl',	'0'),
(2,	'NEWS',	'News',	'Site news (please do NOT remove this content type, you can edit this message in ACP &gt; Contents &gt; Manage Types)',	'1',	'1',	'1',	'1',	500,	200,	'0',	0,	'0',	'0',	'0',	'1',	'news',	't',	'body_news.tpl',	'page_default.tpl',	'0'),
(3,	'QBANR',	'qBanner',	'qBanner module storage',	'0',	'0',	'0',	'1',	0,	0,	'0',	0,	'0',	'0',	'',	'0',	'',	't',	'body_default.tpl',	'page_default.tpl',	'1'),
(4,	'SSHOW',	'Slideshow',	'Slideshow module storage',	'0',	'0',	'0',	'1',	0,	0,	'0',	0,	'0',	'0',	'',	'0',	'',	't',	'body_default.tpl',	'page_default.tpl',	'1');

INSERT INTO `__PREFIX__permalink` (`idx`, `url`, `target_script`, `target_idx`, `target_param`) VALUES
(1,	'welcome.php',	'page.php',	'1',	''),
(2,	'privacy-policy.php',	'page.php',	'2',	''),
(3,	'faqs.php',	'page.php',	'3',	''),
(4,	'about-us.php',	'page.php',	'4',	''),
(5,	'contact-us.php',	'page.php',	'6',	''),
(6,	'terms-and-conditions.php',	'page.php',	'7',	''),
(7,	'powered-by-qengine.php',	'page.php',	'8',	''),
(8,	'news/site-is-now-up-and-ready.php',	'page.php',	'9',	''),
(9,	'general-pages.php',	'page.php',	'1',	'list'),
(10,	'news.php',	'page.php',	'2',	'list');

INSERT INTO `__PREFIX__qcomment_set` (`group_id`, `comment_mode`, `comment_approval`, `member_only`, `unique_comment`, `comment_helpful`, `comment_on_comment`, `captcha`, `detail`, `mod_id`, `notes`) VALUES
(1,	'2',	'0',	'0',	'0',	'0',	'1',	'0',	'0',	'conc',	'Comments on comments'),
(3,	'2',	'1',	'0',	'0',	'0',	'1',	'0',	'1',	'pagecomment',	'Page Comment');