--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 冰结界的水影  (ID: 90311614)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Aqua
-- Level 2
-- ATK 1200 | DEF 800
-- Setcode: 47
--
-- Effect Text:
-- ①：自己场上的表侧表示怪兽只有2星以下的怪兽的场合，这张卡可以直接攻击。
--[[ __CARD_HEADER_END__ ]]

--氷結界の水影
function c90311614.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c90311614.dircon)
	c:RegisterEffect(e1)
end
function c90311614.filter(c)
	local lv=c:GetLevel()
	return c:IsFaceup() and (lv==0 or c:GetLevel()>2)
end
function c90311614.dircon(e)
	local tp=e:GetHandler():GetControler()
	return not Duel.IsExistingMatchingCard(c90311614.filter,tp,LOCATION_MZONE,0,1,nil)
end
