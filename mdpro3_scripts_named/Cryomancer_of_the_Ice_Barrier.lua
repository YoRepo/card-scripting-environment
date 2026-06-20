--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 冰结界的术者  (ID: 23950192)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Aqua
-- Level 2
-- ATK 1300 | DEF 0
-- Setcode: 47
--
-- Effect Text:
-- ①：只要自己场上有其他的「冰结界」怪兽存在，4星以上的怪兽不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--氷結界の術者
function c23950192.initial_effect(c)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c23950192.tg)
	e2:SetCondition(c23950192.con)
	c:RegisterEffect(e2)
end
function c23950192.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2f)
end
function c23950192.con(e)
	return Duel.IsExistingMatchingCard(c23950192.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c23950192.tg(e,c)
	return c:IsLevelAbove(4)
end
