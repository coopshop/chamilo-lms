<div class ="row">

{% if bbb_status == true %}
    <div class ="col-md-12" style="text-align:center">
        {{ form }}
        {% if show_join_button == true %}
            <p>
                <a href="{{ conference_url }}" target="_blank" class="btn btn-primary btn-large">
                    {{ 'EnterConference'| get_plugin_lang('BBBPlugin') }}
                </a>
                <span id="users_online" class="label label-warning">
                    {{ 'XUsersOnLine'| get_plugin_lang('BBBPlugin') | format(users_online) }}
                </span>
            </p>
            {% if max_users_limit > 0 %}
                {% if conference_manager == true %}
                    <p>{{ 'MaxXUsersWarning' | get_plugin_lang('BBBPlugin') | format(max_users_limit) }}</p>
                {% elseif users_online >= max_users_limit/2 %}
                    <p>{{ 'MaxXUsersWarning' | get_plugin_lang('BBBPlugin') | format(max_users_limit) }}</p>
                {% endif %}
            {% endif %}
            <div class="well">
                <strong>{{ 'UrlMeetingToShare'| get_plugin_lang('BBBPlugin') }}</strong>
                <input type="text" class="form-control text-center" readonly value="{{ conference_url }}">
            </div>
        {% elseif max_users_limit > 0 %}
            {% if conference_manager == true %}
                <p>{{ 'MaxXUsersReachedManager' | get_plugin_lang('BBBPlugin') | format(max_users_limit) }}</p>
            {% elseif users_online > 0 %}
                <p>{{ 'MaxXUsersReached' | get_plugin_lang('BBBPlugin') | format(max_users_limit) }}</p>
            {% endif %}
        {% endif %}
    </div>

    <div class ="col-md-12">
        <div class="page-header">
            <h2>{{ 'RecordList'| get_plugin_lang('BBBPlugin') }}</h2>
        </div>

        <table class="table">
            <tr>
                <!-- th>#</th -->
                <th>{{ 'CreatedAt'|get_lang }}</th>
                <th>{{ 'Status'| get_lang }}</th>
                <th>{{ 'Records'| get_plugin_lang('BBBPlugin') }}</th>

                {% if allow_to_edit  %}
                    <th>{{ 'Actions'| get_lang }}</th>
                {% endif %}

            </tr>
            {% for meeting in meetings %}
            <tr>
                <!-- td>{{ meeting.id }}</td -->
                {% if meeting.visibility == 0 %}
                    <td class="muted">{{ meeting.created_at }}</td>
                {% else %}
                    <td>{{ meeting.created_at }}</td>
                {% endif %}
                <td>
                    {% if meeting.status == 1 %}
                        <span class="label label-success">{{ 'MeetingOpened'|get_plugin_lang('BBBPlugin') }}</span>
                    {% else %}
                        <span class="label label-info">{{ 'MeetingClosed'|get_plugin_lang('BBBPlugin') }}</span>
                    {% endif %}
                </td>
                <td>
                    {% if meeting.record == 1 %}
                        {# Record list #}
                        {{ meeting.show_links }}
                    {% else %}
                        {{ 'NoRecording'|get_plugin_lang('BBBPlugin') }}
                    {% endif %}
                </td>

                {% if allow_to_edit %}
                    <td>
                    {% if meeting.status == 1 %}
                        <a class="btn btn-default" href="{{ meeting.end_url }} "> {{ 'CloseMeeting'|get_plugin_lang('BBBPlugin') }}</a>
                    {% else %}
                        {{ meeting.action_links }}
                    {% endif %}
                    </td>
                {% endif %}

            </tr>
            {% endfor %}
        </table>
    </div>
{% else %}
    <div class ="col-md-12" style="text-align:center">
        {{ 'ServerIsNotRunning' | return_message('warning') }}
    </div>
{% endif %}
</div>
