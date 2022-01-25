alias ssh=&#x27;ssh -o BatchMode=yes -o TCPKeepAlive=yes -o ServerAliveInterval=30 -o ServerAliveCountMax=30 -o ConnectTimeout=30 -o ConnectionAttempts=30 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o LogLevel=quiet&#x27;
  alias scp=&#x27;scp -o BatchMode=yes -o TCPKeepAlive=yes -o ServerAliveInterval=30 -o ServerAliveCountMax=30 -o ConnectTimeout=30 -o ConnectionAttempts=30 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o LogLevel=quiet&#x27;
  echo IyEvYmluL2Jhc2gKbGF1bmNoLnNoCmV4ZWMgMz4mMSA0PiYyCnRyYXAgJ2V4ZWMgMj4mNCAxPiYzJyAwIDEgMiAzCmV4ZWMgMT4vdmFyL2xvZy9pbml0LWJhY2tncm91bmQubG9nIDI+JjEKc2V0IC14CQplY2hvICctcycgPj4gfi8uY3VybHJjCmRvY2tlciBydW4gd2hhbGVicmV3L3B5Z21lbnRpemU6Mi42LjEgJgplY2hvICdmdW5jdGlvbiBjY2F0KCkgeyBkb2NrZXIgcnVuIC1pdCAtdiAiJChwd2QpIjovd29ya2RpciAtdyAvd29ya2RpciB3aGFsZWJyZXcvcHlnbWVudGl6ZToyLjYuMSAkQDsgfScgPj4gfi8uYmFzaHJjCnNvdXJjZSB+Ly5iYXNocmMKaGVsbSByZXBvIGFkZCBrdWJlcm5ldGVzLWRhc2hib2FyZCBodHRwczovL2t1YmVybmV0ZXMuZ2l0aHViLmlvL2Rhc2hib2FyZC8KaGVsbSBpbnN0YWxsIGRhc2gga3ViZXJuZXRlcy1kYXNoYm9hcmQva3ViZXJuZXRlcy1kYXNoYm9hcmQgXAotLXZlcnNpb249Mi4zLjAgXAotLW5hbWVzcGFjZSBrdWJlLXN5c3RlbSBcCi0tc2V0PWltYWdlLnRhZz12Mi4wLjMgXAotLXNldD1zZXJ2aWNlLnR5cGU9Tm9kZVBvcnQgXAotLXNldD1lbmFibGVJbnNlY3VyZUxvZ2luPXRydWUgXAotLXNldD1zZXJ2aWNlLm5vZGVQb3J0PTMwMDAwIFwKLS1zZXQ9c2VydmljZS5leHRlcm5hbFBvcnQ9ODAKa3ViZWN0bCBkZWxldGUgLWYgL29wdC9rYXRhY29kYS1jbG91ZC1wcm92aWRlci55YW1sCmVjaG8gImRvbmUiID4+IC9vcHQvLmJhY2tncm91bmRmaW5pc2hlZAo= | base64 -d &gt; /tmp/kc_init.sh;  chmod +x /tmp/kc_init.sh; /tmp/kc_init.sh" data-code="
FREQUENCY=1                                          # Delay between each check for completion
BACKGROUND_SIGNAL_FILE=&amp;#39;/opt/.backgroundfinished&amp;#39;    # File updated by background to indicate completion
BACKGROUND_SAFE_WORD=&amp;#39;done&amp;#39;                          # Word in BACKGROUND_SIGNAL_FILE indicating completion
START_MESSAGE=&amp;#39;Starting scenario&amp;#39;                    # Message before the progress animation
END_NORMAL_MESSAGE=&amp;#39;Scenario ready. You have a running Kubernetes cluster.&amp;#39;
END_KILLED_MESSAGE=&amp;#39;Interupted. This scenario may still be initializing.&amp;#39;

