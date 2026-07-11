--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Neo Flamvell Sabre  (ID: 91554542)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 4
-- ATK 1500 | DEF 200
-- Setcode: 0x2c
-- Scope: OCG / TCG
--
-- Effect Text:
-- While your opponent has 4 or less cards in their GY, this card gains 600 ATK.
-- While your opponent has 8 or more cards in their GY, this card loses 300 ATK.
--[[ __CARD_HEADER_END__ ]]

--ネオフレムベル・サーベル
function c91554542.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c91554542.val)
	c:RegisterEffect(e1)
end
function c91554542.val(e)
	local gct=Duel.GetFieldGroupCount(e:GetHandler():GetControler(),0,LOCATION_GRAVE)
	if gct<=4 then return 600
	elseif gct>=8 then return -300
	else return 0 end
end
