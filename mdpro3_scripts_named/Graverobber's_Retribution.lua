--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Graverobber's Retribution  (ID: 33737664)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- During each of your Standby Phases, inflict 100 points of damage to your opponent's Life Points for
-- each of your opponent's monsters that have been removed from play.
--[[ __CARD_HEADER_END__ ]]

--墓荒らしの報い
function c33737664.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_STANDBY_PHASE,0)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33737664,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCondition(c33737664.damcon)
	e2:SetTarget(c33737664.damtg)
	e2:SetOperation(c33737664.damop)
	c:RegisterEffect(e2)
end
function c33737664.damcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c33737664.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c33737664.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c33737664.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetMatchingGroupCount(c33737664.filter,tp,0,LOCATION_REMOVED,nil)*100
	Duel.Damage(p,d,REASON_EFFECT)
end
