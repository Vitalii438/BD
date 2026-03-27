USE CableTV;

WITH TariffChannels AS (
    SELECT Tariffs.TariffName, Channels.ChannelName
    FROM Tariffs
    LEFT JOIN Channels ON Tariffs.TariffID = Channels.TariffID
)
SELECT * FROM TariffChannels;

--SELECT * FROM Tariffs;