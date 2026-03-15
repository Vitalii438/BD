USE CableTV;

SELECT Tariffs.TariffName, Channels.ChannelName
FROM Tariffs
LEFT OUTER JOIN Channels ON Tariffs.TariffID = Channels.TariffID
ORDER BY Tariffs.TariffName;