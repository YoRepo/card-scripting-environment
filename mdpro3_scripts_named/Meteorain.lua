--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 流星雨  (ID: 64274292)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个回合自己怪兽攻击守备表示的怪兽时，若攻击力超过那个守备力，给与对方那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--メテオ・レイン
function c64274292.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c64274292.condition)
	e1:SetOperation(c64274292.activate)
	c:RegisterEffect(e1)
end
function c64274292.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c64274292.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
