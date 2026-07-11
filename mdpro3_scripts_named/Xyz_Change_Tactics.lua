--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Xyz Change Tactics  (ID: 11705261)
-- Type: Spell / Continuous
-- Setcode: 0x73
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a "Utopia" monster is Xyz Summoned to your field: You can pay 500 LP; draw 1 card.
-- You can only control 1 "Xyz Change Tactics".
--[[ __CARD_HEADER_END__ ]]

--エクシーズ・チェンジ・タクティクス
function c11705261.initial_effect(c)
	c:SetUniqueOnField(1,0,11705261)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11705261,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c11705261.condition)
	e2:SetCost(c11705261.cost)
	e2:SetTarget(c11705261.target)
	e2:SetOperation(c11705261.operation)
	c:RegisterEffect(e2)
end
function c11705261.filter(c,tp)
	return c:IsSetCard(0x107f) and c:IsControler(tp) and c:IsSummonType(SUMMON_TYPE_XYZ)
end
function c11705261.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c11705261.filter,1,nil,tp)
end
function c11705261.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c11705261.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c11705261.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
