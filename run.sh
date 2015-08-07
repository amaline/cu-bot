GITHUB_SECRET=$GITHUB_SECRET node hook.js 2>&1 > hook.log &
HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN ./bin/hubot --adapter slack --alias !