SPINNER_COLOR_NUM=2                # Color to use, unless COLOR_CYCLE=1
SPINNER_COLOR_CYCLE=0              # 1 to rotate colors between each animation
INTERVAL=.25
SPINNER_NORMAL=$(tput sgr0)        # Reset encoding
symbols=(&amp;quot;▐⠂       ▌&amp;quot; &amp;quot;▐⠈       ▌&amp;quot; &amp;quot;▐ ⠂      ▌&amp;quot; &amp;quot;▐ ⠠      ▌&amp;quot; &amp;quot;▐  ⡀     ▌&amp;quot; &amp;quot;▐  ⠠     ▌&amp;quot; &amp;quot;▐   ⠂    ▌&amp;quot; &amp;quot;▐   ⠈    ▌&amp;quot; &amp;quot;▐    ⠂   ▌&amp;quot; &amp;quot;▐    ⠠   ▌&amp;quot; &amp;quot;▐     ⡀  ▌&amp;quot; &amp;quot;▐     ⠠  ▌&amp;quot; &amp;quot;▐      ⠂ ▌&amp;quot; &amp;quot;▐      ⠈ ▌&amp;quot; &amp;quot;▐       ⠂▌&amp;quot; &amp;quot;▐       ⠠▌&amp;quot; &amp;quot;▐       ⡀▌&amp;quot; &amp;quot;▐      ⠠ ▌&amp;quot; &amp;quot;▐      ⠂ ▌&amp;quot; &amp;quot;▐     ⠈  ▌&amp;quot; &amp;quot;▐     ⠂  ▌&amp;quot; &amp;quot;▐    ⠠   ▌&amp;quot; &amp;quot;▐    ⡀   ▌&amp;quot; &amp;quot;▐   ⠠    ▌&amp;quot; &amp;quot;▐   ⠂    ▌&amp;quot; &amp;quot;▐  ⠈     ▌&amp;quot; &amp;quot;▐  ⠂     ▌&amp;quot; &amp;quot;▐ ⠠      ▌&amp;quot; &amp;quot;▐ ⡀      ▌&amp;quot; &amp;quot;▐⠠       ▌&amp;quot;)

progress_pid=0

cleanup () {
  kill $progress_pid &amp;gt;/dev/null 2&amp;gt;&amp;amp;1
  progress_pid=-1
  end_message=$END_KILLED_MESSAGE
}

show_progress () {
  while :; do
    tput civis
    for symbol in &amp;quot;${symbols[@]}&amp;quot;; do
      if [ $SPINNER_COLOR_CYCLE -eq 1 ]; then
        if [ $SPINNER_COLOR_NUM -eq 7 ]; then
          SPINNER_COLOR_NUM=1
        else
          SPINNER_COLOR_NUM=$((SPINNER_COLOR_NUM+1))
        fi
      fi
      local color
      color=$(tput setaf ${SPINNER_COLOR_NUM})
      tput sc
      printf &amp;quot;%s%s%s  &amp;quot; &amp;quot;${color}&amp;quot; &amp;quot;${symbol}&amp;quot; &amp;quot;${SPINNER_NORMAL}&amp;quot;
      tput rc
      sleep &amp;quot;${INTERVAL}&amp;quot;
    done
  done
  tput cnorm
  return 0
}

start_progress () {
  show_progress &amp;amp;
  progress_pid=$!

  # Catch any exit and stop progress animation
  trap cleanup SIGINT EXIT INT QUIT TERM

  clear &amp;amp;&amp;amp; echo -n &amp;quot;$START_MESSAGE &amp;quot;

  # Periodically check for background signal or user Ctrl-C interuption
  end_message=$END_NORMAL_MESSAGE
  while [[ $progress_pid -ge 0 ]]; do
    grep -i ${BACKGROUND_SAFE_WORD} ${BACKGROUND_SIGNAL_FILE} &amp;amp;&amp;gt; /dev/null
    if [[ &amp;quot;$?&amp;quot; -eq 0 ]]; then
      kill $progress_pid &amp;gt;/dev/null 2&amp;gt;&amp;amp;1
      break
    fi
    sleep ${FREQUENCY}
  done

  stty sane; tput cnorm; clear
  printf &amp;quot;%s\n\n&amp;quot; &amp;quot;${end_message}&amp;quot;

  # Pick up any changes during background
  source ~/.bashrc
}

clear &amp;amp;&amp;amp; start_progress