--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Performapal Show Down  (ID: 92958307)
-- Type: Trap
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target any number of face-up monsters your opponent controls, up to the number of face-up Spell
-- Cards you control; change those monsters to face-down Defense Position.
--[[ __CARD_HEADER_END__ ]]

--EMショーダウン
function c92958307.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(TIMING_BATTLE_PHASE,TIMINGS_CHECK_MONSTER+TIMING_BATTLE_PHASE)
	e1:SetTarget(c92958307.target)
	e1:SetOperation(c92958307.activate)
	c:RegisterEffect(e1)
end
function c92958307.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL)
end
function c92958307.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c92958307.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local sc=Duel.GetMatchingGroupCount(c92958307.cfilter,tp,LOCATION_ONFIELD,0,nil)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c92958307.filter(chkc) end
	if chk==0 then return sc>0 and Duel.IsExistingTarget(c92958307.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c92958307.filter,tp,0,LOCATION_MZONE,1,sc,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c92958307.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
	end
end
