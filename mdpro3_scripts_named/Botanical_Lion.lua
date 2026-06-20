--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 植物狮子  (ID: 20546916)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 4
-- ATK 1600 | DEF 2000
--
-- Effect Text:
-- 自己场上表侧表示存在的植物族怪兽每有1只，这张卡的攻击力上升300。这张卡只要在场上表侧表示存在，控制权不能变更。
--[[ __CARD_HEADER_END__ ]]

--ボタニカル・ライオ
function c20546916.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c20546916.val)
	c:RegisterEffect(e1)
	--control
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e2)
end
function c20546916.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c20546916.val(e,c)
	return Duel.GetMatchingGroupCount(c20546916.filter,c:GetControler(),LOCATION_MZONE,0,nil)*300
end
