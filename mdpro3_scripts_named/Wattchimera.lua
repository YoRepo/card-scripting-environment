--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 电气奇美拉  (ID: 2772236)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Thunder
-- Level 6
-- ATK 1400 | DEF 1200
-- Setcode: 14
--
-- Effect Text:
-- 名字带有「电气」的调整＋调整以外的雷族怪兽1只以上
-- 这张卡可以直接攻击对方玩家。这张卡直接攻击给与对方基本分战斗伤害时，对方手卡随机1张到卡组最上面放置。
--[[ __CARD_HEADER_END__ ]]

--エレキマイラ
function c2772236.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xe),aux.NonTuner(Card.IsRace,RACE_THUNDER),1)
	c:EnableReviveLimit()
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--handes
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2772236,0))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c2772236.condition)
	e2:SetTarget(c2772236.target)
	e2:SetOperation(c2772236.operation)
	c:RegisterEffect(e2)
end
function c2772236.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function c2772236.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_HAND)
end
function c2772236.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoDeck(sg,nil,SEQ_DECKTOP,REASON_EFFECT)
end
