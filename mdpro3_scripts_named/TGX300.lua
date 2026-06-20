--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: TGX300  (ID: 58258899)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的名字带有「科技属」的怪兽每有1只，自己场上表侧表示存在的怪兽的攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--TGX300
function c58258899.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(c58258899.val)
	c:RegisterEffect(e2)
end
function c58258899.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x27)
end
function c58258899.val(e,c)
	return Duel.GetMatchingGroupCount(c58258899.filter,c:GetControler(),LOCATION_MZONE,0,nil)*300
end
