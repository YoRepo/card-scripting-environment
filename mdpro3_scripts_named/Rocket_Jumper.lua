--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 火箭弹跳手  (ID: 53890795)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 3
-- ATK 1000 | DEF 800
--
-- Effect Text:
-- 当对方场上只有守备表示的怪兽存在时，这张卡可以对对方进行直接攻击。
--[[ __CARD_HEADER_END__ ]]

--ロケット・ジャンパー
function c53890795.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c53890795.dircon)
	c:RegisterEffect(e1)
end
function c53890795.dircon(e)
	local tp=e:GetHandler():GetControler()
	return Duel.GetFieldGroupCount(tp,0,LOCATION_SZONE)==0
		and not Duel.IsExistingMatchingCard(Card.IsAttackPos,tp,0,LOCATION_MZONE,1,nil)
end
