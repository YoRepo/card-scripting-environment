--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 新炎狱剑士  (ID: 91554542)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 4
-- ATK 1500 | DEF 200
-- Setcode: 44
--
-- Effect Text:
-- 对方墓地存在的卡是4张以下的场合，这张卡的攻击力上升600。对方墓地存在的卡是8张以上的场合，这张卡的攻击力下降300。
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
