--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Quiet Life  (ID: 31980955)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate this card at the start of your Main Phase 1, if you control no monsters.
-- If any player Normal Summons/Sets a monster, that player cannot Special Summon that turn.
-- If any player Special Summons a monster, that player cannot Normal Summon/Set that turn.
--[[ __CARD_HEADER_END__ ]]

--スローライフ
function c31980955.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c31980955.condition)
	c:RegisterEffect(e1)
	--summon limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetTarget(c31980955.sumlimit1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetTarget(c31980955.sumlimit2)
	c:RegisterEffect(e4)
end
function c31980955.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 and not Duel.CheckPhaseActivity()
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c31980955.sumlimit1(e,c,sump,sumtype,sumpos,targetp,se)
	return Duel.GetActivityCount(sump,ACTIVITY_SPSUMMON)>0
end
function c31980955.sumlimit2(e,c,sump,sumtype,sumpos,targetp,se)
	return Duel.GetActivityCount(sump,ACTIVITY_NORMALSUMMON)>0
end
