defmodule SuperTiger.DeviceView do
  use SuperTiger.Web, :view

  def render("index.json", %{devices: devices}) do
    %{data: render_many(devices, SuperTiger.DeviceView, "device.json")}
  end

  def render("show.json", %{device: device}) do
    %{data: render_one(device, SuperTiger.DeviceView, "device.json")}
  end

  def render("device.json", %{device: device}) do
    %{id: device.id,
      platform: device.platform,
      token: device.token,
      uuid: device.uuid}
  end
end
