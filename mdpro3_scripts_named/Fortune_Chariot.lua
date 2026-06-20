--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 命运之战车  (ID: 39299733)
-- Type: Monster / Effect / Union
-- Attribute: WIND
-- Race: Fairy
-- Level 6
-- ATK 1000 | DEF 2000
-- Setcode: 290
--
-- Effect Text:
-- 这个卡名在规则上也当作「女武神」卡使用。
-- ①：1回合1次，可以从以下效果选择1个发动。
-- ●以自己场上1只天使族怪兽为对象，把这张卡当作装备卡使用给那只怪兽装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备的这张卡特殊召唤。
-- ②：装备怪兽可以直接攻击。那次直接攻击给与对方的战斗伤害变成一半。
--[[ __CARD_HEADER_END__ ]]

--運命の戦車
function c39299733.initial_effect(c)
	aux.EnableUnionAttribute(c,c39299733.filter)
	--direct attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e5)
	--damage reduce
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e6:SetCondition(c39299733.rdcon)
	e6:SetValue(aux.ChangeBattleDamage(1,HALF_DAMAGE))
	c:RegisterEffect(e6)
end
function c39299733.filter(c)
	return c:IsRace(RACE_FAIRY)
end
function c39299733.rdcon(e)
	local c=e:GetHandler():GetEquipTarget()
	local tp=e:GetHandlerPlayer()
	return Duel.GetAttackTarget()==nil
		and c:GetEffectCount(EFFECT_DIRECT_ATTACK)<2 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
