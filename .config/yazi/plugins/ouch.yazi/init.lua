local M = {}

function M:peek()
  local child = Command("ouch")
      :args({ "l", "-t", "-y", tostring(job.file.url) })
      :stdout(Command.PIPED)
      :stderr(Command.PIPED)
      :spawn()
  local limit = job.area.h
  local file_name = string.match(tostring(job.file.url), ".*[/\\](.*)")
  local lines = string.format("\x1b[2m📁 %s\x1b[0m\n", file_name)
  local num_lines = 1
  local num_skip = 0
  repeat
    local line, event = child:read_line()
    if event == 1 then
      ya.err(tostring(event))
    elseif event ~= 0 then
      break
    end

    if line:find('Archive', 1, true) ~= 1 and line:find('[INFO]', 1, true) ~= 1 then
      if num_skip >= job.skip then
        lines = lines .. line
        num_lines = num_lines + 1
      else
        num_skip = num_skip + 1
      end
    end
  until num_lines >= limit

  child:start_kill()
  if job.skip > 0 and num_lines < limit then
    ya.manager_emit(
      "peek",
      { tostring(math.max(0, job.skip - (limit - num_lines))), only_if = tostring(job.file.url), upper_bound = "" }
    )
  else
    ya.preview_widgets(job, { ui.Paragraph.parse(job.area, lines) })
  end
end

function M:seek(units)
  local h = cx.active.current.hovered
  if h and h.url == job.file.url then
    local step = math.floor(units * job.area.h / 10)
    ya.manager_emit("peek", {
      math.max(0, cx.active.preview.skip + step),
      only_if = tostring(job.file.url),
    })
  end
end

return M
