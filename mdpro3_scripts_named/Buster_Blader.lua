--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 破坏之剑士  (ID: 78193831)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 7
-- ATK 2600 | DEF 2300
-- Setcode: 215
--
-- Effect Text:
-- ①：这张卡的攻击力上升对方的场上·墓地的龙族怪兽数量×500。
--[[ __CARD_HEADER_END__ ]]

--バスター・ブレイダー
function c78193831.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c78193831.val)
	c:RegisterEffect(e1)
end
function c78193831.val(e,c)
	return Duel.GetMatchingGroupCount(c78193831.filter,c:GetControler(),0,LOCATION_GRAVE+LOCATION_MZONE,nil)*500
end
function c78193831.filter(c)
	return c:IsRace(RACE_DRAGON) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
