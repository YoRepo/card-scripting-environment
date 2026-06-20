--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 暗黑恐兽  (ID: 38670435)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 7
-- ATK 2600 | DEF 1800
--
-- Effect Text:
-- 当对方场上仅有守备表示的怪兽存在时，这张卡可以对对方进行直接攻击。
--[[ __CARD_HEADER_END__ ]]

--暗黒恐獣
function c38670435.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c38670435.dircon)
	c:RegisterEffect(e1)
end
function c38670435.dircon(e)
	local tp=e:GetHandler():GetControler()
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_MZONE,1,nil,TYPE_SPELL+TYPE_TRAP)
		and not Duel.IsExistingMatchingCard(Card.IsAttackPos,tp,0,LOCATION_MZONE,1,nil)
end
