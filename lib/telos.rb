module Telos
  autoload :Message, "telos/message.rb"
  autoload :Device, "telos/device.rb"

  module Command
    Login = 0
    EnumerateShows = 1
    EnumerateHostsForShow = 2
    ConnectToShow = 4
    ChangeShow = 3
    EnumerateDirectors = 5
    AttachToDirector = 6
    AttachAsTalent = 7
    PostBusyAllButton = 8
    PostDelayDumpButton = 9
    PostDialKey = 10
    PostDropButton = 11
    PostHoldButton = 12
    PostLineButton = 13
    PostMuteButton = 14
    PostNextButton = 15
    PostRecordButton = 16
    PostSpeakerButton = 17
    PostText = 18
    PostTransferButton = 19
    PostUpdateAll = 20
    PostMuteRinger = 22
    PostAcousticAddapt = 23
  end
end