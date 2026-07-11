--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Black Horn of Heaven  (ID: 50323155)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent would Special Summon exactly 1 monster: Negate the Special Summon, and if you do,
-- destroy it.
--[[ __CARD_HEADER_END__ ]]

--昇天の黒角笛
function c50323155.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c50323155.condition)
	e1:SetTarget(c50323155.target)
	e1:SetOperation(c50323155.activate)
	c:RegisterEffect(e1)
end
function c50323155.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and eg:GetCount()==1 and aux.NegateSummonCondition()
end
function c50323155.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c50323155.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
