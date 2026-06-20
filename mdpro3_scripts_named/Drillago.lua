--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 钢钻龙  (ID: 99050989)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1600 | DEF 1100
--
-- Effect Text:
-- 对方场上只有表侧表示的攻击力1600以上的怪兽存在的场合，这张卡可以对对方玩家进行直接攻击。
--[[ __CARD_HEADER_END__ ]]

--ドリラゴ
function c99050989.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c99050989.dircon)
	c:RegisterEffect(e1)
end
function c99050989.filter(c)
	return c:GetAttack()<1600 or c:IsFacedown()
end
function c99050989.dircon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetFieldGroupCount(tp,0,LOCATION_SZONE)==0
		and not Duel.IsExistingMatchingCard(c99050989.filter,tp,0,LOCATION_MZONE,1,nil)
end
