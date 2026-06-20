--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 冰结界的守护阵  (ID: 82498947)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 200 | DEF 1600
-- Setcode: 47
--
-- Effect Text:
-- ①：只要自己场上有其他的「冰结界」怪兽存在，持有这张卡的守备力以上的攻击力的对方怪兽不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--氷結界の守護陣
function c82498947.initial_effect(c)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c82498947.tg)
	e1:SetCondition(c82498947.con)
	c:RegisterEffect(e1)
end
function c82498947.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2f)
end
function c82498947.con(e)
	return Duel.IsExistingMatchingCard(c82498947.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c82498947.tg(e,c)
	return c:GetAttack()>=e:GetHandler():GetDefense()
end
