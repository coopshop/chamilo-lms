<?php
/* For licensing terms, see /license.txt */

use Chamilo\CoreBundle\Component\Utils\ChamiloApi;

$cidReset = true;

require_once __DIR__.'/../inc/global.inc.php';

api_block_anonymous_users();

$current_course_tool = TOOL_CALENDAR_EVENT;
$this_section = SECTION_MYAGENDA;

$timezone = new DateTimeZone(api_get_timezone());
$now = new DateTime('now', $timezone);
$currentYear = (int) $now->format('Y');

$searchYear = isset($_GET['year']) ? (int) $_GET['year'] : $currentYear;

$userInfo = api_get_user_info();
$userId = $userInfo['id'];

$sessions = [];

if (api_is_drh()) {
    $count = SessionManager::get_sessions_followed_by_drh($userId, null, null, true);
} else {
    $count = UserManager::get_sessions_by_category($userId, false, true, true, true);
}

$sessionsList = UserManager::getSubscribedSessionsByYear($userInfo, $searchYear);

if ($count > 50) {
    $message = Display::return_message('TooMuchSessionsInPlanification', 'warning');

    api_not_allowed(true, $message);
}

$sessions = UserManager::getSessionsCalendarByYear($sessionsList, $searchYear);

$colors = ChamiloApi::getColorPalette(false, true, count($sessions));

$toolName = get_lang('ViewSessionsPlanification');

$template = new Template($toolName);
$template->assign('student_id', $userId);
$template->assign('search_year', $searchYear);
$template->assign('colors', $colors);
$template->assign('sessions', $sessions);
$layout = $template->get_template('agenda/planification.tpl');
$template->display($layout);
