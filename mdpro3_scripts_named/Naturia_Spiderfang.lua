--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 自然蜘蛛牙  (ID: 25654671)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 4
-- ATK 2100 | DEF 400
-- Setcode: 42
--
-- Effect Text:
-- 这张卡若不在对方把魔法·陷阱·效果怪兽的效果发动的回合则不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・スパイダーファング
function c25654671.initial_effect(c)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetCondition(c25654671.atkcon)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(25654671,ACTIVITY_CHAIN,aux.FALSE)
end
function c25654671.atkcon(e)
	return Duel.GetCustomActivityCount(25654671,1-e:GetHandlerPlayer(),ACTIVITY_CHAIN)==0
end
