--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 链击者  (ID: 88190453)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level 4
-- ATK 1000 | DEF 600
--
-- Effect Text:
-- 这张卡可以在通常的攻击之外再增加和自己墓地存在的「链击者」相同的数目，在同1次的战斗阶段中进行攻击。
--[[ __CARD_HEADER_END__ ]]

--チェイン・スラッシャー
function c88190453.initial_effect(c)
	--multiattack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(c88190453.val)
	c:RegisterEffect(e1)
end
function c88190453.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,88190453)
end
