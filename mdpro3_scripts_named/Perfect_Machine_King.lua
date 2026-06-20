--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 完美机械王  (ID: 18891691)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 8
-- ATK 2700 | DEF 1500
--
-- Effect Text:
-- 场上存在的这张卡以外的机械族怪兽每有1只，这张卡的攻击力上升500。
--[[ __CARD_HEADER_END__ ]]

--パーフェクト機械王
function c18891691.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c18891691.val)
	c:RegisterEffect(e1)
end
function c18891691.val(e,c)
	return Duel.GetMatchingGroupCount(c18891691.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())*500
end
function c18891691.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
