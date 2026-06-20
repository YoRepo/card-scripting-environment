--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 黑魔术少女  (ID: 38033121)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 2000 | DEF 1700
-- Setcode: 12450
--
-- Effect Text:
-- ①：这张卡的攻击力上升双方墓地的「黑魔术师」「黑混沌之魔术师」数量×300。
--[[ __CARD_HEADER_END__ ]]

--ブラック・マジシャン・ガール
function c38033121.initial_effect(c)
	aux.AddCodeList(c,46986414)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c38033121.val)
	c:RegisterEffect(e1)
end
function c38033121.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil,30208479,46986414)*300
end
